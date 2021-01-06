-- Options
local Type = {GLOBAL_OPTION = "o", WINDOW_OPTION = "wo", BUFFER_OPTION = "bo"}
local add_options = function(option_type, options)
  if type(options) ~= "table" then
    error 'options should be a type of "table"'
    return
  end
  local vim_option = vim[option_type]
  for key, value in pairs(options) do
    vim_option[key] = value
  end
end
local Option = {}
Option.g = function(options)
  add_options(Type.GLOBAL_OPTION, options)
end
Option.w = function(options)
  add_options(Type.WINDOW_OPTION, options)
end
Option.b = function(options)
  add_options(Type.BUFFER_OPTION, options)
end


Option.g {
  termguicolors = true,
  mouse = "a",
  clipboard = "unnamedplus",
  hidden = true,
  showmode = false,
  timeoutlen = 3e3,
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  conceallevel = 0,
  laststatus = 2,
  wrap = true,
  linebreak = true,
  list = true,
  listchars= "tab:»·,trail:·",
  wildmenu = true,
  wildmode = "full",
  autoread = true,
  updatetime = 500,
  redrawtime = 500,
  fillchars = vim.o.fillchars .. "vert:│",
  undofile = true,
  virtualedit = "onemore",
  guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20",
  complete = ".,w,b,u,t,k",
  completeopt = "menu,menuone,noinsert,noselect",
  formatoptions = vim.o.formatoptions .. "t",
  inccommand = "nosplit",
  shortmess = "atIc",
  isfname = table.concat(
    vim.tbl_filter(
      function(entry)
        if entry == "=" then
          return false
        else
          return true
        end
      end,
      vim.split(vim.o.isfname, ",")
    ),
    ","
  ),
  diffopt = "internal,filler,closeoff,algorithm:patience,iwhiteall",
  splitbelow = true,

}
Option.w {
  number = true,
  numberwidth = 1,
  signcolumn = "yes",
  spell = false,
  foldlevel=99,
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()",
  foldtext = "v:lua.foldText()"
}
Option.b {swapfile = false}
vim.g.clipboard = {
  name = "macOS-clipboard",
  copy = {["+"] = "pbcopy", ["*"] = "pbcopy"},
  paste = {["+"] = "pbpaste", ["*"] = "pbpaste"},
  cache_enabled = false
}

vim.g.mapleader = ','
vim.g.one_allow_italics = true
vim.g.oceanic_next_terminal_bold = true
vim.g.oceanic_next_terminal_italic = true
vim.g.vim_monokai_tasty_italic = true
vim.g.table_mode_corner="|"
vim.g.markdown_fold_override_foldtext = false
vim.g.markdown_syntax_conceal = false
vim.g.mkdp_auto_start = false
vim.g.vim_json_syntax_conceal = false

return Option
