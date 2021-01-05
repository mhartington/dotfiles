local M = {}
vim.g.nvim_tree_width = 45
vim.g.nvim_tree_follow = 0
vim.g.nvim_tree_indent_markers = 0
vim.g.nvim_tree_root_folder_modifier = ":~"
vim.g.nvim_tree_show_icons = { git = 1, folders = 1, files = 1 }
vim.g.nvim_tree_icons = {
	default = "",
	git = {
		unstaged = "✗",
		staged = "✓",
		unmerged = "═",
		renamed = "➜",
		untracked = "★"
	},
	folder = { default = "", open = "" }
}
vim.api.nvim_set_keymap("n", "-", "<Cmd>NvimTreeToggle<cr>", { noremap = true, silent = true, nowait = true })
vim.api.nvim_command'autocmd FileType NvimTree lua require("mh.filetree").on_nvim_tree_enter()'

function M.on_nvim_tree_enter()
	vim.wo.spell = false
	vim.api.nvim_buf_set_keymap(0, "n", "<Tab>", '<cmd>lua require("mh.filetree").toggle_zoom()<cr>', { noremap = true, silent = true, nowait = true })
end

function M.toggle_zoom()
	vim.b.oldWindowSize = vim.b.oldWindowSize or vim.api.nvim_win_get_width(0)
	if vim.b.nvimTreeIsZoomed then
		vim.b.nvimTreeIsZoomed = false
		vim.cmd("silent vertical resize" .. vim.b.oldWindowSize)
	else
		vim.b.nvimTreeIsZoomed = true
		vim.cmd"silent vertical resize"
	end
end
return M
