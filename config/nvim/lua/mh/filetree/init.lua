local mapping = require("mh.mappings")
local autocmd = require("mh.autocmds").autocmd
local M = {}

-- Nvim luatree...someday
vim.g.nvim_tree_width = 45
vim.g.nvim_tree_follow = 0
vim.g.nvim_tree_indent_markers = 0
vim.g.nvim_tree_root_folder_modifier = ":~"
vim.g.nvim_tree_show_icons = {git = 1, folders = 1, files = 1}
vim.g.nvim_tree_icons = {
  default = "",
  git = {
    unstaged = "✗",
    staged = "✓",
    unmerged = "═",
    renamed = "➜",
    untracked = "★"
  },
  folder = {default = "", open = ""}
}
vim.g.nvim_tree_bindings = {dir_up = " "}
-- mapping.map("n", "-", "<Cmd>NvimTreeToggle<cr>", {noremap = true, silent = true, nowait = true})
autocmd("FileType", "NvimTree", "lua require('mh.filetree').on_nvim_tree_enter()")
function M.on_nvim_tree_enter()
  vim.wo.spell = false
  mapping.mapBuf(0, "n", "<Tab>", '<cmd>lua require("mh.filetree").toggle_zoom()<cr>', {nowait = true})
end
function M.toggle_zoom()
  vim.b.oldWindowSize = vim.b.oldWindowSize or vim.api.nvim_win_get_width(0)
  if vim.b.nvimTreeIsZoomed then
    vim.b.nvimTreeIsZoomed = false
    vim.cmd("silent vertical resize" .. vim.b.oldWindowSize)
  else
    vim.b.nvimTreeIsZoomed = true
    vim.cmd "silent vertical resize"
  end
end

-- Tried and true nerdtree
mapping.map("n", "-", "<Cmd>NERDTreeToggle<cr>", {noremap = true, silent = true, nowait = true})
vim.g.NERDTreeWinSize=45
vim.g.NERDTreeAutoDeleteBuffer=1
vim.g.NERDTreeShowIgnoredStatus = 1
vim.g.NERDTreeDirArrowExpandable = ''
vim.g.NERDTreeDirArrowCollapsible = ''
vim.g.NERDTreeShowHidden=1
vim.g.NERDTreeMinimalUI=1
vim.g.NERDTreeHijackNetrw=1
vim.g.NERDTreeCascadeSingleChildDir=0
vim.g.NERDTreeCascadeOpenSingleChildDir=0
autocmd("FileType", "nerdtree", "lua require('mh.filetree').on_nerdtree_enter()")
function M.on_nerdtree_enter()
  vim.wo.spell = false
  mapping.mapBuf(0, "n", "J", '5j')
  mapping.mapBuf(0, "n", "K", '5k')
end
return M
