"|  \/  (_) |                        (_)
"| .  . |_| | _____  ___   _ ____   ___ _ __ ___  _ __ ___
"| |\/| | | |/ / _ \/ __| | '_ \ \ / / | '_ ` _ \| '__/ __|
"| |  | | |   <  __/\__ \ | | | \ V /| | | | | | | | | (__
"\_|  |_/_|_|\_\___||___/ |_| |_|\_/ |_|_| |_| |_|_|  \___|
"
"  Author: Mike Hartington
"  repo  : https://github.com/mhartington/dotfiles/
"
" Plugins  ------------------------------------------------------------------{{{

" Setup dein {{{
  if (!isdirectory(expand("$HOME/.config/nvim/repos/github.com/Shougo/dein.vim")))
    call system(expand("mkdir -p $HOME/.config/nvim/repos/github.com"))
    call system(expand("git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/repos/github.com/Shougo/dein.vim"))
  endif

  set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim/
  call dein#begin(expand('~/.config/nvim'))

  call dein#add('Shougo/dein.vim')
  call dein#add('haya14busa/dein-command.vim')
  call dein#add('wsdjeg/dein-ui.vim')
"}}}
  " call dein#add('Raimondi/delimitMate')
" system {{{
  " call dein#add('matze/vim-move')
  call dein#add('itmammoth/doorboy.vim')
  call dein#add('eugen0329/vim-esearch')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-unimpaired')
  call dein#add('AndrewRadev/switch.vim')
  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('tpope/vim-surround')
  call dein#add('tomtom/tcomment_vim')
  " call dein#add('tyru/caw.vim')
  call dein#add('tpope/vim-commentary')
  call dein#add('junegunn/vim-easy-align')
  call dein#add('tmux-plugins/vim-tmux')
  call dein#add('Shougo/context_filetype.vim')
  call dein#add('mhinz/vim-sayonara')
  call dein#add('mattn/webapi-vim')
  call dein#add('mattn/gist-vim')
  " call dein#add('terryma/vim-multiple-cursors')
  call dein#add('mg979/vim-visual-multi')
  call dein#add('MartinLafreniere/vim-PairTools')
  call dein#add('sjl/vitality.vim')
  call dein#add('simnalamburt/vim-mundo')
" }}}
" UI {{{
  call dein#add('scrooloose/nerdtree')
  call dein#add('Aldlevine/nerdtree-git-plugin')
  call dein#add('justinmk/vim-dirvish')
  call dein#add('kristijanhusak/vim-dirvish-git')
  call dein#add('Shougo/defx.nvim')
  call dein#add('kristijanhusak/defx-git')
  call dein#add('kristijanhusak/defx-icons')
  call dein#add('Yggdroot/indentLine')
  call dein#add('vim-airline/vim-airline')
  call dein#add('rakr/vim-one')
  call dein#add('joshdick/onedark.vim')
  call dein#add('morhetz/gruvbox')
  call dein#add('patstockwell/vim-monokai-tasty')
  call dein#add('arcticicestudio/nord-vim')
  " call dein#add('RRethy/vim-illuminate')
  call dein#add('Khaledgarbaya/night-owl-vim-theme')
  call dein#add('kenwheeler/glow-in-the-dark-gucci-shark-bites-vim')
  call dein#add('TroyFletcher/vim-colors-synthwave')
" }}}
" code style {{{
  " call dein#add('neomake/neomake')
  call dein#add('sbdchd/neoformat')
  call dein#add('editorconfig/editorconfig-vim')
" }}}
" completion {{{
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/deoplete-lsp')
  call dein#add('fszymanski/deoplete-emoji')
  call dein#add('tweekmonster/deoplete-clang2')
  call dein#add('artur-shaik/vim-javacomplete2')
  call dein#add('Shougo/neco-vim')
  call dein#add('Shougo/neoinclude.vim')
  call dein#add('Shougo/echodoc.vim')
" }}}
" denite {{{

  call dein#add('ctrlpvim/ctrlp.vim')
  call dein#add('conweller/findr.vim')
  call dein#add('Shougo/denite.nvim')
  call dein#add('liuchengxu/vim-clap', {'hook_done_update': function('clap#helper#build_all') })

  call dein#add('raghur/fruzzy', {'build': 'python3 ./python3/fruzzy_installer.py'})
  call dein#add('nixprime/cpsm', {'build': 'PY3=ON ./install.sh'})

  call dein#add('Shougo/neomru.vim')
  call dein#add('neoclide/denite-git')
  call dein#add('chemzqm/denite-extra')
  call dein#add('pocari/vim-denite-gists')

  call dein#add('hara/ctrlp-colorscheme')
  call dein#add('zeero/vim-ctrlp-help')
  call dein#add('fisadev/vim-ctrlp-cmdpalette')
" }}}
" git {{{{
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-rhubarb')
  call dein#add('sgeb/vim-diff-fold')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('junegunn/gv.vim')
  call dein#add('AGhost-7/critiq.vim')
  call dein#add('lambdalisue/gina.vim')
  call dein#add('rhysd/git-messenger.vim', {
   \   'lazy' : 1,
   \   'on_cmd' : 'GitMessenger',
   \   'on_map' : '<Plug>(git-messenger-',
   \ })
" }}}}
" snippets {{{
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  " call dein#add('honza/vim-snippets')
  " call dein#add('gfontenot/vim-xcode')
" }}}
" markdown {{{
  call dein#add('tpope/vim-markdown', {'on_ft': 'markdown'})
  call dein#add('dhruvasagar/vim-table-mode')
  call dein#add('nelstrom/vim-markdown-folding', {'on_ft': 'markdown'})
  call dein#add('rhysd/vim-grammarous')
  call dein#add('junegunn/goyo.vim')
  call dein#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],'build': 'cd app & npm install' })
  " call dein#add('ujihisa/neco-look')
" }}}
" rust {{{
  call dein#add('rust-lang/rust.vim')
  call dein#add('racer-rust/vim-racer')
" }}}
" python{{{
  call dein#add('tmhedberg/SimpylFold', {'on_ft': 'python'})
" }}}
" javascript {{{
  call dein#add('othree/yajs.vim')
  call dein#add('mxw/vim-jsx')
  call dein#add('heavenshell/vim-jsdoc')
  call dein#add('elzr/vim-json')
  call dein#add('HerringtonDarkholme/yats.vim')
  call dein#add('Quramy/vison')
  call dein#add('jxnblk/vim-mdx-js')
  " call dein#add('meain/vim-package-info', {'build': 'npm install'})
  " call dein#add('yardnsm/vim-import-cost', {'build': 'npm install'})
" }}}
" html {{{
  call dein#add('othree/html5.vim')
  call dein#add('mattn/emmet-vim')
  " call dein#add('valloric/MatchTagAlways', {'on_ft': 'html'})
  call dein#add('posva/vim-vue')
  call dein#add('skwp/vim-html-escape')
  call dein#add('kana/vim-textobj-user')
  call dein#add('whatyouhide/vim-textobj-xmlattr')
  call dein#add('pedrohdz/vim-yaml-folds')
" }}}
" css {{{
  call dein#add('hail2u/vim-css3-syntax')
  " call dein#add('ap/vim-css-color')
  call dein#add('norcalli/nvim-colorizer.lua')
  call dein#add('ncm2/ncm2-cssomni')
" }}}
" swift {{{
  call dein#add('keith/swift.vim')
" }}}
" reason {{{
  call dein#add('reasonml-editor/vim-reason-plus')
" }}}
" go {{{
  call dein#add('fatih/vim-go')
  call dein#add('zchee/deoplete-go', {'build': 'make'})
  call dein#add('gfontenot/vim-xcode')
" }}}
" java {{{
" }}}
" local {{{
  " call dein#add('w0rp/ale')
  "
  call dein#local('~/GitHub', {},['nvim-typescript'])
  call dein#local('~/GitHub', {},['vim-folds', 'oceanic-next'])
  call dein#add('neovim/nvim-lsp')
  " call dein#local('~/GitHub', {},['nvim-lsp'])
  " call dein#add('prabirshrestha/async.vim')
  " call dein#add('prabirshrestha/vim-lsp')
  " call dein#add('natebosch/vim-lsc')
  " call dein#add('hrsh7th/deoplete-vim-lsc')
  " call dein#add('autozimu/LanguageClient-neovim', {
  "\ 'rev': 'next',
  "\ 'build': 'bash install.sh',
  "\ })
" }}}
" Has to be last according to docs
  call dein#add('ryanoasis/vim-devicons')

  if dein#check_install()
    call dein#install()
    let pluginsExist=1
  endif

  call dein#end()
  filetype plugin indent on
" }}}

" System Settings  ----------------------------------------------------------{{{

  source ~/.local.vim
  if exists('g:GuiLoaded')
    Guifont Hasklig:h15
  endif
" Neovim Settings
  set termguicolors
  set mouse=a
  " let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
  set clipboard+=unnamedplus
  set nopaste
  set hidden
  autocmd BufWritePre * %s/\s\+$//e
  set noshowmode
  set noswapfile
  filetype on
  set  number
  set numberwidth=1
  set tabstop=2 shiftwidth=2 expandtab
  set conceallevel=0
  set virtualedit=
  set laststatus=2
  set wrap linebreak nolist
  set wildmenu
  set wildmode=full
  " set wildoptions=pum
  set autoread
  set updatetime=500
  set redrawtime=500
  set fillchars+=vert:│
  " set numberwidth=5
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
  autocmd BufReadPost * normal zz
  set complete=.,w,b,u,t,k
  autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
  autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
  set formatoptions+=t
  set inccommand=nosplit
  set shortmess=atIc
  set isfname-==
  set spell
  " let g:indentLine_color_gui = '#343d46'
  " set scrolloff=999
  " set sidescrolloff=999
  " let g:indentLine_char="⎸"

  let g:clipboard = {
  \ 'name': 'pbcopy',
  \ 'copy': {
  \    '+': 'pbcopy',
  \    '*': 'pbcopy',
  \  },
  \ 'paste': {
  \    '+': 'pbpaste',
  \    '*': 'pbpaste',
  \ },
  \ 'cache_enabled': 0,
  \ }
" }}}

" System mappings  ----------------------------------------------------------{{{

" No need for ex mode
  nnoremap Q <nop>
  vnoremap // y/<C-R>"<CR>
" recording macros is not my thing
  map q <Nop>
" exit insert, dd line, enter insert
  inoremap <c-d> <esc>ddi
" Navigate between display lines
  nnoremap <silent><expr> k      v:count == 0 ? 'gk' : 'k'
  nnoremap <silent><expr> j      v:count == 0 ? 'gj' : 'j'
  vnoremap <silent><expr> k      v:count == 0 ? 'gk' : 'k'
  vnoremap <silent><expr> j      v:count == 0 ? 'gj' : 'j'
  nnoremap <silent><expr> <Up>   v:count == 0 ? 'gk' : 'k'
  nnoremap <silent><expr> <Down> v:count == 0 ? 'gj' : 'j'

  noremap  <silent> <Home> g<Home>
  noremap  <silent> <End>  g<End>
  inoremap <silent> <Home> <C-o>g<Home>
  inoremap <silent> <End>  <C-o>g<End>
" Neovim terminal mapping
" terminal 'normal mode'
  tmap <esc> <c-\><c-n><esc><cr>
" exit insert, dd line, enter insert
  inoremap <c-d> <esc>ddi
  noremap H ^
  noremap L g_
  noremap J 5j
  noremap K 5k
  vnoremap <silent> gJ :join<cr>
  " nnoremap K 5k
" this is the best, let me tell you why
" how annoying is that everytime you want to do something in vim
" you have to do shift-; to get :, can't we just do ;?
" Plus what does ; do anyways??
" if you do have a plugin that needs ;, you can just swap the mapping
" nnoremap : ;
" give it a try and you will like it
  nnoremap ; :
  inoremap <c-f> <c-x><c-f>
" Copy to osx clipboard
  vnoremap <C-c> "*y<CR>
  vnoremap y "*y<CR>
  noremap Y y$
  vnoremap y myy`y
  vnoremap Y myY`y
  " let g:multi_cursor_next_key='<C-n>'
  " let g:multi_cursor_prev_key='<C-p>'
  " let g:multi_cursor_skip_key='<C-x>'
  " let g:multi_cursor_quit_key='<Esc>'

" Align blocks of text and keep them selected
  vmap < <gv
  vmap > >gv
  nnoremap <leader>d "_d
  vnoremap <leader>d "_d
  vnoremap <c-/> :TComment<cr>
  nnoremap <silent> <esc> :noh<cr>
  nnoremap <leader>e :call <SID>SynStack()<CR>
  function! <SID>SynStack()
    if !exists("*synstack")
      return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
  endfunc

  function! s:PlaceholderImgTag(size)
    let url = 'http://dummyimage.com/' . a:size . '/000000/555555'
    let [width,height] = split(a:size, 'x')
    execute "normal a<img src=\"".url."\" width=\"".width."\" height=\"".height."\" />"
    endfunction
  command! -nargs=1 PlaceholderImgTag call s:PlaceholderImgTag(<f-args>)
  vnoremap <leader>ga <Plug>(EasyAlign)

"}}}"

" Themes, Commands, etc  ----------------------------------------------------{{{
  syntax on
  function SetItalics() abort
    hi Comment gui=italic
    hi Keyword gui=italic
    hi Keyword gui=italic
    hi Identifier gui=italic
    hi StorageClass gui=italic
    hi jsLineComment gui=italic
    hi xmlAttrib gui=italic
    hi htmlArg gui=italic
    hi pythonSelf gui=italic
    hi htmlArg gui=italic
  endfunction
  autocmd ColorScheme * call SetItalics()
  let g:one_allow_italics = 1
  let g:oceanic_next_terminal_bold = 1
  let g:oceanic_next_terminal_italic = 1
  let g:vim_monokai_tasty_italic = 1
  " set pumblend=50
  " let iterm_profile = $ITERM_PROFILE
  " if iterm_profile == "Light"
    " colorscheme OceanicNextLight
    " let g:airline_theme='oceanicnextlight'
  " else
    colorscheme OceanicNext
    let g:airline_theme='oceanicnext'

  " endif
  " colorscheme vim-monokai-tasty
  let g:Illuminate_ftblacklist = ['nerdtree', 'gitconfig','gina-blame', 'defx', 'fugitive', 'git']

  set list
  set listchars=tab:‣\ ,trail:·
  " colorscheme one
  " set background=dark

"}}}

" Code formatting -----------------------------------------------------------{{{

" ,f to format code, requires formatters: read the docs
"
  noremap <silent> <leader>f :Neoformat<CR>
  let g:standard_prettier_settings = {
              \ 'exe': 'prettier',
              \ 'args': ['--stdin', '--stdin-filepath', '%:p', '--single-quote'],
              \ 'stdin': 1,
              \ }
  let g:neoformat_vue_prettier = {
              \ 'exe': 'vue-formatter',
              \ 'stdin': 1,
        \}
              " \ 'args': ['--stdin', '--stdin-filepath', '%:p', '--single-quote'],
    let g:neoformat_zsh_shfmt = {
              \ 'exe': 'shfmt',
              \ 'args': ['-i ' . shiftwidth()],
              \ 'stdin': 1,
              \ }
  let g:neoformat_enabled_zsh = ['shfmt']

" }}}

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
      " let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - len('lines')
      " let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - len('lines   ')
      let fillcharcount = windowwidth - len(line)
      " return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . ' Lines'
      return line . ''. repeat(" ",fillcharcount)
  endfunction " }}}

  set foldtext=MyFoldText()

  autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
  autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

  " autocmd FileType vim setlocal fdc=1
  set foldlevel=99

  " Space to toggle folds.
  nnoremap <Space> za
  vnoremap <Space> za
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim setlocal foldlevel=0

  autocmd FileType javascript,html,css,scss,typescript setlocal foldlevel=99

  autocmd FileType css,scss,json setlocal foldmethod=marker
  autocmd FileType css,scss,json setlocal foldmarker={,}

  autocmd FileType coffee setl foldmethod=indent
  let g:xml_syntax_folding = 1
  autocmd FileType xml setl foldmethod=syntax

  autocmd FileType html setl foldmethod=expr
  autocmd FileType html setl foldexpr=HTMLFolds()

  " autocmd FileType javascript,typescript,json setl foldmethod=syntax
  autocmd FileType javascript,typescript,typescript.tsx,typescriptreact,json setl foldmethod=syntax

" }}}

" Git -----------------------------------------------------------------------{{{

  " lua vim.api.nvim_command [[autocmd CursorHold   * lua require'git'.blameVirtText()]]
  " lua vim.api.nvim_command [[autocmd CursorMoved  * lua require'git'.clearBlameVirtText()]]
  " lua vim.api.nvim_command [[autocmd CursorMovedI * lua require'git'.clearBlameVirtText()]]
  "
  " hi! link GitLens Comment
  set signcolumn=yes
  set diffopt+=internal,algorithm:patience,iwhiteall
  let g:conflict_marker_enable_mappings = 0
  let g:gitgutter_sign_added = '│'
  let g:gitgutter_sign_modified = '│'
  let g:gitgutter_sign_removed = '│'
  let g:gitgutter_sign_removed_first_line = '│'
  let g:gitgutter_sign_modified_removed = '│'
  let g:gina#command#blame#formatter#format="%in (%au) %ti"
  autocmd FileType fugitive call s:fugitive_settings()
  function! s:fugitive_settings() abort
    setlocal nonumber
  endfunction
" }}}

" NERDTree ------------------------------------------------------------------{{{

  map <silent> - :NERDTreeToggle<CR>
  augroup ntinit
    autocmd FileType nerdtree call s:nerdtreeinit()
  augroup END
  function! s:nerdtreeinit() abort
    set nolist
    if !has("gui_running")
      nunmap <buffer> K
      nunmap <buffer> J



      " call NERDTreeAddKeyMap({
      " \ 'key': '<Tab>',
      " \ 'scope': 'all',
      " \ 'callback': 'NERDTreeMapToggleZoom',
      " \ 'quickhelpText': 'Toggle use existing windows'
      " \ })
      map <silent> <Tab> :call nerdtree#ui_glue#invokeKeyMap("A")<CR>
    endif
  endf
  let NERDTreeShowHidden=1
  let g:NERDTreeWinSize=45
  let NERDTreeMinimalUI=1
  let NERDTreeHijackNetrw=1

  let g:netrw_liststyle = 3
  let g:netrw_browse_split = 4
  let g:netrw_altv = 1
  let g:netrw_winsize = -28
  let g:netrw_banner = 0
  let g:netrw_menu = 0

  let NERDTreeCascadeSingleChildDir=0
  let NERDTreeCascadeOpenSingleChildDir=0
  let g:NERDTreeAutoDeleteBuffer=1
  let g:NERDTreeShowIgnoredStatus = 1
  let g:NERDTreeDirArrowExpandable = ''
  let g:NERDTreeDirArrowCollapsible = ''
" esearch settings {{{

  let g:esearch#cmdline#help_prompt = 1
   let g:esearch#cmdline#dir_icon = ''
   let g:esearch = {
   \ 'adapter':    'ag',
   \ 'backend':    'nvim',
   \ 'use':        ['visual', 'hlsearch', 'last'],
   \}

" }}}


let g:NERDTreeShowIgnoredStatus = 1  "enables ignored highlighting
let g:NERDTreeGitStatusNodeColorization = 1  "enables colorization
let g:NERDTreeGitStatusWithFlags = 1  "enables flags, (may be default), required for colorization
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
highlight link NERDTreeGitStatusIgnored Comment  "custom color

" NERDTree
set hidden

autocmd FileType nerdtree setlocal nolist  "if you show hidden characters, this hides them in NERDTree
 let g:NERDTreeGitStatusIndicatorMap = {
         \ 'Modified'  : '✹',
         \ 'Staged'    : '✚',
         \ 'Untracked' : '✭',
         \ 'Renamed'   : '➜',
         \ 'Unmerged'  : '═',
         \ 'Deleted'   : '✖',
         \ 'Dirty'     : '✗',
         \ 'Clean'     : '✔︎',
         \ 'Ignored'   : '',
         \ 'Unknown'   : '?'
         \ }

"}}}

" LSP -----------------------------------------------------------------------{{{

" When nvim's LSP is ready...
  " lua require
  lua require("lsp_config")
  set omnifunc=v:lua.vim.lsp.omnifunc
  nnoremap <silent> <leader>gdc <cmd>lua vim.lsp.buf.declaration()<CR>
  nnoremap <silent> <leader>gd <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <silent> <leader>gt <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap <silent> <leader>gi <cmd>lua vim.lsp.buf.implementation()<CR>
  nnoremap <silent> <leader>gtd <cmd>lua vim.lsp.buf.type_definition()<CR>
  nnoremap <m-Enter> <cmd>lua vim.lsp.buf.code_action()<CR>
  autocmd CursorHold * silent! :lua vim.lsp.util.show_line_diagnostics()
  let g:LspDiagnosticsErrorSign='•'
  let g:LspDiagnosticsWarningSign='•'
  let g:LspDiagnosticsInformationSign='•'
  let g:LspDiagnosticsHintSign='•'
  " if executable('typescript-language-server')
  "     au User lsp_setup call lsp#register_server({
  "\ 'name': 'typescript-language-server',
  "\ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
  "\ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
  "\ 'whitelist': ['typescript'],
  "\ })
  " endif
  " set omnifunc=lsp#complete

  " let g:lsc_server_commands = {'typescript': 'typescript-language-server --stdio'}
  " highlight link lscDiagnosticError SpellBad
  " highlight link lscDiagnosticWarning SpellBad

  " let g:LanguageClient_selectionUI="location-list"
  " let g:LanguageClient_useVirtualText = 0
  " let g:LanguageClient_diagnosticsDisplay = {
  "\1: { "name": "Error",       "texthl": "SpellBad", "signText": "•", "signTexthl": "ALEErrorSign",  "virtualTexthl": "ErrorMsg", },
  "\2: { "name": "Warning",     "texthl": "SpellBad", "signText": "•", "signTexthl": "ALEWarningSign","virtualTexthl": "Constant", },
  "\3: { "name": "Information", "texthl": "SpellBad", "signText": "•", "signTexthl": "ALEInfoSign",   "virtualTexthl": "Bold",  },
  "\4: { "name": "Hint",        "texthl": "SpellBad", "signText": "•", "signTexthl": "ALEInfoSign",   "virtualTexthl": "Bold",  },
  "\}
  " set completefunc=LanguageClient#complete
  " let g:LanguageClient_serverCommands = {
  "\ 'javascript': ['typescript-language-server', '--stdio'],
  "\ 'typescript': ['typescript-language-server', '--stdio'],
  "\ 'typescript.tsx': ['typescript-language-server', '--stdio'],
  "\ 'typescriptreact': ['typescript-language-server', '--stdio'],
  "\ 'html': ['html-languageserver', '--stdio'],
  "\ 'css': ['css-languageserver', '--stdio']
  "\ }
  "   nnoremap <silent> <leader>gt :call LanguageClient#textDocument_hover()<CR>
  "   nnoremap <silent> <leader>gd :call LanguageClient#textDocument_definition()<CR>
" }}}

" Defx ----------------------------------------------------------------------{{{

  set conceallevel=2
  set concealcursor=nc
  " map <silent> - :Defx<cr>
  autocmd FileType defx call s:defx_my_settings()
  call defx#custom#column('icon', {
     \ 'directory_icon': '',
     \ 'opened_icon':  '',
     \ 'root_icon': '',
     \ 'root_marker_highlight': 'Ignore',
     \ })
  call defx#custom#column('filename', {
     \ 'root_marker_highlight': 'Ignore',
     \ })
  call defx#custom#column('mark', {
        \ 'readonly_icon': '✗',
        \ 'selected_icon': '',
        \ })
  call defx#custom#option('_', {
      \ 'winwidth': 45,
      \ 'columns': 'mark:indent:icon:icons:filename:git',
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 1,
      \ 'buffer_name': '',
      \ 'toggle': 1,
      \ 'resume': 1,
      \ 'root_marker': ':',
      \ })
  function! s:defx_my_settings() abort

    IndentLinesDisable
    setl nospell
    setl signcolumn=no
    setl nonumber
    nnoremap <silent><buffer><expr> <CR> defx#is_directory() ? defx#do_action('open_or_close_tree') : defx#do_action('drop')
    nnoremap <silent><buffer><expr> l defx#is_directory() ? defx#do_action('open_or_close_tree') : defx#do_action('drop')
    nnoremap <silent><buffer><expr> h defx#do_action('close_tree')
    nnoremap <silent><buffer><expr> C defx#do_action('copy')
    nnoremap <silent><buffer><expr> P defx#do_action('paste')
    nnoremap <silent><buffer><expr> M defx#do_action('rename')
    nnoremap <silent><buffer><expr> D defx#do_action('remove_trash')
    nnoremap <silent><buffer><expr> A defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> S defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr> U defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select')
    nnoremap <silent><buffer><expr> R defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <Tab> <SID>defx_toggle_zoom()

  endfunction

  function s:defx_toggle_zoom() abort "{{{
    let b:DefxOldWindowSize = get(b:, 'DefxOldWindowSize', winwidth('%'))
    let size = b:DefxOldWindowSize
    if exists("b:DefxZoomed") && b:DefxZoomed
        exec "silent vertical resize ". size
        let b:DefxZoomed = 0
    else
        exec "vertical resize ". get(g:, 'DefxWinSizeMax', '')
        let b:DefxZoomed = 1
    endif
  endfunction "}}}

  let g:defx_git#show_ignored = 0
  let g:defx_git#column_length = 1

  hi def link Defx_filename_directory NERDTreeDirSlash
  hi def link Defx_git_Modified Special
  hi def link Defx_git_Staged Function
  hi def link Defx_git_Renamed Title
  hi def link Defx_git_Unmerged Label
  hi def link Defx_git_Untracked Tag
  hi def link Defx_git_Ignored Comment

  let g:defx_icons_parent_icon = ""
  let g:defx_icons_mark_icon = ''
  let g:defx_icons_enable_syntax_highlight = 1
  let g:defx_icons_column_length = 1
  let g:defx_icons_mark_icon = '*'
  let g:defx_icons_default_icon = ''
  let g:defx_icons_directory_symlink_icon = ''
  " Options below are applicable only when using "tree" feature
  "
  " let s:parentIcons = defx_icons#get()
  " echo s:parentIcons
  let g:defx_icons_directory_icon = ''
  let g:defx_icons_root_opened_tree_icon = ''
  let g:defx_icons_nested_opened_tree_icon = ''
  let g:defx_icons_nested_closed_tree_icon = ''

"  }}}

" Nvim terminal -------------------------------------------------------------{{{

  au BufEnter * if &buftype == 'terminal' | :startinsert | endif
  autocmd BufEnter term://* startinsert
  autocmd TermOpen * set bufhidden=hide

" }}}

" Vim-Devicons --------------------------------------------------------------{{{

  let g:NERDTreeGitStatusNodeColorization = 1
  " 
  let g:webdevicons_enable_denite = 0
  let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
  let g:DevIconsEnableFoldersOpenClose = 1
  let g:WebDevIconsOS = 'Darwin'
  let g:WebDevIconsUnicodeDecorateFolderNodes = 1
  let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = ''
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = { } " needed
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ''
  " let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['tsx'] = 'ﯤ'
  " let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['ts'] = 'ﯤ'
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vim'] = ''
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['css'] = ''
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json'] = ''
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
  let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['sql'] = ''

" }}}

" Snipppets -----------------------------------------------------------------{{{

" Enable snipMate compatibility feature.
  let g:neosnippet#enable_completed_snippet=0
  let g:neosnippet#enable_snipmate_compatibility=0
  " let g:neosnippet#enable_conceal_markers=0
  let g:neosnippet#snippets_directory='~/GitHub/ionic-snippets'
  " let g:neosnippet#expand_word_boundary = 1
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)

" " SuperTab like snippets behavior.
"   imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"   \ "\<Plug>(neosnippet_expand_or_jump)"
"   \: pumvisible() ? "\<C-n>" : "\<TAB>"
"   smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"   \ "\<Plug>(neosnippet_expand_or_jump)"
"   \: "\<TAB>"
"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

"}}}

" Deoplete ------------------------------------------------------------------{{{

  " enable deoplete
  let g:deoplete#enable_at_startup = 1

  call deoplete#custom#option({
  \ 'auto_complete_delay': 0,
  \ 'smart_case': v:true,
  \})
  call deoplete#custom#option('ignore_sources', {'_': ['buffer', 'around', 'member', 'omni']})
  call deoplete#custom#option('omni_patterns', {
  \ 'html': '',
  \ 'css': '',
  \ 'scss': ''
  \})
  let g:echodoc_enable_at_startup=1
  let g:echodoc#type="virtual"
  set splitbelow
  set completeopt+=menuone,noinsert,noselect
  set completeopt-=preview
  autocmd CompleteDone * pclose

  function g:Multiple_cursors_before()
    call deoplete#custom#buffer_option('auto_complete', v:false)
  endfunction
  function g:Multiple_cursors_after()
    call deoplete#custom#buffer_option('auto_complete', v:true)
  endfunction


  let g:deoplete#file#enable_buffer_path=1
  " call deoplete#custom#source('buffer', 'mark', 'ℬ')
  " call deoplete#custom#source('tern', 'mark', '')
  " call deoplete#custom#source('omni', 'mark', '⌾')
  " call deoplete#custom#source('file', 'mark', '')
  " call deoplete#custom#source('jedi', 'mark', '')
  " call deoplete#custom#source('neosnippet', 'mark', '')
  " call deoplete#custom#source('LanguageClient', 'mark', '')
  " call deoplete#custom#source('typescript',  'rank', 630)
  " call deoplete#custom#source('_', 'matchers', ['matcher_cpsm'])
  " call deoplete#custom#source('_', 'sorters', [])
  function! Preview_func()
    if &pvw
      setlocal nonumber norelativenumber
     endif
  endfunction
  autocmd WinEnter * call Preview_func()
  " let g:deoplete#ignore_sources = {'_': ['around', 'buffer', 'member', 'omni' ]}

  " let g:deoplete#enable_debug = 1
  " call deoplete#enable_logging('WARN', 'deoplete.log')
  " call deoplete#custom#source('typescript', 'is_debug_enabled', v:true)
"}}}

" Emmet customization -------------------------------------------------------{{{

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
    return emmet#expandAbbrIntelligent("\<tab>")
    " return "\<C-y>,"
  endif
" return a regular tab character
  return "\<tab>"
  endfunction
  " let g:user_emmet_expandabbr_key='<Tab>'
  " imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

  autocmd FileType html,css,scss,typescriptreact,vue,javascript,markdown.mdx imap <silent><buffer><expr><tab> <sid>expand_html_tab()
  let g:user_emmet_mode='a'
  let g:user_emmet_complete_tag = 0
  let g:user_emmet_install_global = 0
  autocmd FileType html,css,scss,typescriptreact,vue,javascript,markdown.mdx EmmetInstall
"}}}

" Denite --------------------------------------------------------------------{{{

  let s:menus = {}
  call denite#custom#option('_', {
      \ 'prompt': '❯',
      \ 'winheight': 10,
      \ 'filter_updatetime': 1,
      \ 'auto_resize': v:true,
      \ 'highlight_matched_char': 'Underlined',
      \ 'highlight_mode_normal': 'CursorLine',
      \ 'reversed': v:true,
      \ 'start_filter': v:true,
      \})
  call denite#custom#option('TSDocumentSymbol', {
      \ 'prompt': '@ ' ,
      \ 'reversed': v:false,
      \})
  call denite#custom#option('TSWorkspaceSymbol', {
      \ 'prompt': '# ' ,
      \ 'reversed': v:false,
      \})
  "
  call denite#custom#source('file/rec', 'vars', {
      \'command': ['rg', '--files', '--glob', '!.git'],
      \'sorters':['sorter_sublime'],
      \'matchers': ['matcher/fruzzy'],
      \})
  call denite#custom#source('grep', 'vars', {
      \'command': ['rg'],
      \'default_opts': ['-i', '--vimgrep'],
      \'recursive_opts': [],
      \'pattern_opt': [],
      \'separator': ['--'],
      \'final_opts': [],
      \'matchers': ['matcher/ignore_globs', 'matcher/regexp', 'matcher/pyfuzzy']
      \})

  let g:ctrlp_user_command="rg --files --glob !.git"
  let g:ctrlp_grep_command_definition="rg -i --vimgrep"
  let g:ctrlp_use_caching = 0
  let g:ctrlp_match_func = {'match': 'fruzzy#ctrlp#matcher'}
  let g:ctrlp_map = ''
  let fruzzy#usenative = 1



  " nnoremap <silent> <c-p>      :Denite file/rec<CR>
  nnoremap <silent> <c-p>      :Clap files<CR>

  nnoremap <silent> <leader>h  :Denite help<CR>
  nnoremap <silent> <leader>v  :Denite vison<CR>
  nnoremap <silent> <leader>c  :Denite colorscheme<CR>
  nnoremap <silent> <leader>al :Denite airline<CR>
  nnoremap <silent> <leader>b  :Denite buffer<CR>
  nnoremap <silent> <leader>l  :Denite line<CR>
  nnoremap <silent> <leader>a  :Denite grep:::!<CR>
  nnoremap <silent> <leader>u  :DeinUpdate<CR>
  nnoremap <silent> <Leader>i  :Denite menu:ionic <CR>
  nnoremap <silent> z=   :Denite -no-start-filter spell <CR>


  autocmd FileType denite call s:denite_my_settings()
  function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>    denite#do_map('do_action')

    nnoremap <silent><buffer><expr> <Tab>    denite#do_map('choose_action')
    nnoremap <silent><buffer><expr> <ESC>   denite#do_map('quit')
    nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select')
    nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  endfunction

  autocmd FileType denite-filter call s:denite_filter_settings()
  function s:denite_filter_settings() abort
    setl nonumber
    call deoplete#custom#buffer_option('auto_complete', v:false)
    " nunmap <CR>
    inoremap <silent><buffer><expr> <ESC> denite#do_map('quit')
    " inoremap <silent><buffer> <ESC> <Plug>(denite_filter_quit)
    " imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
    inoremap <silent><buffer> <CR>  <ESC><C-w>p:call denite#call_map('do_action')<CR>
    " inoremap <silent><buffer> <CR>  <Esc><C-w>p<CR>

    " inoremap <silent><buffer> <Space> <Esc><C-w>p:call denite#call_map()('toggle_select', [])<CR><C-w>pA
    inoremap <silent><buffer> <Tab>   <Esc><C-w>p:call denite#call_map('choose_action')<CR>
    inoremap <silent><buffer> <Space> <Esc><C-w>p:call denite#call_map('toggle_select')<CR><C-w>pA
    inoremap <silent><buffer> <C-n>   <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
    inoremap <silent><buffer> <C-p>   <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
  endfunction

  call denite#custom#map('insert','<C-n>','<denite:move_to_next_line>','noremap')
  call denite#custom#map('insert','<C-p>','<denite:move_to_previous_line>','noremap')

  call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
   \ [ '.git/', '.ropeproject/', '__pycache__/',
   \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])
  call denite#custom#var('menu', 'menus', s:menus)
"}}}

" Ionic denite source -------------------------------------------------------{{{

  function! Ionic(job) abort
    if a:job ==# "serve"
      enew!
      let filename = 'Ionic:\ '. a:job
      call termopen('ionic '. a:job)
      exe 'file 'filename
      startinsert
    else
      let platform = input('platform: ')
      enew!
      let filename = 'Ionic:\ '. a:job
      call termopen('ionic cordova'. a:job . ' ' . platform)
      exe 'file 'filename
      startinsert
    endif
  endfunction

  function ExitHandle()
    echom self
  endfunction

  let s:menus.ionic = {
    \ 'description' : 'some rando ionic stuff',
    \}
  let s:menus.ionic.command_candidates = [
    \[' serve', 'call Ionic("serve")' ],
    \[' run device', 'call Ionic("run")'],
    \[' emulate device', 'call Ionic("emulate")'],
    \]
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

  let g:webdevicons_enable_airline_statusline = 1
  if !exists('g:airline_symbols')
    let g:airline_symbols = {
      \ 'branch': '',
      \ 'modified': ' ●'
      \}
  endif

  " let w:airline_disabled = 1
  let g:airline_powerline_fonts = 0
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  let g:airline#extensions#tabline#left_alt_sep = ''
  let g:airline#extensions#tabline#left_sep = " "
  let g:airline#extensions#nvim_typescript#enabled=1
  let w:airline_skip_empty_sections = 0
  " cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == 'x' ? 'x' : 'bd'
  cnoreabbrev x Sayonara
  " cnoreabbrev x bd
  tmap <leader>x <c-\><c-n>:bp! <BAR> bd! #<CR>
  nmap <silent><leader>, :bnext<CR>
  tmap <leader>, <C-\><C-n>:bnext<cr>
  nmap <silent><leader>. :bprevious<CR>
  tmap <leader>. <C-\><C-n>:bprevious<CR>
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
  let g:airline#extensions#branch#format = 0
  let g:airline_detect_spelllang=0
  let g:airline_detect_spell=0
  let g:airline#extensions#hunks#enabled = 0
  let g:airline#extensions#wordcount#enabled = 0
  let g:airline#extensions#whitespace#enabled = 0
  let g:airline_section_c = '%f%m'
  let g:airline_section_x = ''
  let g:airline_section_y = ''
  let g:airline_section_z = '%l:%c'
  let g:airline#parts#ffenc#skip_expected_string=''
  let g:airline_mode_map = {
      \ '__' : '',
      \ 'c'  : '',
      \ 'i'  : '',
      \ 'ic' : '',
      \ 'ix' : '',
      \ 'n'  : '',
      \ 'ni' : '',
      \ 'no' : '',
      \ 'R'  : '',
      \ 'Rv' : '',
      \ 's'  : '',
      \ 'S'  : '',
      \ '' : '',
      \ 't'  : '',
      \ 'v'  : '',
      \ 'V'  : '',
      \ '' : '',
      \ }

  let g:airline#extensions#tabline#buffer_idx_format = {
      \ '0': '0 ',
      \ '1': '1 ',
      \ '2': '2 ',
      \ '3': '3 ',
      \ '4': '4 ',
      \ '5': '5 ',
      \ '6': '6 ',
      \ '7': '7 ',
      \ '8': '8 ',
      \ '9': '9 ',
      \}

"}}}

" Linting -------------------------------------------------------------------{{{

  " call neomake#configure#automake({
  "\ 'BufWritePost': {'delay': 0},
  "\ 'BufWinEnter': {},
  "\ 'TextChanged': {},
  "\ 'InsertLeave': { },
  "\ }, 1000)
  " call neomake#configure#automake({
  " \ 'BufWritePost': {},
  " \ }, 0)

  let g:ale_sign_error = '•'
  let g:ale_sign_warning = '•'
  let g:airline#extensions#ale#error_symbol='• '
  let g:airline#extensions#ale#warning_symbol='•  '
  let g:airline#extensions#neomake#error_symbol='• '
  let g:airline#extensions#neomake#warning_symbol='•  '
  " let g:neomake_typescript_tsc_tempfile_enabled = 0
  " let g:neomake_typescript_tslint_tempfile_enabled = 0
  let g:neomake_warning_sign = {'text': '•'}
  let g:neomake_error_sign = {'text': '•'}
  let g:neomake_info_sign = {'text': '•'}
  let g:neomake_message_sign = {'text': '•'}

  hi link ALEError SpellBad
  hi link ALEWarning SpellBad
  " Write this in your vimrc file
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_lint_on_enter = 0
  " let g:neomake_verbose = 3
"}}}

" MarkDown ------------------------------------------------------------------{{{

  noremap <leader>TM :TableModeToggle<CR>
  let g:table_mode_corner="|"
  let g:markdown_fold_override_foldtext = 0
  let g:neomake_markdown_proselint_maker = {
      \ 'errorformat': '%W%f:%l:%c: %m',
      \ 'postprocess': function('neomake#postprocess#generic_length'),
      \}
  let g:neomake_markdown_enabled_makers = ['proselint']
  let g:markdown_syntax_conceal = 0
  let g:mkdp_auto_start = 0
  let g:neoformat_markdown_prettier = g:standard_prettier_settings
  let g:neoformat_enabled_markdown = ['prettier']
  let g:neomake_tempfile_enabled = 0
"}}}

" MultiCursor ---------------------------------------------------------------{{{

  let g:multi_cursor_exit_from_visual_mode=0
  let g:multi_cursor_exit_from_insert_mode=0
"}}}

" Javascript ----------------------------------------------------------------{{{
  " set nobinary
  " let $NVIM_NODE_LOG_FILE='nvim-node.log'
  " let $NVIM_NODE_LOG_LEVEL='warn'
  " let $NVIM_NODE_HOST_DEBUG=1
  let g:neoformat_javascript_prettier = g:standard_prettier_settings
  let g:neoformat_enabled_javascript = ['prettier']

  autocmd FileType vue syntax sync fromstart

  let g:jsx_ext_required = 0
  let g:neomake_javascript_enabled_makers = []
  let g:jsdoc_allow_input_prompt = 1
  let g:jsdoc_input_description = 1
  let g:jsdoc_return=0
  let g:jsdoc_return_type=0

  let g:neoformat_json_prettier = g:standard_prettier_settings
  let g:neoformat_enabled_json = ['prettier']
  let g:vim_json_syntax_conceal = 0

  let g:nvim_typescript#max_completion_detail=50
  let g:nvim_typescript#completion_mark=''
  let g:nvim_typescript#javascript_support=1
  let g:nvim_typescript#expand_snippet=0
  let g:nvim_typescript#vue_support=0
  let g:nvim_typescript#diagnostics_enable=1
  let g:nvim_typescript#type_info_on_hold=0
  let g:nvim_typescript#suggestions_enabled=1

  autocmd FileType typescript,typescriptreact,javascript setl omnifunc=TSOmniFunc
  autocmd FileType typescript,typescriptreact,javascript map <silent> <leader>gd :TSDoc <cr>
  autocmd FileType typescript,typescriptreact,javascript map <silent> <leader>gt :TSType <cr>
  autocmd FileType typescript,typescriptreact,javascript map <silent> <leader>gtd :TSTypeDef <cr>
  autocmd FileType typescript,typescriptreact,javascript map <silent> <leader>gtD :TSDef <cr>
  autocmd FileType typescript,typescriptreact,javascript map <silent> <leader>@ :Denite -buffer-name=TSDocumentSymbol TSDocumentSymbol <cr>
  autocmd FileType typescript,typescriptreact,javascript map <silent> <leader># :Denite -buffer-name=TSWorkspaceSymbol TSWorkspaceSymbol <cr>
  autocmd FileType typescript,typescriptreact,javascript map <silent> <leader>ti :TSImport <cr>
  autocmd FileType typescript,typescriptreact,javascript nnoremap <m-Enter> :TSGetCodeFix<CR>

  let g:neomake_typescript_enabled_makers = []
  " let g:neomake_typescript_enabled_makers = ['nvim_ts']
  let g:neomake_vue_enabled_makers = []
  let g:neoformat_typescript_prettier = g:standard_prettier_settings
  let g:neoformat_enabled_typescript = ['prettier']
  let g:neoformat_typescriptreact_prettier = g:standard_prettier_settings
  let g:neoformat_enabled_typescriptreact = ['prettier']
  let g:nvim_typescript#kind_symbols = {
      \ 'keyword': 'keyword',
      \ 'class': '',
      \ 'interface': '',
      \ 'script': 'script',
      \ 'module': '',
      \ 'local class': 'local class',
      \ 'type': '',
      \ 'enum': '',
      \ 'enum member': '',
      \ 'alias': '',
      \ 'type parameter': 'type param',
      \ 'primitive type': 'primitive type',
      \ 'var': '',
      \ 'local var': '',
      \ 'property': '',
      \ 'let': '',
      \ 'const': '',
      \ 'label': 'label',
      \ 'parameter': 'param',
      \ 'index': 'index',
      \ 'function': '',
      \ 'local function': 'local function',
      \ 'method': '',
      \ 'getter': '',
      \ 'setter': '',
      \ 'call': 'call',
      \ 'constructor': '',
      \}


  let s:menus.typescript = {
    \ 'description' : 'typescript commands',
    \}
  let s:menus.typescript.command_candidates = [
    \['Get Type', 'TSType' ],
    \['Get Doc', 'TSDoc'],
    \['Edit Project Config', 'TSEditConfig'],
    \['Restart Server', 'TSRestart'],
    \['Start Server', 'TSStart'],
    \['Stop Server', 'TSStop'],
    \]

  hi TSErrorTexthl gui=underline
  hi TSWarningTexthl gui=underline
  hi TSSuggestionTexthl gui=underline
  hi TSErrorSignhl ctermfg=203 ctermbg=235 guifg=#ec5f67 guibg=#1b2b34
  hi TSWarningSignhl ctermfg=221 ctermbg=235 guifg=#fac863 guibg=#1b2b34
  hi TSInfoSignhl ctermfg=15 ctermbg=235 guifg=#ffffff guibg=#1b2b34

  let g:nvim_typescript#default_signs = [
      \{ 'TSerror':      { 'texthl': 'TSErrorTexthl', 'signText':      '•', 'signTexthl': 'TSErrorSignhl' } },
      \{ 'TSwarning':    { 'texthl': 'TSWarningTexthl', 'signText':    '•', 'signTexthl': 'TSWarningSignhl' } },
      \{ 'TSsuggestion': { 'texthl': 'TSSuggestionTexthl', 'signText': '･', 'signTexthl': 'TSInfoSignhl' } },
      \{ 'TShint':       { 'texthl': 'SpellBad', 'signText':           '?', 'signTexthl': 'TSInfoSignhl' } }
      \]
" }}}

" Java ----------------------------------------------------------------------{{{

  autocmd FileType java setlocal omnifunc=javacomplete#Complete
  " let g:deoplete#sources#clang#libclang_path="/usr/local/Cellar/llvm/HEAD-74479e8/lib/libclang.dylib"
  " let g:deoplete#sources#clang#clang_header="/usr/bin/clang"
"}}}

" HTML ----------------------------------------------------------------------{{{

  let g:neoformat_enabled_vue = ['prettier']
  let g:neomake_html_enabled_makers = []
  let g:neoformat_enabled_html = ['htmlbeautify']

  " let g:neoformat_html_prettier = g:standard_prettier_settings
  " let g:neoformat_enabled_html = ['prettier']
" }}}

" Go ------------------------------------------------------------------------{{{

  let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'

"}}}

" CSS -----------------------------------------------------------------------{{{

  let g:neoformat_scss_prettier = g:standard_prettier_settings
  let g:neoformat_enabled_scss = ['prettier']
  let g:neomake_scss_enabled_makers = ['stylelint']
  lua require 'colorizer'.setup()

"}}}

" Lua -----------------------------------------------------------------------{{{
  " lua require("lsp-config").setup()

"}}}

" Python --------------------------------------------------------------------{{{

  " let g:python_host_prog = '/usr/local/opt/python@2/bin/python2'
  " let g:loaded_python_provider = 0
  " let g:python3_host_prog = '/usr/local/bin/python3'
  " " let $NVIM_PYTHON_LOG_FILE='nvim-python.log'
  " let g:jedi#auto_vim_configuration = 0
  " let g:jedi#documentation_command = "<leader>k"
  " let g:jedi#completions_enabled = 0
  " let g:jedi#force_py_version=3
" }}}

" Rust ----------------------------------------------------------------------{{{

  let g:racer_cmd = '/Users/mhartington/.cargo/bin/racer'
  " let g:racer_experimental_completer = 1
"}}}
