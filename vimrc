" If vundle is not installed, do it first
  let vundleExists = 1
  if (!isdirectory(expand("$HOME/.vim/bundle/vundle")))
      call system(expand("mkdir -p $HOME/.vim/bundle"))
      call system(expand("git clone git://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle"))
      let vundleExists = 0
  endif

" be iMproved
  set nocompatible

" required!
  filetype off


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
"  nnoremap : ;

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


" Do not mess with these two line
" TODO figure out why this fucking works
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

" go to next item in a popup menu.
" this will insert a snippet if it's selected in the menu
" due to neosnippets being the first check.
    if pumvisible()
      return "\<C-n>"
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

" folding settings
" fold based on indent
  set foldmethod=indent
" deepest fold is 10 levels
  set foldnestmax=10
" dont fold by default
  set nofoldenable
" this is just what i use
  set foldlevel=1


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
  
" available slices:
"
" promptline#slices#cwd() - current dir, truncated to 3 dirs. To configure: promptline#slices#cwd({ 'dir_limit': 4 })
" promptline#slices#vcs_branch() - branch name only. By default, only git branch is enabled. Use promptline#slices#vcs_branch({ 'hg': 1, 'svn': 1, 'fossil': 1}) to enable check for svn, mercurial and fossil branches. Note that always checking if inside a branch slows down the prompt
" promptline#slices#last_exit_code() - display exit code of last command if not zero
" promptline#slices#jobs() - display number of shell jobs if more than zero
" promptline#slices#battery() - display battery percentage (on OSX and linux) only if below 10%. Configure the threshold with promptline#slices#battery({ 'threshold': 25 })
" promptline#slices#host()
" promptline#slices#user()
" promptline#slices#python_virtualenv() - display which virtual env is active (empty is none)
" promptline#slices#git_status() - count of commits ahead/behind upstream, count of modified/added/unmerged files, symbol for clean branch and symbol for existing untraced files
"
" any command can be used in a slice, for example to print the output of whoami in section 'b':
"   \'b' : [ '$(whoami)'],
"
" more than one slice can be placed in a section, e.g. print both host and user in section 'a':
"   \'a': [ promptline#slices#host(), promptline#slices#user() ],
"
" to disable powerline symbols
" `let g:promptline_powerline_symbols = 0`

" Source the vimrc file after saving it
  if has("autocmd")
    autocmd bufwritepost .vimrc source $MYVIMRC
  endif
