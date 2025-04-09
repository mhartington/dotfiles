-- Options
local M = {}

vim.opt.scrolloff = 999
vim.opt.cmdheight = 0
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.hidden = true
vim.opt.showmode = false
vim.opt.timeoutlen = 3e3
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.conceallevel = 0
vim.opt.laststatus = 3
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = "tab:»·,trail:·"
vim.opt.wildmenu = true
vim.opt.wildmode = "full"
vim.opt.autoread = true
vim.opt.updatetime = 500
vim.opt.redrawtime = 500
vim.opt.fillchars = { vert = "│", fold = " " }
vim.opt.undofile = true
vim.opt.virtualedit = "onemore"
vim.opt.guicursor = {
  "n-v-c-sm:block",
  "i-ci-ve:ver25",
  "r-cr-o:hor20",
}
vim.opt.complete = ".,w,b,u,t,k"
vim.opt.completeopt = "menu,menuone,noinsert,noselect"
vim.opt.formatoptions = "jtcroql"
vim.opt.inccommand = "nosplit"
vim.opt.shortmess = "atIcF"
vim.opt.diffopt = "internal,filler,closeoff,algorithm:patience,iwhiteall"
vim.opt.splitbelow = true
vim.opt.emoji = false
vim.opt.showmatch = false
vim.opt.splitkeep = "screen"
vim.opt.swapfile = false
vim.opt.shiftwidth = 2
vim.opt.indentexpr = "nvim_treesitter#indent()"
vim.opt.number = true
vim.opt.numberwidth = 1
vim.opt.signcolumn = "yes"
vim.opt.spell = false
vim.opt.foldlevel = 99
vim.opt.foldmethod = "syntax"
vim.opt.foldtext = "v:lua.foldText()"
vim.opt.linebreak = true
vim.opt.clipboard = "unnamed,unnamedplus"
vim.g.clipboard = {
  name = "macOS-clipboard",
  copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
  paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
  cache_enabled = false,
}

vim.cmd('let &t_8f = "\\<Esc>[38;2;%lu;%lu;%lum"')
vim.cmd('let &t_8b = "\\<Esc>[48;2;%lu;%lu;%lum"')

vim.g.one_allow_italics = true
vim.g.oceanic_next_terminal_bold = true
vim.g.oceanic_next_terminal_italic = true
vim.g.vim_monokai_tasty_italic = true
vim.g.table_mode_corner = "|"
vim.g.markdown_fold_override_foldtext = false
vim.g.markdown_syntax_conceal = false
vim.g.mkdp_auto_start = false
vim.g.vim_json_syntax_conceal = false
vim.g.override_nvim_web_devicons = true
vim.g.skip_ts_context_commentstring_module = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return M
