" If vundle is not installed, do it first
  let vundleExists = 1
  if (!isdirectory(expand("$HOME/.dotfiles/vim/bundle/vundle")))
      call system(expand("mkdir -p $HOME/.dotfiles/vim/bundle"))
      call system(expand("git clone git://github.com/gmarik/vundle.git $HOME/.dotfiles/vim/bundle/vundle"))
      let vundleExists = 0
  endif

" be iMproved
  set nocompatible

" required!
  filetype off

  set rtp+=~/.dotfiles/vim/bundle/vundle/
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
" Bundle 'scrooloose/syntastic'
  Bundle 'tpope/vim-ragtag'
  Bundle 'tpope/vim-repeat'
  Bundle 'tpope/vim-unimpaired'
  Bundle 'tpope/vim-fugitive'
  Bundle 'tpope/vim-surround'
  Bundle 'tpope/vim-commentary'
  Bundle 'tpope/vim-markdown'
  Bundle 'godlygeek/tabular'
  Bundle 'editorconfig/editorconfig-vim'
  Bundle 'chrisbra/color_highlight'
  Bundle 'scrooloose/nerdtree'
  Bundle 'terryma/vim-multiple-cursors'
  Bundle 'groenewege/vim-less'
  Bundle 'junegunn/goyo.vim'
  Bundle 'sjl/clam.vim'
  Bundle 'vim-scripts/SyntaxRange'
  Bundle 'christoomey/vim-tmux-navigator'
  Bundle 'mattn/emmet-vim'
  Bundle 'maksimr/vim-jsbeautify'
  Bundle 'einars/js-beautify',
  Bundle 'airblade/vim-gitgutter',
  Bundle 'bling/vim-airline'
  Bundle 'Xuyuanp/nerdtree-git-plugin'
  Bundle 'edkolev/promptline.vim'

  if vundleExists == 0
    echo "Installing Bundles, ignore errors"
    :BundleInstall
    echo "Things may not work properly until you restart vim"
  endif

  set syntax=whitespace
  set noswapfile
  set showcmd
  filetype on

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
  let g:airline_powerline_fonts = 1
  let g:airline_theme='solarized'

" sections (a, b, c, x, y, z, warn) are optional
  let g:promptline_preset = {
  \'a' : [ promptline#slices#cwd()  ],
  \'b' : [ promptline#slices#vcs_branch()  ],
  \'c' : [promptline#slices#git_status()],
  \'warn' : [ promptline#slices#last_exit_code() ]}

" Source the vimrc file after saving it
  if has("autocmd")
    autocmd bufwritepost .vimrc source $MYVIMRC
  endif
