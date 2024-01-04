local vim = vim
local api = vim.api
local loop = vim.uv
local get_diagnostics = vim.lsp.diagnostic.get_all
local yanil = require("yanil")
local git = require("yanil/git")
local decorators = require("yanil/decorators")
local devicons = require("nvim-web-devicons")
local canvas = require("yanil/canvas")
local Section = require("yanil/section")
local nodelib = require("yanil/node")
local map = require("mh.mappings").map
local mapBuf = require("mh.mappings").mapBuf

local dotutil = require("mh/util")
-- local Menu = require("nui.menu")
-- local event = require("nui.utils.autocmd").event

local open_mode = loop.constants.O_CREAT + loop.constants.O_WRONLY + loop.constants.O_TRUNC

local M = {}

local function depth_indent(node)
	local text = string.rep("  ", node.depth)
	return text
end

local function git_status(node)
	if not node.parent then
		return
	end
	local git_icon, git_hl = git.get_icon_and_hl(node.abs_path)
	git_icon = git_icon or " "
	return " " .. git_icon, git_hl
end

local function lsp_diagnostics(node)
	local text = ""
	local highlight = ""
	for buf, diagnostics in pairs(get_diagnostics()) do
		if api.nvim_buf_is_valid(buf) then
			local bufname = api.nvim_buf_get_name(buf)
			if bufname == node.abs_path then
				if diagnostics ~= nil then
					text = string.format(" %d", #diagnostics)
				end
			end
		end
		return text, highlight
	end
end

local function git_diff(_, node)
	local diff = git.diff(node)
	if not diff then
		return
	end

	-- content
	local bufnr = api.nvim_create_buf(false, true)
	api.nvim_buf_set_option(bufnr, "filetype", "diff")
	api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")
	api.nvim_buf_set_option(bufnr, "swapfile", false)
	api.nvim_buf_set_lines(bufnr, 0, -1, false, diff)
	mapBuf(bufnr, "n", "q", "<CMD>exit<cr>")
	local winnr = dotutil.floating_window_big(bufnr)

	api.nvim_win_set_option(winnr, "cursorline", true)
	api.nvim_win_set_option(winnr, "winblend", 10)
	api.nvim_win_set_option(winnr, "winhl", "NormalFloat:")
	api.nvim_win_set_option(winnr, "number", true)

	api.nvim_command(string.format([[command! -buffer Apply lua require("yanil/git").apply_buf(%d)]], bufnr))
end

local function default_decorator(node)
	local text = node.name
	local hl_group = "YanilTreeFile"

	local status = git.state[node.abs_path]
	local git_hl = git.options.highlights[status]

	if node:is_dir() then
		if not node.parent then
			text = vim.fn.fnamemodify(node.name:sub(1, -2), ":.:t")
			hl_group = "YanilTreeRoot"
		else
			hl_group = node:is_link() and "YanilTreeLink" or "YanilTreeDirectory"
		end
	else
		if node:is_link() then
			hl_group = node:is_broken() and "YanilTreeLinkBroken" or "YanilTreeLink"
		elseif node.is_exec then
			hl_group = "YanilTreeFileExecutable"
		end
	end

	if git_hl == "YanilGitIgnored" then
		hl_group = git_hl
	end

	-- if node.parent then
	--   local parent_status = git.options.highlights[git.state[node.parent.abs_path]]
	--   if parent_status == 'YanilGitIgnored' then
	--     hl_group = parent_status
	--   end
	-- end

	return text, hl_group
end

local function iconDecorator(node)
	local text = ""
	local hl = ""
	-- ﯤ
	if not node.parent then
		text = ""
		hl = "YanilTreeDirectory"
	elseif node:is_dir() then
		if node:is_link() then
			text = ""
			hl = "YanilTreeLink"
		else
			-- text = node.is_open and "" or ""
			-- expander_collapsed = "",
			-- li expander_expanded = "",
			text = node.is_open and "" or ""
			hl = node:is_link() and "YanilTreeLink" or "YanilTreeDirectory"
		end
	else
		text, hl = devicons.get_icon(node.name, node.extension)
		text = text or ""
	end
	return text, hl
end

local function clear_buffer(path)
	for _, buf in pairs(api.nvim_list_bufs()) do
		if api.nvim_buf_get_name(buf) == path then
			api.nvim_command(":bwipeout! " .. buf)
		end
	end
end

local function clear_prompt()
	vim.api.nvim_command("normal :esc<CR>")
	vim.api.nvim_command("normal :esc<CR>")
end

local function toggle_zoom()
	vim.b.oldWindowSize = vim.b.oldWindowSize or vim.api.nvim_win_get_width(0)
	if vim.b.nvimTreeIsZoomed then
		vim.b.nvimTreeIsZoomed = false
		vim.cmd("silent vertical resize" .. vim.b.oldWindowSize)
	else
		vim.b.nvimTreeIsZoomed = true
		vim.cmd("silent vertical resize")
	end
end

-- FileSystem operations

local function create_dirs_if_needed(dirs)
	local parentDir = vim.fn.fnamemodify(dirs, ":h")
	local dir_split = vim.split(parentDir, "/")
	dotutil.reduce(dir_split, "", function(directories, dir)
		directories = directories .. dir .. "/"
		local stats = loop.fs_stat(directories)
		if stats == nil then
			loop.fs_mkdir(directories, 493)
		end
		return directories
	end)
end

-- Move Node
local function move_node(tree, node)
	-- node = node:is_dir() and node or node.parent
	local msg_tag = "Enter the new path for the node:"
	local msg = string.format("Rename/Move the current node \n%s \n%s", string.rep("=", 58), msg_tag)

	local original_location = node.abs_path
	local destination = vim.fn.input(msg, original_location, "file")

	clear_prompt()
	-- If cancelled
	if not destination or destination == "" then
		print("Operation canceld")
		return
	end

	-- If aleady exists
	if loop.fs_stat(destination) then
		print(destination, "is already exists")
		return
	end

	local refresh = vim.schedule_wrap(function()
		tree:refresh(nil, {}, function()
			tree.root:load(true)
		end)
		git.update(tree.cwd)
		tree:go_to_node(tree.root:find_node_by_path(destination))
	end)

	create_dirs_if_needed(destination)
	loop.fs_rename(original_location, destination, function(err)
		if err then
			print("Could not move the files")
			return
		else
			print("Moved " .. node.name .. " successfully")
		end
		refresh()
	end)
end

-- Copy Node
local function copy_node(tree, node)
	-- node = node:is_dir() and node or node.parent
	local msg_tag = "Enter the new path for the node:"
	local msg = string.format("Copy the node \n%s \n%s", string.rep("=", 58), msg_tag)
	local ans = vim.fn.input(msg, node.abs_path)
	clear_prompt()

	local refresh = vim.schedule_wrap(function()
		tree:refresh(nil, {}, function()
			tree.root:load(true)
		end)
		git.update(tree.cwd)
		-- tree:go_to_node(tree.root:find_node_by_path(ans))
		print("Created " .. ans .. " successfully")
	end)

	if not ans or ans == "" then
		return
	end
	if loop.fs_stat(ans) then
		print("Node already exists")
		return
	end

	loop.fs_copyfile(node.abs_path, ans)
	local handle
	handle = loop.spawn("cp", { args = { "-r", node.abs_path, ans } }, function(code)
		handle:close()
		if code ~= 0 then
			print("copy failed")
			return
		end
		refresh()
	end)
end

-- Reveal Node
local function reveal_in_finder(_tree, node)
	local handle
	handle = loop.spawn("open", { args = { "-R", node.abs_path } }, function(code)
		handle:close()
		if code ~= 0 then
			print("erro")
			return
		end
	end)
end

-- Quick Look
local function quick_look(_tree, node)
	local handle
	handle = loop.spawn("qlmanage", { args = { "-p", node.abs_path } }, function(code)
		handle:close()
		if code ~= 0 then
			print("error")
			return
		end
	end)
end

-- Create Node
local function create_node(tree, node)
	node = node:is_dir() and node or node.parent
	-- print(vim.inspect(node.abs_path))
	-- print(vim.inspect(tree.root.abs_path))
	-- local pathPrefix = node.abs_path:gsub(tree.root.abs_path)
	-- print(pathPrefix)
	local msg_tag = "Enter the dir/file name to be created. Dirs end with a '/'\n"
	local msg = string.format("Add a childnode \n%s \n%s", string.rep("=", 58), msg_tag)
	local ans = vim.fn.input(msg, node.abs_path)

	local refresh = vim.schedule_wrap(function()
		tree:refresh(nil, {}, function()
			tree.root:load(true)
		end)
		git.update(tree.cwd)
		tree:go_to_node(tree.root:find_node_by_path(ans))
		clear_prompt()
		print("Created " .. ans .. " successfully")
	end)

	local function file_writer(path)
		create_dirs_if_needed(path)
		local fd = loop.fs_open(path, "w", open_mode)
		if not fd then
			api.nvim_err_writeln("Could not create file " .. path)
			return
		end
		loop.fs_chmod(path, 420)
		loop.fs_close(fd)
	end

	if not ans or ans == "" then
		return
	end
	if loop.fs_stat(ans) then
		clear_prompt()
		print("File already exists")
		return
	end

	if vim.endswith(ans, "/") then
		create_dirs_if_needed(ans)
	else
		file_writer(ans)
	end
	refresh()
end

-- Delete Node
local function delete_node(tree, node)
	if node == tree.root then
		return
	end

	if node:is_dir() then
		node:load()
	end

	local msg_tag = string.format("Are you sure you want to delete (y/n) \n%s: ", node.abs_path)

	if node:is_dir() and #node.entries > 0 then
		msg_tag = "Warning, directory is not empty \n" .. msg_tag
	end

	local opts = { "&yes", "&no" }
	local choice =
		vim.fn.confirm(string.format("Delete the current node \n%s:", node.abs_path), table.concat(opts, "\n"))

	clear_prompt()
	if choice == 2 then
		print("Operation canceld")
		return
	end

	local function delete_dir(cwd)
		local handle = loop.fs_scandir(cwd)
		if type(handle) == "string" then
			return api.nvim_err_writeln(handle)
		end

		while true do
			local name, t = loop.fs_scandir_next(handle)
			if not name then
				break
			end

			local new_cwd = cwd .. "/" .. name
			if t == "directory" then
				local success = delete_dir(new_cwd)
				if not success then
					print("failed to delete ", new_cwd)
					return false
				end
			else
				clear_buffer(new_cwd)
				local success = loop.fs_unlink(new_cwd)
				if not success then
					return false
				end
			end
		end
		return loop.fs_rmdir(cwd)
	end

	if node.entries then
		local success = delete_dir(node.abs_path:sub(1, -2))
		if not success then
			return api.nvim_err_writeln("Could not remove " .. node.name)
		end
	else
		local success = loop.fs_unlink(node.abs_path)
		if not success then
			return api.nvim_err_writeln("Could not remove " .. node.name)
		end
		clear_buffer(node.abs_path)
	end

	local next_node = node:find_sibling(1) or node:find_sibling(-1) or tree:find_neighbor(node, -1)
	local path = next_node.abs_path
	local refresh = vim.schedule_wrap(function()
		tree:refresh(tree.root, {}, function()
			git.update(tree.cwd)
			tree.root:load(true)
		end)
		tree:go_to_node(tree.root:find_node_by_path(path))
		print("Deleted " .. node.name .. " successfully")
	end)
	refresh()
end

local function menu_float(tree, node)
	vim.ui.select({
		"Add",
		"Delete",
		"Move",
		"Copy",
		"Reveal",
	}, {
		prompt = "Choose Item",
		format_item = function(item)
			return item .. " node"
		end,
	}, function(choice)
		if choice == "Add" then
			create_node(tree, node)
		end
		if choice == "Delete" then
			delete_node(tree, node)
		end
		if choice == "Move" then
			move_node(tree, node)
		end
		if choice == "Copy" then
			copy_node(tree, node)
		end
		if choice == "Reveal" then
			reveal_in_finder(tree, node)
		end
	end)
end

local function refresh_and_focus(tree, node)
	tree:refresh(nil, {}, function()
		tree.root:load(true)
	end)
	git.update(tree.cwd)
	tree:go_to_node(tree.root:find_node_by_path(node.abs_path))
end

local yanilBuffers = Section:new({
	name = "Buffers",
	total_lines = 2,
})

function yanilBuffers:get_buffers()
	local buffers = {}
	local bufnrs = vim.tbl_filter(function(buf)
		if 1 ~= vim.fn.buflisted(buf) then
			return false
		end
		if buf == canvas.bufnr then
			return false
		end
		if not vim.api.nvim_buf_is_loaded(buf) then
			return false
		end
		if buf == vim.api.nvim_get_current_buf() then
			return false
		end

		return true
	end, api.nvim_list_bufs())
	for _, bufnr in ipairs(bufnrs) do
		local element = {
			bufnr = bufnr,
			name = vim.fn.getbufinfo(bufnr)[1].name,
		}
		table.insert(buffers, element)
	end
	print(vim.inspect(buffers))
	return buffers
end

function yanilBuffers:draw()
	local bufs = yanilBuffers:get_buffers()
	local lines = { "Buffers" }
	for _, buf in ipairs(bufs) do
		table.insert(lines, buf.name)
	end
	-- self.total_lines = #lines
	return { texts = { line_start = 0, line_end = #lines, lines = lines } }
end

function yanilBuffers:total_lines()
	-- print(vim.inspect(yanilBuffers))
	return 2
	-- return yanilBuffers.total_lines
end

yanil.setup({
	git = {
		icons = {
			Unstaged = "●",
			Staged = "●",
			Unmerged = "●",
			Renamed = "●",
			Untracked = "U",
			Modified = "M",
			Deleted = "●",
			Dirty = "●",
			Ignored = " ",
			Clean = "●",
			Unknown = "●",
		},
	},
})

local yanilTree = require("yanil/sections/tree"):new()
yanilTree:setup({
	draw_opts = {
		decorators = {
			depth_indent,
			iconDecorator,
			decorators.space,
			default_decorator,
			decorators.readonly,
			decorators.executable,
			decorators.link_to,
			-- lsp_diagnostics,
			git_status,
		},
	},
	filters = {},
	keymaps = {
		m = menu_float,
		["]c"] = git.jump_next,
		["[c"] = git.jump_prev,
		["gd"] = git_diff,
		["A"] = create_node,
		["D"] = delete_node,
		["M"] = move_node,
		["<tab>"] = toggle_zoom,
		-- ["C"] = copy_node,
		["U"] = dotutil.noop,
		["K"] = function()
			api.nvim_feedkeys("5k", "n", true)
		end,
		["J"] = function()
			api.nvim_feedkeys("5j", "n", true)
		end,
		["R"] = refresh_and_focus,
		-- ["r"] = reveal_in_finder,
		["<space>"] = quick_look,
		["P"] = function(tree, node)
			if not node.parent then
				return
			end
			tree:go_to_node(node.parent)
		end,
	},
})
canvas.register_hooks({
	-- on_exit()
	-- on_enter()
	-- on_open(cwd)
	on_leave = function()
		vim.wo.cursorline = false
	end,
	on_enter = function()
		api.nvim_command("doautocmd User YanilTreeEnter")
		vim.wo.cursorline = true
		vim.cmd("hi YanilGitUntracked gui=None guifg=#65737e")
		vim.cmd("hi YanilTreeDirectory guifg=#6699cc")
		vim.cmd("hi YanilTreeLinkTo guibg=none")
		vim.cmd("hi YanilTreeFile guibg=none")
		vim.cmd("setl nowrap")
		-- vim.cmd("silent vertical resize 45")
		git.update(yanilTree.cwd)
		vim.cmd('setlocal winhighlight=EndOfBuffer:YanilEndOfBuffer,Normal:YanilNormal,SignColumn:YanilSignColumn,NormalNC:YanilnNormalNC,VertSplit:YanilVertSplit')

		--
		vim.cmd('hi YanilNormal guibg=#12232b')
		vim.cmd('hi YanilEndOfBuffer guifg=#12232b')
		vim.cmd('hi YanilnNormalNC guibg=#12232b')
		vim.cmd('hi YanilVertSplit guibg=#12232b guifg=#12232b')
	end,
})
canvas.setup({
	--yanilBuffers,
	sections = { yanilTree },
	autocmds = {
		{
			event = "User",
			pattern = "YanilGitStatusChanged",
			cmd = function()
				git.refresh_tree(yanilTree)
			end,
		},
		-- {
		-- event = "User",
		-- pattern = "LspDiagnosticsChanged",
		-- cmd = function()
		-- print('diagnostics changed')
		-- -- print(vim.inspect(yanilTree))
		-- git.refresh_tree(yanilTree)
		-- end
		-- }
	},
})

map("n", "-", "<Cmd>YanilToggle<cr>", { noremap = true, silent = true, nowait = true })

return M
