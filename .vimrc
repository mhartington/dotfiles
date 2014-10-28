" If vundle is not installed, do it first
let vundleExists = 1
if (!isdirectory(expand("$HOME/.vim/bundle/vundle")))
    call system(expand("mkdir -p $HOME/.vim/bundle"))
    call system(expand("git clone git://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle"))
    let vundleExists = 0
endif

set nocompatible               " be iMproved
filetype off                   " required!


set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" github repos
Bundle 'wavded/vim-stylus'
Bundle 'gmarik/ingretu'
Bundle 'altercation/vim-colors-solarized'
Bundle 'kien/ctrlp.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'mxw/vim-jsx'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-commentary'
Bundle 'kana/vim-fakeclip'
Bundle 'godlygeek/tabular'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'chrisbra/color_highlight'
Bundle 'scrooloose/nerdtree'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'groenewege/vim-less'
Bundle 'junegunn/goyo.vim'
Bundle 'sjl/clam.vim'
if vundleExists == 0
  echo "Installing Bundles, ignore errors"
  :BundleInstall
  echo "Things may not work properly until you restart vim"
endif


filetype on


syntax enable
set background=dark
colorscheme solarized

let g:solarized_termcolors=256

:set noswapfile
" NERDTree AutoStartup
map <leader>n :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=1

:set number
:set mouse=a
:map <xCSI>[62~ <MouseDown>
vnoremap <C-c> "*y
map <C-/> :gc

"no need to fold things in markdown all the time
let g:vim_markdown_folding_disabled = 1


"Powerline Setup
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

python import sys; sys.path.append("/usr/local/lib/python2.7/site-packages/")
