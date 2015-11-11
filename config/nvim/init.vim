"|  \/  (_) |                        (_)
"| .  . |_| | _____  ___   _ ____   ___ _ __ ___  _ __ ___
"| |\/| | | |/ / _ \/ __| | '_ \ \ / / | '_ ` _ \| '__/ __|
"| |  | | |   <  __/\__ \ | | | \ V /| | | | | | | | | (__
"\_|  |_/_|_|\_\___||___/ |_| |_|\_/ |_|_| |_| |_|_|  \___|
"
" Author: Mike Hartington
" repo  : https://github.com/mhartington/dotfiles/
"

" Setup NeoBundle  ----------------------------------------------------------{{{
" If vundle is not installed, do it first

  let bundleExists = 1
  if (!isdirectory(expand("$HOME/.nvim/bundle/neobundle.vim")))
     call system(expand("mkdir -p $HOME/.nvim/bundle"))
     call system(expand("git clone https://github.com/Shougo/neobundle.vim ~/.nvim/bundle/neobundle.vim"))
     let bundleExists = 0
  endif


  if 0 | endif

  if has('vim_starting')
    if &compatible
      " Be iMproved
      set nocompatible
    endif

" Required:
    set runtimepath+=~/.nvim/bundle/neobundle.vim/
    set runtimepath+=~/.nvim/bundle/bolt.vim/
  endif

" Required:
  call neobundle#begin(expand('~/.nvim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
  NeoBundleFetch 'Shougo/neobundle.vim'

" syntax
  NeoBundle 'othree/yajs.vim'
  NeoBundle 'kchmck/vim-coffee-script'
  NeoBundle 'hail2u/vim-css3-syntax'
  NeoBundle 'moll/vim-node'
  NeoBundle '1995eaton/vim-better-javascript-completion'
  NeoBundle 'vim-scripts/SyntaxComplete'
  NeoBundle 'othree/javascript-libraries-syntax.vim'
  NeoBundleLazy 'elzr/vim-json', {'autoload':{'filetypes':['json']}}
  NeoBundle 'tpope/vim-markdown'
  NeoBundle 'suan/vim-instant-markdown'
  NeoBundle 'burnettk/vim-angular'
" Typescript
  NeoBundle 'HerringtonDarkholme/yats.vim'
  NeoBundleLazy 'Quramy/tsuquyomi', {'autoload':{'filetypes':['typescript']}}

" colorscheme & syntax highlighting
  NeoBundle 'mhartington/oceanic-next'
  NeoBundle 'Yggdroot/indentLine'
  NeoBundle 'Raimondi/delimitMate'
  NeoBundle 'valloric/MatchTagAlways'
 " Git helpers
  NeoBundle 'tpope/vim-fugitive'
  NeoBundle 'airblade/vim-gitgutter'
  NeoBundle 'Xuyuanp/nerdtree-git-plugin'

" untils
  NeoBundle 'benekastah/neomake'
  NeoBundle 'editorconfig/editorconfig-vim'
  NeoBundle 'scrooloose/nerdtree'
  NeoBundle 'AndrewRadev/switch.vim'
  NeoBundle 'christoomey/vim-tmux-navigator'
  NeoBundle 'bling/vim-airline'
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'tomtom/tcomment_vim'
  NeoBundle 'mattn/emmet-vim'
  NeoBundle 'Chiel92/vim-autoformat'
  NeoBundle 'gorodinskiy/vim-coloresque'
" Shougo
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'Shougo/vimproc.vim', {
        \ 'build' : {
        \     'windows' : 'tools\\update-dll-mingw',
        \     'cygwin' : 'make -f make_cygwin.mak',
        \     'mac' : 'make -f make_mac.mak',
        \     'linux' : 'make',
        \     'unix' : 'gmake',
        \    },
        \ }
  NeoBundle 'Shougo/deoplete.nvim'
  NeoBundle 'Shougo/neco-vim'
  NeoBundle 'Shougo/neoinclude.vim'

  NeoBundle 'Shougo/neosnippet.vim'
  NeoBundle 'Shougo/neosnippet-snippets'
  NeoBundle 'honza/vim-snippets'
  NeoBundle 'matthewsimo/angular-vim-snippets'

  NeoBundle 'wincent/terminus'
  " because fuck it, Icons are awesome
  NeoBundle 'ryanoasis/vim-devicons'
  NeoBundle 'junegunn/fzf', { 'dir': '~/.fzf' }
  NeoBundle 'junegunn/fzf.vim'
  NeoBundle 'ashisha/image.vim'
  NeoBundle 'mhinz/vim-sayonara'
  NeoBundle 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}
  NeoBundle 'terryma/vim-multiple-cursors'
  NeoBundle 'pelodelfuego/vim-swoop'
  call neobundle#end()

" Required:
  filetype plugin indent on
  NeoBundleCheck
  if bundleExists == 0
    echo "Installing Bundles, ignore errors"
  endif

" }}}

" System Settings  ----------------------------------------------------------{{{

" Neovim Settings
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  set clipboard+=unnamedplus
" Currently needed for neovim paste issue
  set pastetoggle=<f6>
" Let airline tell me my status
  set noshowmode
  set noswapfile
  filetype on
  set relativenumber number
  set tabstop=2 shiftwidth=2 expandtab
  set conceallevel=0
" block select not limited by shortest line
  set virtualedit=
  set wildmenu
  set laststatus=2
  "set colorcolumn=100
  set wrap linebreak nolist
  set wildmode=full
" leader is ,
  let mapleader = ','
  set undofile
  set undodir="$HOME/.VIM_UNDO_FILES"

" Remember cursor position between vim sessions
  autocmd BufReadPost *
              \ if line("'\"") > 0 && line ("'\"") <= line("$") |
              \   exe "normal! g'\"" |
              \ endif
              " center buffer around cursor when opening files
  autocmd BufRead * normal zz

  let g:jsx_ext_required = 0
  set complete=.,w,b,u,t,k
  let g:gitgutter_max_signs = 1000  " default value
  let g:used_javascript_libs = 'angularjs, angularuirouter'
" }}}

" System mappings  ----------------------------------------------------------{{{

" No need for ex mode
  nnoremap Q <nop>
" recording macros is not my thing
  map q <Nop>
" exit insert, dd line, enter insert
  inoremap <c-d> <esc>ddi
" Navigate between display lines
  noremap  <silent> <Up>   gk
  noremap  <silent> <Down> gj
  noremap  <silent> k gk
  noremap  <silent> j gj
  noremap  <silent> <Home> g<Home>
  noremap  <silent> <End>  g<End>
  inoremap <silent> <Home> <C-o>g<Home>
  inoremap <silent> <End>  <C-o>g<End>
" copy current files path to clipboard
  nmap cp :let @+ = expand("%") <cr>
" Neovim terminal mapping
" terminal 'normal mode'
  tmap <esc> <c-\><c-n><esc><cr>
" ,f to format code, requires formatters: read the docs
  noremap <leader>f :Autoformat<CR>
" exit insert, dd line, enter insert
  inoremap <c-d> <esc>ddi
  noremap H ^
  noremap L g_
  noremap J 5j
  noremap K 5k
" this is the best, let me tell you why
" how annoying is that everytime you want to do something in vim
" you have to do shift-; to get :, can't we just do ;?
" Plus what does ; do anyways??
" if you do have a plugin that needs ;, you can just wap the mapping
" nnoremap : ;
" give it a try and you will like it
  nnoremap ; :
  inoremap <c-f> <c-x><c-f>
" Copy to osx clipboard
  vnoremap <C-c> "*y<CR>
  " let g:used_javascript_libs = 'angularjs'
  let g:multi_cursor_next_key='<C-n>'
  let g:multi_cursor_prev_key='<C-p>'
  let g:multi_cursor_skip_key='<C-x>'
  let g:multi_cursor_quit_key='<Esc>'

" Align blocks of text and keep them selected
  vmap < <gv
  vmap > >gv
  nnoremap <leader>d "_d
  vnoremap <leader>d "_d
  vnoremap <c-/> :TComment<cr>
  map <esc> :noh<cr>
  autocmd FileType typescript nmap <buffer> <Leader>T : <C-u>echo tsuquyomi#hint()<CR>

  nnoremap <leader>e :call <SID>SynStack()<CR>
  function! <SID>SynStack()
    if !exists("*synstack")
      return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
  endfunc
"}}}"

" Themes, Commands, etc  ----------------------------------------------------{{{
" Theme
  syntax enable
  colorscheme OceanicNext
  set background=dark
" highlightt the current line number
  hi CursorLineNR guifg=#ffffff
" no need to fold things in markdown all the time
  let g:vim_markdown_folding_disabled = 1
" turn on spelling for markdown files
  autocmd BufRead,BufNewFile *.md setlocal spell complete+=kspell
" highlight bad words in red
  hi SpellBad guibg=#ff2929 guifg=#ffffff" ctermbg=224
" enable deoplete
  let g:deoplete#enable_at_startup = 1
" disable markdown auto-preview. Gets annoying
  let g:instant_markdown_autostart = 0
" Keep my termo window open when I navigate away
  autocmd TermOpen * set bufhidden=hide
"}}}

" Fold, gets it's own section  ----------------------------------------------{{{

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
      return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
  endfunction " }}}

  set foldtext=MyFoldText()
  autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
  autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
  autocmd FileType vim setlocal fdc=1
  set foldlevel=99
" Space to toggle folds.
  nnoremap <Space> za
  vnoremap <Space> za
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim setlocal foldlevel=0
  autocmd FileType html setlocal foldmethod=marker
  autocmd FileType html setlocal fdl=3
  autocmd FileType javascript,html,css,scss,typescript setlocal foldlevel=99
  autocmd FileType javascript,typescript,css,scss,json setlocal foldmethod=marker
  autocmd FileType javascript,typescript,css,scss,json setlocal foldmarker={,}
  au FileType html nnoremap <buffer> <leader>F zfat
" }}}

" NERDTree ------------------------------------------------------------------{{{

  map <C-\> :NERDTreeToggle<CR>
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  let NERDTreeShowHidden=1

" NERDTress File highlighting
  function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
  endfunction

  call NERDTreeHighlightFile('jade', 'green', 'none', 'green', 'none')
  call NERDTreeHighlightFile('md', 'blue', 'none', '#6699CC', 'none')
  call NERDTreeHighlightFile('config', 'yellow', 'none', '#d8a235', 'none')
  call NERDTreeHighlightFile('conf', 'yellow', 'none', '#d8a235', 'none')
  call NERDTreeHighlightFile('json', 'green', 'none', '#d8a235', 'none')
  call NERDTreeHighlightFile('html', 'yellow', 'none', '#d8a235', 'none')
  call NERDTreeHighlightFile('css', 'cyan', 'none', '#5486C0', 'none')
  call NERDTreeHighlightFile('scss', 'cyan', 'none', '#5486C0', 'none')
  call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', 'none')
  call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', 'none')
  call NERDTreeHighlightFile('ts', 'Blue', 'none', '#6699cc', 'none')
  call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', 'none')
  call NERDTreeHighlightFile('gitconfig', 'black', 'none', '#686868', 'none')
  call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#7F7F7F', 'none')
"}}}

" Snipppets -----------------------------------------------------------------{{{

" Enable snipMate compatibility feature.
  let g:neosnippet#enable_snipmate_compatibility = 1
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)
" Tell Neosnippet about the other snippets
  let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet-snippets/neosnippets, ~/Github/ionic-snippets, ~/.vim/bundle/angular-vim-snippets/snippets'

" SuperTab like snippets behavior.
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \: pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \: "\<TAB>"

"}}}

" Typescript & Javscript omni complete --------------------------------------{{{
  let g:vimjs#casesensistive = 1
  let g:vimjs#smartcomplete = 1
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType typescript setlocal completeopt-=preview
  let g:typescript_indent_disable = 1
  let g:tsuquyomi_disable_quickfix = 1
  let g:vim_json_syntax_conceal = 0
  let g:jsx_ext_required = 0
  " let g:deoplete#omni_patterns = {}
  " let g:deoplete#omni_patterns.typescript = '.'
"}}}

" Emmet customization -------------------------------------------------------{{{
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
"}}}

" FZF -----------------------------------------------------------------------{{{
" Brew install fzf
  map <c-p> :FZF<CR>
  tmap <c-p> <c-\><c-n>:FZF<CR>
  map <leader>a :Ag<CR>
  tmap <leader>a <c-\><c-n>:Ag<CR>

  vmap <leader>aw y:Ag <C-r>0<CR>
" nmap <leader>aw :Ag <C-r><C-w>
  map <leader>h :History<CR>
  tmap <leader>h <c-\><c-n>:History<CR>
  map <leader>l :Lines<CR>
"}}}

" Navigate between vim buffers and tmux panels ------------------------------{{{

  let g:tmux_navigator_no_mappings = 1
  nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
  nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
  nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
  nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
  nnoremap <silent> <C-;> :TmuxNavigatePrevious<cr>

  tmap <C-j> <C-\><C-n>:TmuxNavigateDown<cr>
  tmap <C-k> <C-\><C-n>:TmuxNavigateUp<cr>
  tmap <C-l> <C-\><C-n>:TmuxNavigateRight<cr>
  tmap <C-h> <C-\><C-n>:TmuxNavigateLeft<CR>
  tmap <C-;> <C-\><C-n>:TmuxNavigatePrevious<cr>

"}}}

" vim-airline ---------------------------------------------------------------{{{

  let g:airline#extensions#tabline#enabled = 1
  set hidden
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#show_tab_nr = 1
  let g:airline_powerline_fonts = 1
  let g:airline_theme='oceanicnext'

" Tabline part of vim-airline
" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
  cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == 'x' ? 'Sayonara' : 'x'
" cmap x Sayonara

  tmap <leader>x <c-\><c-n>:bp! <BAR> bd! #<CR>
" This replaes :tabnew which I used to bind to this mapping
  nmap <leader>t :term<cr>
  " nmap <leader>n :enew<cr>
  " tmap <leader>n <C-\><C-n>:enew<cr>
" Move to the next buffer
  nmap <leader>, :bnext<CR>
  tmap <leader>, <C-\><C-n>:bnext<cr>
" Move to the previous buffer
  nmap <leader>. :bprevious<CR>
  tmap <leader>. <C-\><C-n>:bprevious<CR>
  let g:airline#extensions#tabline#buffer_idx_mode = 1

  tmap <leader>1  <C-\><C-n><Plug>AirlineSelectTab1
  tmap <leader>2  <C-\><C-n><Plug>AirlineSelectTab2
  tmap <leader>3  <C-\><C-n><Plug>AirlineSelectTab3
  tmap <leader>4  <C-\><C-n><Plug>AirlineSelectTab4
  tmap <leader>5  <C-\><C-n><Plug>AirlineSelectTab5
  tmap <leader>6  <C-\><C-n><Plug>AirlineSelectTab6
  tmap <leader>7  <C-\><C-n><Plug>AirlineSelectTab7
  tmap <leader>8  <C-\><C-n><Plug>AirlineSelectTab8
  tmap <leader>9  <C-\><C-n><Plug>AirlineSelectTab9

  nmap <leader>1 <Plug>AirlineSelectTab1
  nmap <leader>2 <Plug>AirlineSelectTab2
  nmap <leader>3 <Plug>AirlineSelectTab3
  nmap <leader>4 <Plug>AirlineSelectTab4
  nmap <leader>5 <Plug>AirlineSelectTab5
  nmap <leader>6 <Plug>AirlineSelectTab6
  nmap <leader>7 <Plug>AirlineSelectTab7
  nmap <leader>8 <Plug>AirlineSelectTab8
  nmap <leader>9 <Plug>AirlineSelectTab9

" Get circle status
"
  " let g:circle_last_update = localtime()
  " let g:circle_update_frequencey_in_seconds = 30
  "
  " function! UpdateCirlceStatus()
  "   let output = system('circle status')
  "   if v:shell_error
  "     let g:circle_last_status = 'fail'
  "   else
  "     let g:circle_last_status = 'pass'
  "   endif
  "   return g:circle_last_status
  " endfunction
  "
  " let g:circle_last_status = UpdateCirlceStatus()
  "
  " function! CircleStatus()
  "   let current_time = localtime()
  "   if current_time - g:circle_last_update > g:circle_update_frequencey_in_seconds
  "     let g:circle_last_update = current_time
  "     echo "Checking CI"
  "     call UpdateCirlceStatus()
  "   endif
  "   return g:circle_last_status
  " endfunction
  "
  " let g:airline_section_b = "%{CircleStatus()}"
"}}}

" Linting -------------------------------------------------------------------{{{

  let g:neomake_javascript_enabled_makers = ['eslint']
  autocmd! BufWritePost *js Neomake
  autocmd! BufWritePost *ts Neomake
  function! JscsFix()
      let l:winview = winsaveview()
      % ! jscs -x
      call winrestview(l:winview)
  endfunction
  command JscsFix :call JscsFix()

  noremap <leader>j :JscsFix<CR>
"}}}
