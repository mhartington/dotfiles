"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"___  ____ _               _   _ _
"|  \/  (_) |             | | | (_)
"| .  . |_| | _____  ___  | | | |_ _ __ ___  _ __ ___
"| |\/| | | |/ / _ \/ __| | | | | | '_ ` _ \| '__/ __|
"| |  | | |   <  __/\__ \ \ \_/ / | | | | | | | | (__
"\_|  |_/_|_|\_\___||___/  \___/|_|_| |_| |_|_|  \___|
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" If vundle is not installed, do it first
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
  Bundle 'pangloss/vim-javascript'
  Bundle 'tpope/vim-markdown'
  Bundle 'scrooloose/syntastic'
  Bundle 'tmux-plugins/vim-tmux'
  Bundle 'digitaltoad/vim-jade'
  Bundle 'leafgarland/typescript-vim'
  Bundle 'kchmck/vim-coffee-script'
  Bundle 'othree/yajs.vim'
  Bundle 'nikvdp/ejs-syntax'
  Bundle 'elzr/vim-json'

" colorscheme & syntax highlighting
  Bundle 'chriskempson/base16-vim'
  Bundle 'kien/rainbow_parentheses.vim'
  Bundle 'chrisbra/color_highlight'
  Bundle 'vim-scripts/SyntaxRange'
  Bundle 'Yggdroot/indentLine'
  Bundle 'Raimondi/delimitMate'
  Bundle 'valloric/MatchTagAlways'
" Git helpers
  Bundle 'tpope/vim-fugitive'
  Bundle 'airblade/vim-gitgutter'
  Bundle 'Xuyuanp/nerdtree-git-plugin'

" untils
  Bundle 'editorconfig/editorconfig-vim'
  Bundle 'scrooloose/nerdtree'
  Bundle 'terryma/vim-multiple-cursors'
  Bundle 'sjl/clam.vim'
  Bundle 'ctrlpvim/ctrlp.vim'
  Bundle 'christoomey/vim-tmux-navigator'
  Bundle 'edkolev/promptline.vim'
  Bundle 'bling/vim-airline'
  Bundle 'tpope/vim-surround'
  Bundle 'tomtom/tcomment_vim'
  Bundle 'tpope/vim-unimpaired'
  Bundle 'mattn/emmet-vim'
  Bundle 'maksimr/vim-jsbeautify'
  Bundle 'einars/js-beautify'
  Bundle "Valloric/YouCompleteMe"
  Bundle 'marijnh/tern_for_vim'
  Bundle 'rking/ag.vim'
  Bundle 'mileszs/ack.vim'
  Bundle 'JazzCore/ctrlp-cmatcher'
  Bundle 'pelodelfuego/vim-swoop'  

" because fuck it, Icons are awesome
  Bundle 'ryanoasis/vim-webdevicons'

  if vundleExists == 0
    echo "Installing Bundles, ignore errors"
    :BundleInstall
    echo "Things may not work properly until you restart vim"
  endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim untils
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fix Cursor in TMUX
  if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif

  set lazyredraw    
  set syntax=whitespace
  set noswapfile
  set showcmd
  set nopaste
  set backspace=indent,eol,start
  filetype on
  set number
  set tabstop=2
  set shiftwidth=2
  set expandtab
  set conceallevel=0
" tmux mouse support
  set ttymouse=xterm2
  let g:vim_json_syntax_conceal = 0

" enable mouse
  set mouse=a

" Theme
  syntax enable
  let base16colorspace=256
  colorscheme base16-flat
  set background=dark
" Copy to osx clipboard
  vnoremap <C-c> "*y<CR>
  highlight MatchTag ctermfg=black ctermbg=lightgreen guifg=black guibg=lightgreen
  highlight clear SignColumn

" Git gitgutter column colors
  call gitgutter#highlight#define_highlights()

" This is the best
  nnoremap ; :
  let g:ycm_path_to_python_interpreter = '/usr/local/bin/python'
  let g:indent_guides_auto_colors = 0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
  set wildmenu
  set laststatus=2
" if dir doesn't exsist, make it
  function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
  endfunction
  augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
  augroup END
" set colorcolumn=100
  set wrap linebreak nolist
  set virtualedit=
  set display+=lastline

" Navigate between display lines
  noremap  <silent> <Up>   gk
  noremap  <silent> <Down> gj
  noremap  <silent> k gk
  noremap  <silent> j gj
  noremap  <silent> <Home> g<Home>
  noremap  <silent> <End>  g<End>
  inoremap <silent> <Up>   <C-o>gk
  inoremap <silent> <Down> <C-o>gj
  inoremap <silent> <Home> <C-o>g<Home>
  inoremap <silent> <End>  <C-o>g<End>
" no need to fold things in markdown all the time
  let g:vim_markdown_folding_disabled = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  map <C-\> :NERDTreeToggle<CR>
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  let NERDTreeShowHidden=1
" NERDTress File highlighting
  function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
  endfunction

  call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
  call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
  call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
  call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
  call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
  call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
  call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
  call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
  call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
  call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
  call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
  call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
  call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" JSBeautify
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
  autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
" for html
  autocmd FileType html,xml noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
  autocmd FileType css,scss,sass noremap <buffer> <c-f> :call CSSBeautify()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Typescript
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  let g:typescript_compiler_options = '-sourcemap'
  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost    l* nested lwindow
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Emmet customization
" Enable Emmet in all modes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  let g:user_emmet_mode='a'
" Remapping <C-y>, just doesn't cut it.
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
  if emmet#isExpandable()
    return "\<C-y>,"
  endif
" return a regular tab character
   return "\<tab>"
   endfunction
   autocmd FileType html,ejs imap <buffer><expr><tab> <sid>expand_html_tab()

   let g:use_emmet_complete_tag = 1
   let g:user_emmet_install_global = 0
   autocmd FileType html,css,ejs EmmetInstall
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTRLP & GREP
"""""""""""""""""""""""""""""""""""""""""""""""""""""
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'
  let g:ctrlp_use_caching = 0
  let g:ctrlp_working_path_mode = 0
  let g:ctrlp_switch_buffer = 0
  let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']
  let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
  let g:ackprg = 'ag --nogroup --nocolor --column'
  set grepprg=ag\ --nogroup\ --nocolor
  nnoremap <leader>a :Ag<space>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Navigate between vim buffers and tmux panels
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  let g:tmux_navigator_no_mappings = 1
  nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
  nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
  nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
  nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
  nnoremap <silent> <C-;> :TmuxNavigatePrevious<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#show_tab_nr = 1
  let g:airline_powerline_fonts = 1
  let g:airline_theme='base16'
" make sure to escape the spaces in the name properly
  set guifont=Source\ Code\ Pro\ for\ Powerline
" Tabline part of vim-airline
" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
  nmap <leader>x :bp <BAR> bd #<CR>
" This replaes :tabnew which I used to bind to this mapping
  nmap <leader>n :enew<cr>
" Move to the next buffer
  nmap <leader>, :bnext<CR>
" Move to the previous buffer
  nmap <leader>. :bprevious<CR>
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  nmap <leader>1 <Plug>AirlineSelectTab1
  nmap <leader>2 <Plug>AirlineSelectTab2
  nmap <leader>3 <Plug>AirlineSelectTab3
  nmap <leader>4 <Plug>AirlineSelectTab4
  nmap <leader>5 <Plug>AirlineSelectTab5
  nmap <leader>6 <Plug>AirlineSelectTab6
  nmap <leader>7 <Plug>AirlineSelectTab7
  nmap <leader>8 <Plug>AirlineSelectTab8
  nmap <leader>9 <Plug>AirlineSelectTab9
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  let g:syntastic_javascript_checkers = ['eslint']
  let g:syntastic_check_on_open = 0
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_mode_map = { 'passive_filetypes': ['sass', 'scss','html'] }
  map <Leader>e :lnext<CR>
  map <Leader>E :lprev<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" promptline config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  let g:promptline_theme = 'airline'
  let g:promptline_preset = {
  \'a' : [ promptline#slices#cwd()  ],
  \'b' : [ promptline#slices#vcs_branch()  ],
  \'c' : [promptline#slices#git_status()]}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Source the vimrc file after saving it
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 if has("autocmd")
   autocmd bufwritepost .vimrc source $MYVIMRC
 endif
