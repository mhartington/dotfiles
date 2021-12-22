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

M.map("n", "<Leader>H", '<cmd>TSHighlightCapturesUnderCursor<cr>')
M.map("n", "<c-p>", "<cmd>lua require('mh.telescope').find_files()<cr>")
M.map("n", "<Leader>h", "<cmd>lua require('mh.telescope').help_tags()<cr>")
M.map("n", "<Leader>c", "<cmd>lua require('mh.telescope').colors()<cr>")
M.map("n", "<Leader>a", "<cmd>Telescope live_grep<cr>")
M.map("n", "<Leader>b", "<cmd>Telescope buffers<cr>")
M.map("n", "z=", "<cmd>Telescope spell_suggest<cr>")
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
M.map("n", ";", ":", {nowait = true, silent = false})
M.map("n", "<Space>", "za")
M.map("n", "<Space>", "za")
M.map("n", "<Leader>,", "<cmd>bnext<cr>")
M.map("n", "<Leader>.", "<cmd>bprevious<cr>")
M.map("n", "k", "v:count == 0 ? 'gk' : 'k'", {expr = true})
M.map("n", "j", "v:count == 0 ? 'gj' : 'j'", {expr = true})
M.map("v", "k", "v:count == 0 ? 'gk' : 'k'", {expr = true})
M.map("v", "j", "v:count == 0 ? 'gj' : 'j'", {expr = true})
M.map('v', "Ô", ":m '>+1<CR>gv=gv")
M.map('v', "", ":m '<-2<CR>gv=gv")


M.map("v", "<", "<gv")
M.map("v", ">", ">gv")
M.map("n", "<Leader>d", '"_d')
M.map("v", "<Leader>d", '"_d')
M.map("n", "<Esc>", "<cmd>noh<cr>")
-- terminal M.mappings
M.map("t", "<Esc>", "<c-\\><c-n><esc><cr>")
M.map("t", "<Leader>,", "<c-\\><c-n>:bnext<cr>")
M.map("t", "<Leader>.", "<c-\\><c-n>:bprevious<cr>")

-- M.map("n", "<C-j>", "<cmd>lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<cr>")
-- M.map("n", "<C-k>", "<cmd>lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<cr>")
-- M.map("n", "<C-l>", "<cmd>lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<cr>")
-- M.map("n", "<C-h>", "<cmd>lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<CR>")
--
-- M.map("i", "<C-j>", "<cmd>lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<cr>")
-- M.map("i", "<C-k>", "<cmd>lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<cr>")
-- M.map("i", "<C-l>", "<cmd>lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<cr>")
-- M.map("i", "<C-h>", "<cmd>lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<CR>")
--
-- M.map("t", "<C-j>", "<c-\\><c-n><cmd>lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<cr>")
-- M.map("t", "<C-k>", "<c-\\><c-n><cmd>lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<cr>")
-- M.map("t", "<C-l>", "<c-\\><c-n><cmd>lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<cr>")
-- M.map("t", "<C-h>", "<c-\\><c-n><cmd>lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<CR>")

M.map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
M.map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
M.map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
M.map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")

M.map("i", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
M.map("i", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
M.map("i", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
M.map("i", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")

M.map("t", "<C-j>", "<c-\\><c-n>:TmuxNavigateDown<cr>")
M.map("t", "<C-k>", "<c-\\><c-n>:TmuxNavigateUp<cr>")
M.map("t", "<C-l>", "<c-\\><c-n>:TmuxNavigateRight<cr>")
M.map("t", "<C-h>", "<c-\\><c-n>:TmuxNavigateLeft<CR>")

M.map("n", "<Leader>tm", "<cmd>TableModeToggle<cr>")
M.map("n", "<Leader>u", "<cmd>PackerUpdate<cr>")

for i = 1, 9 do
  M.map("n", "<leader>" .. i, ':lua require"bufferline".go_to_buffer(' .. i .. ")<CR>")
  M.map("t", "<leader>" .. i, '<C-\\><C-n>:lua require"bufferline".go_to_buffer(' .. i .. ")<CR>")
end



vim.cmd("cnoreabbrev <silent> x lua require('mh.commands').BufDel()")



-- vim.cmd("cnoreabbrev x Sayonara")
-- vim.cmd("cnoreabbrev x! BufDel!")
--
--
-- Show package versions
M.map("n", "<leader>ns", ":lua require('package-info').show()<CR>" )

-- Hide package versions
M.map("n", "<leader>nc", ":lua require('package-info').hide()<CR>")

-- Update package on line
M.map("n", "<leader>nu", ":lua require('package-info').update()<CR>")

-- Delete package on line
M.map("n", "<leader>nd", ":lua require('package-info').delete()<CR>")

-- Install a new package
M.map("n", "<leader>ni", ":lua require('package-info').install()<CR>")

-- Reinstall dependencies
M.map("n", "<leader>nr", ":lua require('package-info').reinstall()<CR>")

-- Install a different package version
M.map("n", "<leader>np", ":lua require('package-info').change_version()<CR>")

return M
