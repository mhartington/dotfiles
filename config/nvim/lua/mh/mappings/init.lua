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

function M.keymap(modes, mapping, func, opts)
  local options = {noremap = true, silent = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(modes, mapping, func, opts)
end

M.map("n", "Q", "<nop>")
M.map("n", "q", "<nop>")

M.keymap("n", "<c-p>", Snacks.picker.files)
M.keymap("n", "<Leader>h", Snacks.picker.help)
M.keymap("n", "<Leader>c", Snacks.picker.colorschemes)
M.keymap("n", "<Leader>a", Snacks.picker.grep)
M.keymap("n", "<Leader>b", Snacks.picker.buffers) --"<cmd>Telescope buffers<cr>")
M.keymap("n", "z=", Snacks.picker.spelling) -- "<cmd>Telescope spell_suggest<cr>")
M.keymap("n", "<Leader>f", "<cmd>Format<cr>")
M.keymap("n", "H", "^")
M.keymap("n", "L", "g_")
M.keymap("v", "H", "^")
M.keymap("v", "L", "g_")
M.keymap("n", "J", "5j")
M.keymap("n", "K", "5k")
M.keymap("v", "J", "5j")
M.keymap("v", "K", "5k")

M.keymap({'v'}, "gJ", ":join<cr>")
M.keymap("n", ";", ":", {nowait = true, silent = false})
M.keymap("n", "<Space>", "za")
M.keymap("n", "<Space>", "za")
M.keymap("n", "<Leader>,", "<cmd>bnext<cr>")
M.keymap("n", "<Leader>.", "<cmd>bprevious<cr>")
M.keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", {expr = true})
M.keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", {expr = true})
M.keymap("v", "k", "v:count == 0 ? 'gk' : 'k'", {expr = true})
M.keymap("v", "j", "v:count == 0 ? 'gj' : 'j'", {expr = true})
M.keymap('v', "Ô", ":m '>+1<CR>gv=gv")
M.keymap('v', "", ":m '<-2<CR>gv=gv")


M.keymap("v", "<", "<gv")
M.keymap("v", ">", ">gv")
M.keymap("n", "<Leader>d", '"_d')
M.keymap("v", "<Leader>d", '"_d')
M.keymap("n", "<Esc>", "<cmd>noh<cr>")
-- terminal M.mappings
M.keymap("t", "<Esc>", "<c-\\><c-n><esc><cr>")
M.keymap("t", "<Leader>,", "<c-\\><c-n>:bnext<cr>")
M.keymap("t", "<Leader>.", "<c-\\><c-n>:bprevious<cr>")

M.keymap("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
M.keymap("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
M.keymap("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
M.keymap("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")

M.keymap("i", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
M.keymap("i", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
M.keymap("i", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
M.keymap("i", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")

M.keymap("t", "<C-j>", "<c-\\><c-n>:TmuxNavigateDown<cr>")
M.keymap("t", "<C-k>", "<c-\\><c-n>:TmuxNavigateUp<cr>")
M.keymap("t", "<C-l>", "<c-\\><c-n>:TmuxNavigateRight<cr>")
M.keymap("t", "<C-h>", "<c-\\><c-n>:TmuxNavigateLeft<CR>")

M.keymap("n", "<Leader>tm", "<cmd>TableModeToggle<cr>")
M.keymap("n", "<Leader>u", "<cmd>Lazy update<cr>")

for i = 1, 9 do
  M.keymap("n", "<leader>" .. i, function() require("bufferline").go_to(i, true) end)
  M.keymap("t", "<leader>" .. i, '<C-\\><C-n>:lua require"bufferline".go_(' .. i .. ", true)<CR>")
end

vim.cmd("cnoreabbrev <silent> x lua require('mh.commands').BufDel()")
-- vim.cmd("cnoreabbrev <silent> x lua Snacks.bufdelete()")

M.keymap("n", "<Leader>e", function() vim.cmd('Inspect') end)
return M
