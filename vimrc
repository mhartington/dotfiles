"|  \/  (_) |             | | | (_)
"| .  . |_| | _____  ___  | | | |_ _ __ ___  _ __ ___
"| |\/| | | |/ / _ \/ __| | | | | | '_ ` _ \| '__/ __|
"| |  | | |   <  __/\__ \ \ \_/ / | | | | | | | | (__
"\_|  |_/_|_|\_\___||___/  \___/|_|_| |_| |_|_|  \___|
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" If vundle is not installed, do it first
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   let bundleExists = 1
  if (!isdirectory(expand("$HOME/.vim/bundle/neobundle.vim")))
     call system(expand("mkdir -p $HOME/.vim/bundle"))
     call system(expand("git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim"))
     let bundleExists = 0
  endif

  if 0 | endif

  if has('vim_starting')
    if &compatible
      set nocompatible               " Be iMproved
    endif

" Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
  endif

" Required:
  call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
  NeoBundleFetch 'Shougo/neobundle.vim'
 " syntax
  NeoBundle 'mhartington/oceanic-next'
  NeoBundle 'scrooloose/syntastic'

  "" HTML
  NeoBundle 'othree/html5.vim'

  "" CSS
  NeoBundle 'cakebaker/scss-syntax.vim'
  NeoBundle 'JulesWang/css.vim'
  NeoBundle 'stephenway/postcss.vim'

  "" Javascript
  NeoBundle 'mxw/vim-jsx'
  NeoBundle 'othree/yajs.vim'
  NeoBundle 'pangloss/vim-javascript'
  NeoBundle 'mustache/vim-mustache-handlebars'

  " Utilities
  NeoBundle 'kien/ctrlp.vim'
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'tpope/vim-fugitive'
  NeoBundle 'rking/ag.vim'
  NeoBundle 'mattn/emmet-vim'
  NeoBundle 'junegunn/vim-easy-align'
  NeoBundle 'spf13/vim-autoclose'
  NeoBundle 'bling/vim-airline'
  NeoBundle 'editorconfig/editorconfig-vim'
  NeoBundle 'airblade/vim-gitgutter'
  NeoBundle 'tomtom/tcomment_vim'

  call neobundle#end()

" Required:
  filetype plugin indent on
  NeoBundleCheck
  if bundleExists == 0
    echo "Installing Bundles, ignore errors"
  endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim untils
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"==============================
" Configuration
"==============================

" Default Settings

syntax enable

set number
set relativenumber
set smartindent
set cursorline

" Tabs & Spaces

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set background=dark
set laststatus=2

" Colors Themes & Font Settings

colorscheme OceanicNext
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

"" For MacVim

if has('gui_running')
  set guifont=Input\ Mono:h14
endif


" Cursor

hi CursorLineNR cterm=bold
" hi CursorLineNr term=bold ctermfg=White guifg=White

"==============================
" Plugin Settings
"==============================

" Airline

let g:airline_theme='oceanicnext'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1


" Gitgutter

call gitgutter#highlight#define_highlights()

" Ctrl-P Ignore

set wildignore+=*/node_modules/*,*/tmp/*,*.so,*.swp,*.zip

" Syntax Checkers

let g:syntastic_html_checkers = ['handlebars']
let g:syntastic_css_checkers = ['csslint', 'stylelint']
let g:syntastic_js_checkers = ['jscs', 'eslint', 'jshint']

" Not Sure

let g:jsx_ext_required = 0
let g:enable_bold_font = 1

"==============================
" Mappings
"==============================

" Leader

" tComment
map <leader>c <c-_><c-_>

" Emmet

imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" No Remap for Arrow Keys

nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>
