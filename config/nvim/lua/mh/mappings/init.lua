local vim = vim
local api = vim.api
local M = {}
function M.map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
function M.mapBuf(buf, mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_buf_set_keymap(buf, mode, lhs, rhs, options)
end


M.map("n", "Q", "<nop>")
M.map("n", "q", "<nop>")
M.map("n", "<c-p>", "<cmd>lua require('mh.telescope').find_files()<cr>")
M.map("n", "<Leader>h", "<cmd>lua require('mh.telescope').help_tags()<cr>")
M.map("n", "<Leader>c", "<cmd>lua require('mh.telescope').colors()<cr>")
M.map("n", "<Leader>f", "<cmd>Format<cr>")
M.map("n", "H", "^")
M.map("n", "L", "g_")
M.map("v", "H", "^")
M.map("v", "L", "g_")
M.map("n", "J", "5j")
M.map("n", "K", "5k")
M.map("v", "J", "5j")
M.map("v", "K", "5k")
M.map("v", "gJ", ":join<cr>")
M.map("n", ";", ":", {nowait = true})
M.map("n", "<Space>", "za")
M.map("n", "<Space>", "za")
M.map("n", "<Leader>,", "<cmd>bnext<cr>")
M.map("n", "<Leader>.", "<cmd>bprevious<cr>")
M.map("n", "k", "v:count == 0 ? 'gk' : 'k'", {expr = true})
M.map("n", "j", "v:count == 0 ? 'gj' : 'j'", {expr = true})
M.map("v", "k", "v:count == 0 ? 'gk' : 'k'", {expr = true})
M.map("v", "j", "v:count == 0 ? 'gj' : 'j'", {expr = true})
M.map("v", "<", "<gv")
M.map("v", ">", ">gv")
M.map("n", "<Leader>d", '"_d')
M.map("v", "<Leader>d", '"_d')
M.map("n", "<Esc>", "<cmd>noh<cr>")
-- terminal M.mappings
M.map("t", "<Esc>", "<c-\\><c-n><esc><cr>")
M.map("t", "<Leader>,", "<c-\\><c-n>:bnext<cr>")
M.map("t", "<Leader>.", "<c-\\><c-n>:bprevious<cr>")
M.map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
M.map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
M.map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
M.map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")
M.map("n", "<C-;>", "<cmd>TmuxNavigatePrevious<cr>")
M.map("n", "<Leader>tm", "<cmd>TableModeToggle<cr>")


vim.cmd('cnoreabbrev x Sayonara')
-- tmap <C-j> <C-\><C-n>:TmuxNavigateDown<cr>
-- tmap <C-k> <C-\><C-n>:TmuxNavigateUp<cr>
-- tmap <C-l> <C-\><C-n>:TmuxNavigateRight<cr>
-- tmap <C-h> <C-\><C-n>:TmuxNavigateLeft<CR>
-- tmap <C-;> <C-\><C-n>:TmuxNavigatePrevious<cr>

return M
