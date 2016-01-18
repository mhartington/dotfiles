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
  NeoBundle 'wavded/vim-stylus'
  NeoBundle 'tpope/vim-markdown'
  NeoBundle 'scrooloose/syntastic'
  NeoBundle 'tmux-plugins/vim-tmux'
  NeoBundle 'digitaltoad/vim-jade'
  " NeoBundle 'othree/yajs.vim'
  NeoBundle 'pangloss/vim-javascript'
  NeoBundle 'mxw/vim-jsx'
  NeoBundle '1995eaton/vim-better-javascript-completion'
  NeoBundle 'nikvdp/ejs-syntax',{'autoload':{'filetypes':['ejs']}}
  NeoBundle 'elzr/vim-json'
  NeoBundle 'othree/javascript-libraries-syntax.vim'
" Typescript
  NeoBundle 'leafgarland/typescript-vim'
  NeoBundle 'Shougo/vimproc.vim', {
       \ 'build' : {
       \     'windows' : 'tools\\update-dll-mingw',
       \     'cygwin' : 'make -f make_cygwin.mak',
       \     'mac' : 'make -f make_mac.mak',
       \     'linux' : 'make',
       \     'unix' : 'gmake',
       \    },
       \ }

" colorscheme & syntax highlighting
  " NeoBundle 'gosukiwi/vim-atom-dark'
  NeoBundle 'mhartington/oceanic-next'
  NeoBundle 'kien/rainbow_parentheses.vim'
  NeoBundle 'chrisbra/Colorizer'
  " NeoBundle 'Yggdroot/indentLine'
  NeoBundle 'Raimondi/delimitMate'
  NeoBundle 'valloric/MatchTagAlways'
 " Git helpers
  NeoBundle 'tpope/vim-fugitive'
  NeoBundle 'airblade/vim-gitgutter'
  NeoBundle 'Xuyuanp/nerdtree-git-plugin'

" untils
  NeoBundle 'matze/vim-move'
  NeoBundle 'editorconfig/editorconfig-vim'
  NeoBundle 'scrooloose/nerdtree'
  NeoBundle 'terryma/vim-multiple-cursors'
  NeoBundle 'ctrlpvim/ctrlp.vim'
  NeoBundle 'christoomey/vim-tmux-navigator'
  NeoBundle 'vim-airline/vim-airline'
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'tomtom/tcomment_vim'
  NeoBundle 'mattn/emmet-vim'
  NeoBundle 'Chiel92/vim-autoformat'
  NeoBundle 'Shougo/neocomplete.vim'
  NeoBundle 'Quramy/tsuquyomi'

  NeoBundle 'rking/ag.vim'
  NeoBundle 'mileszs/ack.vim'
  " NeoBundle 'ashisha/image.vim'
  NeoBundle 'Shougo/neosnippet'
  NeoBundle 'Shougo/neosnippet-snippets'
  NeoBundle 'matthewsimo/angular-vim-snippets'
" because fuck it, Icons are awesome
  NeoBundle 'ryanoasis/vim-webdevicons'
  NeoBundle 'guns/xterm-color-table.vim'
  NeoBundle 'sjl/clam.vim'
  NeoBundle 'vim-scripts/CSApprox'
  NeoBundle 'fmoralesc/vim-tutor-mode'
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
  let mapleader = ','
" Fix Cursor in TMUX
  if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif

  " set lazyredraw
  set syntax=whitespace
  set noswapfile
  set showcmd
    " set noshowmode
    " set noruler
    set laststatus=0
  set backspace=indent,eol,start
  filetype on
  let g:CSApprox_loaded = 1
  " set relativenumber number
  set foldlevelstart=1
  set foldenable
    function! MyFoldText() " {{{
      let line = getline(v:foldstart)

      let nucolwidth = &fdc + &number * &numberwidth
      let windowwidth = winwidth(0) - nucolwidth - 3
      let foldedlinecount = v:foldend - v:foldstart

      " expand tabs into spaces
      let onetab = strpart('          ', 0, &tabstop)
      let line = substitute(line, '\t', onetab, 'g')

      let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
      let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
      return line . '…' . repeat(" ",fillcharcount) .  ' ' . ' '
  endfunction " }}}
  set foldtext=MyFoldText()

  autocmd FileType tutor setlocal fdc=0
  autocmd FileType tutor setlocal foldlevel=0

  set tabstop=2
  set shiftwidth=2
  set expandtab
  set conceallevel=0
" tmux mouse support
  " set ttymouse=xterm2
  let g:vim_json_syntax_conceal = 0

" enable mouse
  set mouse=a

" Theme
  set t_Co=256
  syntax enable
  colorscheme OceanicNext
" highlightt the current line number
  highlight CursorLineNR guifg=#ffffff ctermfg=15
  set background=dark

" Copy to osx clipboard
  set pastetoggle=<leader>p
  vnoremap <C-c> "*y<CR>
  highlight MatchTag ctermfg=black ctermbg=lightgreen guifg=black guibg=lightgreen
  highlight clear SignColumn
  set laststatus=2
" Git gitgutter column colors
  call gitgutter#highlight#define_highlights()

" Space to toggle folds.
  nnoremap <Space> za
  vnoremap <Space> za
" This is the best
  nnoremap ; :
  let g:indent_guides_auto_colors = 0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
  set wildmenu
  " set laststatus=2
" if dir doesn't exsist, make it
  " function s:MkNonExDir(file, buf)
  "   if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
  "       let dir=fnamemodify(a:file, ':h')
  "       if !isdirectory(dir)
  "           call mkdir(dir, 'p')
  "       endif
  "   endif
  " endfunction
  " augroup BWCCreateDir
  "   autocmd!
  "   autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
  " augroup END
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
  autocmd BufRead,BufNewFile *.md setlocal spell complete+=kspell
  autocmd BufRead,BufNewFile *.txt setlocal spell complete+=kspell
  let g:move_key_modifier = 'S'

  let g:jsx_ext_required = 0
  map <leader>v :source ~/.vimrc<CR>
  map <leader>q :PromptlineSnapshot! ~/.dotfiles/prompt airline<CR>

  let g:used_javascript_libs = 'angularjs'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Snipppets
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable snipMate compatibility feature.
  let g:neosnippet#enable_snipmate_compatibility = 1
  imap <C-s>     <Plug>(neosnippet_expand_or_jump)
  smap <C-s>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-s>     <Plug>(neosnippet_expand_target)
" Tell Neosnippet about the other snippets
  let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet-snippets/neosnippets, ~/Github/ionic-snippets, ~/.vim/bundle/angular-vim-snippets/snippets'

" SuperTab like snippets behavior.
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  map <C-\> :NERDTreeToggle<CR>
  " autocmd StdinReadPre * let s:std_in=1
  " autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  " let NERDTreeShowHidden=1

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
" Make files look nice
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  autocmd FileType css,scss,sass :ColorHighlight
  noremap <c-f> :Autoformat<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Typescript & Javscript omni complete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  let g:vimjs#casesensistive = 1

  let g:vimjs#smartcomplete = 0
  let g:vimjs#chromeapis = 0
  autocmd FileType typescript inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  let g:typescript_indent_disable = 1

"  let g:neocomplete#enable_at_startup = 1
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType typescript setlocal omnifunc=tsuquyomi#complete
  let g:neocomplete#sources#syntax#min_keyword_length = 3

  if !exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_omni_input_patterns.typescript = '\h\w*\|[^. \t]\.\w*'

  autocmd FileType typescript setlocal completeopt-=preview
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
        return "\<C-n>"
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
   autocmd FileType html,css,ejs EmmetInstall
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTRLP & GREP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_user_command = 'ag %s -i --nogroup --hidden
    \ --ignore .git
    \ --ignore .svn
    \ --ignore .hg
    \ --ignore .DS_Store
    \ --ignore "**/*.pyc"
    \ --ignore lib
    \ -g ""'
  let g:ctrlp_regexp = 1
  let g:ctrlp_use_caching = 0
  let g:ctrlp_working_path_mode = 0
  let g:ctrlp_switch_buffer = 0
  " let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
  let g:ackprg = 'ag --nogroup --column'
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
  let g:airline_theme='oceanicnext'
" make sure to escape the spaces in the name properly
  set guifont=Sauce\ Code\ Pro\ Nerd\ Font\ Complete:h13
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
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  let g:syntastic_javascript_checkers = ['jscs', 'eslint']
  let g:syntastic_check_on_open = 0
  " let g:syntastic_always_populate_loc_list = 1
  " let g:syntastic_auto_loc_list = 1

  let g:syntastic_aggregate_errors = 1
  let g:syntastic_error_symbol = '✗'
  let g:syntastic_warning_symbol = '!'
  let g:syntastic_style_error_symbol = '✗'
  let g:syntastic_style_warning_symbol = '!'

  noremap <leader>t :SyntasticToggleMode<CR>

  function! JscsFix()
      let l:winview = winsaveview()
      % ! jscs -x
      call winrestview(l:winview)
  endfunction
  command JscsFix :call JscsFix()

  noremap <leader>f :JscsFix<CR>
   " autocmd BufWritePre *.js,*.jsx JscsFix

  let g:syntastic_mode_map = { 'passive_filetypes': ['sass', 'scss','html'] }
  map <Leader>e :lnext<CR>
  map <Leader>E :lprev<CR>
