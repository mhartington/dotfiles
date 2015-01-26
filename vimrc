" If vundle is not installed, do it first
  let vundleExists = 1
  if (!isdirectory(expand("$HOME/.vim/bundle/vundle")))
      call system(expand("mkdir -p $HOME/.vim/bundle"))
      call system(expand("git clone git://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle"))
      let vundleExists = 0
  endif

" be iMproved
  set nocompatible
  let mapleader = ','
" required!
  filetype off

  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()

" let Vundle manage Vundle
  Bundle 'gmarik/vundle'

" github repos
" syntax
  Bundle 'wavded/vim-stylus'
  Bundle 'kchmck/vim-coffee-script'
  Bundle 'pangloss/vim-javascript'
  Bundle 'tpope/vim-markdown'
  Bundle 'groenewege/vim-less'
  Bundle 'mxw/vim-jsx'
  Bundle 'scrooloose/syntastic'

" colorscheme & syntax highlighting
  Bundle 'altercation/vim-colors-solarized'
  Bundle 'kien/rainbow_parentheses.vim'
  Bundle 'chrisbra/color_highlight'
  Bundle 'vim-scripts/SyntaxRange'
  Bundle 'nathanaelkane/vim-indent-guides'
  Bundle 'Raimondi/delimitMate'

" Git helpers
  Bundle 'tpope/vim-fugitive'
  Bundle 'airblade/vim-gitgutter'
  Bundle 'Xuyuanp/nerdtree-git-plugin'

" untils
  Bundle 'editorconfig/editorconfig-vim'
  Bundle 'scrooloose/nerdtree'
  Bundle 'terryma/vim-multiple-cursors'
  Bundle 'junegunn/goyo.vim'
  Bundle 'sjl/clam.vim'
  Bundle 'kien/ctrlp.vim'
  Bundle 'christoomey/vim-tmux-navigator'
  Bundle 'edkolev/promptline.vim'
  Bundle 'bling/vim-airline'
  Bundle 'tpope/vim-surround'
  Bundle 'tpope/vim-commentary'
  Bundle 'tpope/vim-ragtag'
  Bundle 'tpope/vim-repeat'
  Bundle 'tpope/vim-unimpaired'
  Bundle 'mattn/emmet-vim'
  Bundle 'maksimr/vim-jsbeautify'
  Bundle 'einars/js-beautify'
  Bundle 'Valloric/YouCompleteMe'
  Bundle 'marijnh/tern_for_vim'


  if vundleExists == 0
    echo "Installing Bundles, ignore errors"
    :BundleInstall
    echo "Things may not work properly until you restart vim"
  endif
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"

  set syntax=whitespace
  set noswapfile
  set showcmd
  filetype on
  map <C-S> ggVG<CR>
" Turn Line Numbers on
  set number
" tmux mouse support
  set ttymouse=xterm2
" enable mouse
  set mouse=a

" Solarized is good
  let g:solarized_termcolors=16
  syntax enable
  set background=dark
  colorscheme solarized

  nnoremap ; :

" NERDTree AutoStartup
  map <C-\> :NERDTreeToggle<CR>
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  let NERDTreeShowHidden=1

" JSBeautify
  autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" for html
  autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
  autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

" Copy to osx clipboard
  vnoremap <C-c> "*y<CR>

  let &colorcolumn=join(range(121,122),",")
  set textwidth=120
  set linebreak

" white space, tabs, eol plz
  set list
  set listchars=nbsp:•,eol:¬,tab:>-,extends:»,precedes:•,trail:•
  let g:showwhite_space_char = '•'


" Emmet customization
" Enable Emmet in all modes
  let g:user_emmet_mode='a'

" Remapping <C-y>, just doesn't cut it.
" This is a bit better and works for
" angular directives or web components
  function! s:expand_html_tab()
" try to determine if we're within quotes or tags.
" if so, assume we're in an emmet fill area.
    let line = getline('.')
    if col('.') < len(line)
      let line = matchstr(line, '[">][^<"]*\%'.col('.').'c[^>"]*[<"]')

      if len(line) >= 2
        return "\<C-y>n"
      endif
    endif

" expand anything emmet thinks is expandable.
" I'm not sure anything happens below this block.
    if emmet#isExpandable()
      return "\<C-y>,"
    endif

" return a regular tab character
    return "\<tab>"
  endfunction
  autocmd FileType html imap <buffer><expr><tab> <sid>expand_html_tab()

  let g:use_emmet_complete_tag = 1
  let g:user_emmet_install_global = 0
  autocmd FileType html,css EmmetInstall

" no need to fold things in markdown all the time
  let g:vim_markdown_folding_disabled = 1

  set tabstop=2 shiftwidth=2 expandtab

  let g:tmux_navigator_no_mappings = 1
  nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
  nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
  nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
  nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
  nnoremap <silent> <C-;> :TmuxNavigatePrevious<cr>

  set wildmenu
  set laststatus=2

" Powerline
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamemod = ':t'

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
  nmap <leader>x :bp <BAR> bd #<CR>
" This replaces :tabnew which I used to bind to this mapping
  nmap <leader>n :enew<cr>
" Move to the next buffer
  nmap <leader>, :bnext<CR>
" Move to the previous buffer
  nmap <leader>. :bprevious<CR>

  let g:airline_powerline_fonts = 1
  let g:airline_theme='solarized'
  set guifont=Source\ Code\ Pro\ for\ Powerline "make sure to escape the spaces in the name properly

" sections (a, b, c, x, y, z, warn) are optional
  let g:promptline_preset = {
  \'a' : [ promptline#slices#cwd()  ],
  \'b' : [ promptline#slices#vcs_branch()  ],
  \'c' : [promptline#slices#git_status()]}

  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" Source the vimrc file after saving it
  if has("autocmd")
    autocmd bufwritepost .vimrc source $MYVIMRC
  endif
