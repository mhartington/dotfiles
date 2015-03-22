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
  Bundle 'pangloss/vim-javascript'
  Bundle 'tpope/vim-markdown'
  Bundle 'scrooloose/syntastic'
  Bundle 'tmux-plugins/vim-tmux'
  Bundle 'digitaltoad/vim-jade'
  Bundle 'leafgarland/typescript-vim'
  Bundle 'othree/yajs.vim'

" colorscheme & syntax highlighting
" Bundle 'altercation/vim-colors-solarized'
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
  Bundle 'kien/ctrlp.vim'
  Bundle 'christoomey/vim-tmux-navigator'
  Bundle 'edkolev/promptline.vim'
  Bundle 'bling/vim-airline'
  Bundle 'tpope/vim-surround'
  Bundle 'tomtom/tcomment_vim'
  Bundle 'tpope/vim-unimpaired'
  Bundle 'mattn/emmet-vim'
  Bundle 'maksimr/vim-jsbeautify'
  Bundle 'einars/js-beautify'
  Bundle 'marijnh/tern_for_vim'


  if vundleExists == 0
    echo "Installing Bundles, ignore errors"
    :BundleInstall
    echo "Things may not work properly until you restart vim"
  endif

  " filetype plugin on
  " au BufRead,BufNewFile *.ts        setlocal filetype=typescript
  " set rtp+=/usr/local/lib/node_modules/typescript-tools

  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"

  set syntax=whitespace
  set noswapfile
  set showcmd
  set nopaste
  filetype on
  

" Turn Line Numbers on
  set number

" tmux mouse support
  set ttymouse=xterm2

" enable mouse
  set mouse=a

" Theme
  syntax enable
  let base16colorspace=256 
  colorscheme base16-ocean
  set background=dark
  

  highlight clear SignColumn
  call gitgutter#highlight#define_highlights()

  nnoremap ; :

  let g:indent_guides_auto_colors = 0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

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
  autocmd FileType scss noremap <buffer> <c-f> :call CSSBeautify()<cr>

" Copy to osx clipboard
  vnoremap <C-c> "*y<CR>

" Typescript
  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost    l* nested lwindow


  set columns=100
  set showbreak=+++
  set colorcolumn=100
  " set textwidth=100
  set wrap linebreak nolist
  set virtualedit=
  set display+=lastline
  noremap  <silent> <Up>   gk
  noremap  <silent> <Down> gj
  noremap  <silent> <Home> g<Home>
  noremap  <silent> <End>  g<End>
  inoremap <silent> <Up>   <C-o>gk
  inoremap <silent> <Down> <C-o>gj
  inoremap <silent> <Home> <C-o>g<Home>
  inoremap <silent> <End>  <C-o>g<End>

" Emmet customization
" Enable Emmet in all modes
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
   autocmd FileType html imap <buffer><expr><tab> <sid>expand_html_tab()

   let g:use_emmet_complete_tag = 1
   let g:user_emmet_install_global = 0
   autocmd FileType html,css EmmetInstall

" no need to fold things in markdown all the time
  let g:vim_markdown_folding_disabled = 1

  set tabstop=2
  set shiftwidth=2
  set expandtab
  
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
 let g:airline#extensions#tabline#show_tab_nr = 1
 let g:airline_powerline_fonts = 1
 let g:airline_theme='base16'
 set guifont=Source\ Code\ Pro\ for\ Powerline "make sure to escape the spaces in the name properly

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

" Syntastic
  let g:syntastic_javascript_checkers = ['jshint']
  let g:syntastic_html_checkers = []
  let g:syntastic_check_on_open = 1
  let g:syntastic_always_populate_loc_list = 1


" sections (a, b, c, x, y, z, warn) are optional
let g:promptline_theme = 'airline'
 let g:promptline_preset = {
 \'a' : [ promptline#slices#cwd()  ],
 \'b' : [ promptline#slices#vcs_branch()  ],
 \'c' : [promptline#slices#git_status()]}

" autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

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

" TypeScript
" echo symbol/type of item under cursor
"   command! TSSsymbol
"   command! TSStype
"
" " browse url for ES5 global property/method under cursor
"   command! TSSbrowse
"
" " jump to definition of item under cursor
"   command! TSSdef
"   command! TSSdefpreview
"   command! TSSdefsplit
"   command! TSSdeftab
"
" " create location list for references
"   command! TSSreferences
"
" " navigation menu for current file structure
"   command! TSSstructure
"
" " update TSS with current file source
"   command! TSSupdate
"
" " show TSS errors, with updated current file
"   command! TSSshowErrors
"
" " for use as balloonexpr, symbol under mouse pointer
" " set balloonexpr=TSSballoon()
" " set ballooneval
"   function! TSSballoon()
"
" " completions
"   function! TSScompleteFunc(findstart,base)
"
" " open project file, with filename completion
"   command! -complete=customlist,TSSfile -nargs=1 TSSfile
"
" " show project file list in preview window
"   command! TSSfiles
"
" navigate to project file via popup menu
  " command! TSSfilesMenu echo TSSfilesMenu('show')

" reload project sources - will ask you to save modified buffers first
  " command! TSSreload

" start typescript service process (asynchronously, via python)
  " command! -nargs=1 TSSstart
  " command! TSSstarthere

" pass a command to typescript service, get answer
  " command! -nargs=1 TSScmd call TSScmd(<f-args>,{})

" check typescript service
" (None: still running; <num>: exit status)
  " command! TSSstatus

" stop typescript service
  " command! TSSend

" sample keymap
" (highjacking some keys otherwise used for tags,
" since we support jump to definition directly)
  " function! TSSkeymap()

" Source the vimrc file after saving it
 if has("autocmd")
   autocmd bufwritepost .vimrc source $MYVIMRC
 endif
