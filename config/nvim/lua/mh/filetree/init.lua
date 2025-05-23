local vim = vim
local api = vim.api
local uv = vim.uv
local a = require("mh.async")

local get_diagnostics = vim.lsp.diagnostic.get_all
local yanil = require("yanil")
local git = require("yanil/git")
local decorators = require("yanil/decorators")
local devicons = require("nvim-web-devicons")
local canvas = require("yanil/canvas")
local Section = require("yanil/section")
local keymap = require("mh.mappings").keymap
local mapBuf = require("mh.mappings").mapBuf
local c = require("oceanic-next.config").colors
local darken = require("oceanic-next.utils").darken

local dotutil = require("mh/util")

local open_mode = uv.constants.O_CREAT + uv.constants.O_WRONLY + uv.constants.O_TRUNC

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
  vim.opt.filetype = "diff"
  api.nvim_set_option_value("filetype", "diff", { buf = bufnr })
  api.nvim_set_option_value("bufhidden", "wipe", { buf = bufnr })
  api.nvim_set_option_value("swapfile", false, { buf = bufnr })

  api.nvim_buf_set_lines(bufnr, 0, -1, false, diff)
  mapBuf(bufnr, "n", "q", "<CMD>exit<cr>")
  local winnr = dotutil.floating_window_big(bufnr)

  api.nvim_set_option_value("cursorline", true, { win = winnr })
  api.nvim_set_option_value("winhl", "NormalFloat:", { win = winnr })
  api.nvim_set_option_value("number", true, { win = winnr })
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

-- mkdir -p but with libuv
local create_dirs_if_needed = function(dirs)
  local parentDir = vim.fn.fnamemodify(dirs, ":h")
  local dir_split = vim.split(parentDir, "/")
  local directory = ""
  for _, dir in ipairs(dir_split) do
    directory = directory .. dir .. "/"
    local stats_data = uv.fs_stat(directory)
    if stats_data == nil then
      uv.fs_mkdir(directory, 493)
    end
  end
end

-- async touch
local create_file = a.wrap(function(path)
  a.schedule(create_dirs_if_needed(path)).await()
  local file_writer = uv.fs_open(path, "w", open_mode)
  uv.fs_chmod(path, 420)
  uv.fs_close(file_writer)
end)

local function copy_recursive(src, dest)
  create_dirs_if_needed(dest)
  local req, scan_err = uv.fs_scandir(src)
  while true do
    local name, typ = uv.fs_scandir_next(req)
    if not name then
      break
    end
    local from, to = src .. name, dest .. name
    print(vim.inspect(typ))
    if typ == "link" then
      uv.fs_symlink(from, to, 0)
    end

    if typ == "directory" then
      from = from .. "/"
      to = to .. "/"
      copy_recursive(from, to)
    else
      local ok, err = uv.fs_copyfile(from, to, { ficlone = true })
      if not ok then
        error(("copy '%s' failed: %s"):format(from, err))
      end
    end
  end
end

-- refresh tree and focus node
local function refresh(tree, node)
  tree:refresh(nil, {}, function()
    tree.root:load(true)
  end)
  git.update(tree.cwd)
  tree:go_to_node(tree.root:find_node_by_path(node))
end

-- Move Node
local move_node = a.wrap(function(tree, node)
  local prev = node.abs_path
  local next = a.ui.input({ prompt = "New Path", default = prev, completion = "file" }).await()

  if not next or next == "" then
    return
  end

  local path = next
  if tree.root:find_node_by_path(path) then
    vim.notify('path "' .. path .. '" is already exists', "WARN")
    return
  end

  a.schedule(create_dirs_if_needed(next)).await()
  a.uv().fs_rename(prev, next).await()

  a.schedule(function()
    refresh(tree, next)
    vim.notify("Moved " .. node.name .. " successfully")
    vim.api.nvim_exec_autocmds("User", { pattern = "YanilTreeFileMoved", data = { prev = prev, next = next } })
  end).await()
end)

-- Copy Node
local copy_node = a.wrap(function(tree, node)
  local src = node.abs_path
  local dest = a.ui.input({ prompt = "Copy Node", default = src, completion = "file" }).await()

  if not dest or dest == "" then
    return
  end

  if tree.root:find_node_by_path(dest) then
    vim.notify('path "' .. dest .. '" is already exists', "WARN")
    return
  end

  vim.notify("Copying...")
  a.uv().fs_copyfile(src, dest).await()
  a.system({ "cp", "-r", src, dest }).await()

  a.schedule(function()
    refresh(tree, dest)
    vim.notify("Created " .. dest .. " successfully")
  end).await()
end)

-- Reveal Node
local function reveal_in_finder(_, node)
  vim.ui.open(node.abs_path)
end

-- Quick Look
local function quick_look(_, node)
  local handle
  handle = uv.spawn("qlmanage", { args = { "-p", node.abs_path } }, function(code)
    handle:close()
    if code ~= 0 then
      print("error")
      return
    end
  end)
end

-- Create Node
local create_node = a.wrap(function(tree, node)
  node = node:is_dir() and node or node.parent
  local dest = a.ui.input({ prompt = "Add File/Folder", default = node.abs_path }).await()

  if not dest or dest == "" then
    return
  end

  if tree.root:find_node_by_path(dest) then
    vim.notify(dest .. '" is already exists', "WARN")
    return
  end

  if vim.endswith(dest, "/") then
    a.schedule(create_dirs_if_needed(dest)).await()
  else
    a.schedule(create_file(dest)).await()
  end
  a.schedule(function()
    refresh(tree, dest)
    vim.notify("Created " .. dest .. " successfully")
  end).await()
end)

-- Delete Node
local delete_node = a.wrap(function(tree, node)
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
  local choice = vim.fn.confirm(string.format("Delete the current node \n%s:", node.abs_path), table.concat(opts, "\n"))

  clear_prompt()
  if choice == 0 or choice == 2 then
    vim.notify("Operation canceld")
    return
  end

  local function delete_dir(cwd)
    local handle = uv.fs_scandir(cwd)
    if type(handle) == "string" then
      vim.notify(handle, "WARN")
      return
    end

    while true do
      local name, t = uv.fs_scandir_next(handle)
      if not name then
        break
      end

      local new_cwd = cwd .. "/" .. name
      if t == "directory" then
        local success = delete_dir(new_cwd)
        if not success then
          vim.notify("failed to delete " .. new_cwd, "WARN")
          return false
        end
      else
        clear_buffer(new_cwd)
        local success = uv.fs_unlink(new_cwd)
        if not success then
          return false
        end
      end
    end
    return uv.fs_rmdir(cwd)
  end

  if node.entries then
    local success = delete_dir(node.abs_path:sub(1, -2))
    if not success then
      vim.notify("Could not remove " .. node.name, "WARN")
      return
    end
  else
    local success = uv.fs_unlink(node.abs_path)
    if not success then
      vim.notify("Could not remove " .. node.name, "WARN")
      return
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
    vim.notify("Deleted " .. node.name .. " successfully")
  end)
  refresh()
end)

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
-- local buffers = yanilBuffers:new()

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
    vim.wo.statuscolumn = ""
    vim.api.nvim_set_hl(0, "YanilGitUntracked", { link = "Comment" })
    vim.api.nvim_set_hl(0, "YanilTreeDirectory", { link = "Function" })
    vim.api.nvim_set_hl(0, "YanilTreeLinkTo", { bg = "none" })
    vim.api.nvim_set_hl(0, "YanilTreeFile", { bg = "none" })
    vim.opt_local.wrap = false
    git.update(yanilTree.cwd)
    -- vim.wo.winhighlight =
    --   "EndOfBuffer:YanilEndOfBuffer,Normal:YanilNormal,SignColumn:YanilSignColumn,NormalNC:YanilnNormalNC,WinSeparator:YanilWinSeparator"

    -- local themeBg = dotutil.decToHex(vim.api.nvim_get_hl(0, {name="Normal" }).bg)
    -- vim.api.nvim_set_hl(0, "YanilNormal", { bg = darken(themeBg, 5) })
    -- vim.api.nvim_set_hl(0, "YanilEndOfBuffer", { bg = darken(themeBg, 5) })
    -- vim.api.nvim_set_hl(0, "YanilnNormalNC", { bg = darken(themeBg, 5) })
    -- vim.api.nvim_set_hl(0, "YanilWinSeparator", { fg = darken(themeBg, 5), bg = darken(themeBg, 5) })
  end,
})
canvas.setup({
  --yanilBuffers,
  -- side='right',
  sections = {
    --  buffers,
    yanilTree,
  },
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

keymap("n", "-", function()
  require("yanil/canvas").toggle()
end, { nowait = true })

return M
