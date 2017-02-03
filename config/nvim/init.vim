"|  \/  (_) |                        (_)
"| .  . |_| | _____  ___   _ ____   ___ _ __ ___  _ __ ___
"| |\/| | | |/ / _ \/ __| | '_ \ \ / / | '_ ` _ \| '__/ __|
"| |  | | |   <  __/\__ \ | | | \ V /| | | | | | | | | (__
"\_|  |_/_|_|\_\___||___/ |_| |_|\_/ |_|_| |_| |_|_|  \___|
"
" Author: Mike Hartington
" repo  : https://github.com/mhartington/dotfiles/
"

" Setup dein  ---------------------------------------------------------------{{{
  if (!isdirectory(expand("$HOME/.config/nvim/repos/github.com/Shougo/dein.vim")))
    call system(expand("mkdir -p $HOME/.config/nvim/repos/github.com"))
    call system(expand("git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/repos/github.com/Shougo/dein.vim"))
  endif

  set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim/
  call dein#begin(expand('~/.config/nvim'))
  call dein#add('Shougo/dein.vim')
  call dein#add('haya14busa/dein-command.vim')



" syntax
  call dein#add('othree/html5.vim')

  call dein#add('othree/yajs.vim')
  call dein#add('othree/jspc.vim')
  " call dein#add('othree/es.next.syntax.vim')
  call dein#add('othree/jsdoc-syntax.vim')
  call dein#add('heavenshell/vim-jsdoc')
  call dein#add('moll/vim-node')

  call dein#add('elzr/vim-json',{'on_ft': 'json'})

  call dein#add('hail2u/vim-css3-syntax', {'on_ft':['css','scss']})
  call dein#add('ap/vim-css-color')

  call dein#add('tpope/vim-markdown', {'on_ft': 'markdown'})
  call dein#add('dhruvasagar/vim-table-mode')
  call dein#add('nelstrom/vim-markdown-folding')
  call dein#add('tyru/markdown-codehl-onthefly.vim')

  call dein#add('tmhedberg/SimpylFold', {'on_ft': 'python'})
  call dein#add('dearrrfish/vim-applescript')

  call dein#add('HerringtonDarkholme/yats.vim')
  call dein#add('tmux-plugins/vim-tmux')

  call dein#add('itmammoth/doorboy.vim')
  call dein#add('valloric/MatchTagAlways', {'on_ft': 'html'})

  " call dein#add('tpope/vim-fugitive')
  call dein#add('lambdalisue/vim-gita')
  call dein#add('lambdalisue/gina.vim')
  " call dein#add('tpope/vim-rhubarb')
  call dein#add('jreybert/vimagit')
  call dein#add('airblade/vim-gitgutter')

  call dein#add('scrooloose/nerdtree')
  call dein#add('Xuyuanp/nerdtree-git-plugin')

  call dein#add('tpope/vim-repeat')

  call dein#add('neomake/neomake')
  " call dein#add('w0rp/ale')

  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('AndrewRadev/switch.vim')

  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('vim-airline/vim-airline')

  call dein#add('tpope/vim-surround')
  call dein#add('tomtom/tcomment_vim')
  call dein#add('mattn/emmet-vim')

  call dein#add('sbdchd/neoformat')
" deoplete stuff
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/deol.nvim')
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/context_filetype.vim')

  "call dein#add('ternjs/tern_for_vim', {'build': 'npm install'})
  "call dein#add('carlitux/deoplete-ternjs', {'on_ft': 'javascript'})

  call dein#add('artur-shaik/vim-javacomplete2', {'on_ft': 'java'})
  call dein#add('Shougo/neco-vim', {'on_ft': 'vim'})
  call dein#add('Shougo/neoinclude.vim')
  " call dein#add('ujihisa/neco-look')

  " call dein#add('davidhalter/jedi-vim', {'on_ft': 'python'})
  call dein#add('zchee/deoplete-jedi', {'on_ft': 'python'})

  call dein#add('zchee/deoplete-zsh')
  call dein#add('Valodim/vim-zsh-completion')

  call dein#add('zchee/nvim-go', {'build': 'gb build'})
  " call dein#add('fatih/vim-go')
  call dein#add('zchee/deoplete-go', {'build': 'make'})

  call dein#add('Konfekt/FastFold')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/echodoc.vim')
  call dein#add('honza/vim-snippets')
  call dein#add('mhinz/vim-sayonara')
  call dein#add('mattn/webapi-vim')
  call dein#add('mattn/gist-vim')
  call dein#add('terryma/vim-multiple-cursors')
  call dein#add('vim-scripts/SyntaxRange')
  call dein#add('tyru/open-browser.vim')
  call dein#add('junegunn/vim-easy-align')
  call dein#add('MartinLafreniere/vim-PairTools')
  call dein#add('Shougo/vimfiler.vim')
  " call dein#add('tpope/vim-vinegar')
  call dein#add('Shougo/unite.vim')
  call dein#add('junegunn/gv.vim')
  call dein#add('rking/ag.vim')
  call dein#local('~/GitHub', {},['vim-folds'])
  call dein#local('~/GitHub', {},['oceanic-next'])
  call dein#local('~/GitHub', {},['operator-next'])
  call dein#local('~/GitHub', {},['nvim-typescript'])
  call dein#local('~/GitHub', {},['vim-angular2-snippets'])
  call dein#local('~/GitHub', {},['deoplete-github'])
  " call dein#local('~/GitHub', {},['denite.nvim'])
  " call dein#local('~/GitHub', {},['neomake'])
  call dein#add('Yggdroot/indentLine')
  call dein#local('~/GitHub', {},['deoplete-css'])
  " call dein#add('majutsushi/tagbar')
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')
  if dein#check_install()
    call dein#install()
    let pluginsExist=1
  endif

  call dein#end()
  filetype plugin indent on
" }}}

" System Settings  ----------------------------------------------------------{{{
  source ~/.local.vim
" Neovim Settings
  set termguicolors
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  set clipboard+=unnamedplus
" Currently needed for neovim paste issue
  set pastetoggle=<f6>
  set nopaste
  autocmd BufWritePre * %s/\s\+$//e
" Let airline tell me my status
  set noshowmode
  set noswapfile
  filetype on
  set  number
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
  set updatetime=500
  set complete=.,w,b,u,t,k
  autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
  autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)

  let g:indentLine_char='│'
  let g:indentLine_color_gui = '#74818b'
  let g:table_mode_corner="|"

  set formatoptions+=t
  set inccommand=nosplit
  set shortmess=atI



  let g:dein#enable_notification = 1
  let g:dein#install_progress_type="tabline"
  let g:dein#install_message_type="none"

  if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  endif
" }}}

" System mappings  ----------------------------------------------------------{{{
  let g:lmap =  {}
" No need for ex mode
  nnoremap Q <nop>
  vnoremap // y/<C-R>"<CR>
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
  nmap cp :let @+= expand("%") <cr>
" Neovim terminal mapping
" terminal 'normal mode'
  tmap <esc> <c-\><c-n><esc><cr>
  noremap <leader>TM :TableModeToggle<CR>
" exit insert, dd line, enter insert
  inoremap <c-d> <esc>ddi
  noremap H ^
  noremap L g_
  noremap J 5j
  noremap K 5k
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
  " vnoremap y "*y<CR>
  " nnoremap Y "*Y<CR>
  " vnoremap y myy`y
  " vnoremap Y myY`y
  let g:multi_cursor_next_key='<C-n>'
  let g:multi_cursor_prev_key='<C-p>'
  let g:multi_cursor_skip_key='<C-x>'
  let g:multi_cursor_quit_key='<Esc>'

" Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)

" Align blocks of text and keep them selected
  vmap < <gv
  vmap > >gv
  nnoremap <leader>d "_d
  vnoremap <leader>d "_d
  vnoremap <c-/> :TComment<cr>
  map <silent> <esc> :noh<cr>

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


  " If you prefer the Omni-Completion tip window to close when a selection is
  " made, these lines close it on movement in insert mode or when leaving
  " insert mode
  " autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
  " autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"}}}"

" Themes, Commands, etc  ----------------------------------------------------{{{
" Theme
  syntax on
  " set background=dark
  colorscheme OceanicNext
  " colorscheme OperatorNext
  " colorscheme OceanicNextLight
" set background=light
" highlight bad words in red
  " autocmd FileType ghmarkdown,markdown,text,html hi SpellBad guibg=#ff2929 guifg=#ffffff" ctermbg=224
"}}}

" MarkDown ------------------------------------------------------------------{{{
" no need to fold things in markdown all the time
  " let g:vim_markdown_folding_disabled = 1
  " let g:instant_markdown_autostart = 0
" turn on spelling for markdown files
  " autocmd FileType ghmarkdown,markdown,text,html setlocal spell complete+=kspell
" don't mess with folding text for markdown
  " let g:markdown_fold_override_foldtext = 1
  " let g:vim_markdown_conceal = 1
  " let g:gfm_syntax_enable_always = 1
"}}}

" Javascript ----------------------------------------------------------------{{{
  " let $NEOVIM_JS_DEBUG="nvimjs.log"
  " let g:chromatica#enable_at_startup=1
  " let g:chromatica#libclang_path='/usr/local/opt/llvm/lib'
  let g:tigris#enabled = 1
  let g:tigris#on_the_fly_enabled = 1
  let g:tigris#debug = 1
  let g:jsdoc_allow_input_prompt = 1
  let g:jsdoc_input_description = 1
  let g:vim_json_syntax_conceal = 0

  " autocmd FileType typescript let g:pairtools_typescript_tagwrenchhook = 'tagwrench#BuiltinHTML5Hook'
  " autocmd FileType typescript let g:pairtools_typescript_twexpander = 1
  " autocmd FileType typescript let g:pairtools_typescript_tweraser   = 1
  " autocmd FileType typescript let g:pairtools_typescript_tagwrench = 1
  " autocmd FileType typescript let g:pairtools_typescript_apostrophe = 0
  " autocmd FileType typescript let g:pairtools_typescript_jigsaw    = 1

  " Use tern_for_vim.
  let g:tern#command = ['tern']
  let g:tern#arguments = ['--persistent']
  set isfname-==
  set shortmess+=c
  " set cmdheight=2
  " let g:nvim_typescript#type_info_on_hold=1
  " let g:nvim_typescript#javascript_support = 1
  let g:nvim_typescript#max_completion_detail=100
  map <silent> <leader>D :TSDoc <cr>
" }}}

" Java ----------------------------------------------------------------------{{{
    autocmd FileType java setlocal omnifunc=javacomplete#Complete

"}}}

" Go ------------------------------------------------------------------------{{{
  let g:go_fmt_command = "goimports"
"}}}

" CSS -----------------------------------------------------------------------{{{
   let g:formatdef_cssbeautify = '"css-beautify -f - -s ".shiftwidth()'
   let g:formatters_scss = ['cssbeautify']
"}}}

" Python --------------------------------------------------------------------{{{

  " let $NVIM_PYTHON_LOG_FILE="nvimpy.log"
  " let $NVIM_PYTHON_LOG_LEVEL='DEBUG'
  let g:jedi#auto_vim_configuration = 0
  let g:jedi#documentation_command = "<leader>k"

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
      let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - len('lines')
      return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . ' Lines '
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

  autocmd FileType html setlocal fdl=99

  autocmd FileType javascript,html,css,scss,typescript setlocal foldlevel=99
  autocmd FileType css,scss,json setlocal foldmethod=marker
  autocmd FileType css,scss,json setlocal foldmarker={,}

  autocmd FileType coffee setl foldmethod=indent
  autocmd FileType html setl foldmethod=expr
  let g:xml_syntax_folding = 1
  autocmd FileType xml setl foldmethod=syntax
  autocmd FileType html setl foldexpr=HTMLFolds()

  autocmd FileType javascript,typescript,json setl foldmethod=syntax
" }}}

" Git -----------------------------------------------------------------------{{{
	vnoremap <leader>gb :Gblame<CR>
	nnoremap <leader>gb :Gblame<CR>

" }}}

" NERDTree ------------------------------------------------------------------{{{
  " map <silent> - :VimFiler<CR>
	" let g:vimfiler_tree_leaf_icon = ''
	" let g:vimfiler_tree_opened_icon = '▾'
	" let g:vimfiler_tree_closed_icon = '▸'
	" let g:vimfiler_file_icon = ''
	" let g:vimfiler_marked_file_icon = '*'
  " let g:vimfiler_expand_jump_to_first_child = 0
  " let g:vimfiler_force_overwrite_statusline = 0
  " call vimfiler#custom#profile('default', 'context', {
  "             \ 'explorer' : 1,
  "             \ 'winwidth' : 35,
  "             \ 'winminwidth' : 35,
  "             \ 'toggle' : 1,
  "             \ 'auto_expand': 0,
  "             \ 'parent': 1,
  "             \ 'explorer_columns' : 'devicons:git',
  "             \ 'status' : 0,
  "             \ 'safe' : 0,
  "             \ 'split' : 1,
  "             \ 'hidden': 1,
  "             \ 'no_quit' : 1,
  "             \ 'force_hide' : 0,
  "             \ })
  " augroup vfinit
  " autocmd FileType vimfiler call s:vimfilerinit()
  " augroup END
  " function! s:vimfilerinit()
  "     set nonumber
  "     set norelativenumber
  "     nmap <silent><buffer><expr> <CR> vimfiler#smart_cursor_map(
  "           \ "\<Plug>(vimfiler_expand_tree)",
  "           \ "\<Plug>(vimfiler_edit_file)"
  "           \)
  "     nmap <silent> m :call NerdUnite()<cr>
  "     nmap <silent> r <Plug>(vimfiler_redraw_screen)
  " endf
  " let g:vimfiler_ignore_pattern = '^\%(\.git\|\.DS_Store\)$'
  " let g:webdevicons_enable_vimfiler = 0
  " let g:vimfiler_no_default_key_mappings=1
  " function! NerdUnite() abort "{{{
  "   let marked_files =  vimfiler#get_file(b:vimfiler)
  "   call unite#start(['nerd'], {'file': marked_files})
	" endfunction "}}}

  augroup ntinit
  autocmd FileType nerdtree call s:nerdtreeinit()
  augroup END
  function! s:nerdtreeinit()
      nunmap <buffer> K
      nunmap <buffer> J
  endf

  map <silent> - :NERDTreeToggle<CR>
  let NERDTreeShowHidden=1
  let NERDTreeHijackNetrw=0
  let g:WebDevIconsUnicodeDecorateFolderNodes = 1
  let g:NERDTreeWinSize=45
  let g:NERDTreeAutoDeleteBuffer=1
  let g:WebDevIconsOS = 'Darwin'
  let NERDTreeMinimalUI=1
  let NERDTreeCascadeSingleChildDir=0
"}}}

" Nvim terminal -------------------------------------------------------------{{{
  au BufEnter * if &buftype == 'terminal' | :startinsert | endif
  autocmd BufEnter term://* startinsert
  autocmd TermOpen * set bufhidden=hide
" }}}

" Code formatting -----------------------------------------------------------{{{
" ,f to format code, requires formatters: read the docs
  " noremap <leader>f :Autoformat<CR>
  noremap <leader>f :Neoformat<CR>

  " Enable alignment
  " let g:neoformat_basic_format_align = 1
  " let g:neoformat_read_from_buffer = 0
  " let g:neoformat_basic_format_retab = 1
  " let g:neoformat_basic_format_trim = 1
  "
  " let g:neoformat_enabled_html = ['html-beautify']
  " let g:neoformat_enabled_javascript = ['js-beautify']
  " let g:neoformat_enabled_json = ['js-beautify']
" }}}

" Snipppets -----------------------------------------------------------------{{{

" Enable snipMate compatibility feature.
  let g:neosnippet#enable_snipmate_compatibility = 1
  let g:neosnippet#expand_word_boundary = 1
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.config/repos/github.com/Shougo/neosnippet-snippets/neosnippets, ~/Github/ionic-snippets, ~/.config/repos/github.com/matthewsimo/angular-vim-snippets/snippets'

" SuperTab like snippets behavior.
  " imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  " \ "\<Plug>(neosnippet_expand_or_jump)"
  " \: pumvisible() ? "\<C-n>" : "\<TAB>"
  " smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  " \ "\<Plug>(neosnippet_expand_or_jump)"
  " \: "\<TAB>"

"}}}

" Deoplete ------------------------------------------------------------------{{{
  " enable deoplete
  let g:deoplete#enable_at_startup = 1
  let g:echodoc_enable_at_startup=1
  set splitbelow
  set completeopt+=noselect
  autocmd CompleteDone * pclose
  function! Multiple_cursors_before()
    let b:deoplete_disable_auto_complete=2
  endfunction
  function! Multiple_cursors_after()
    let b:deoplete_disable_auto_complete=0
  endfunction

  call deoplete#custom#set('buffer', 'mark', 'buffer')
  call deoplete#custom#set('ternjs', 'mark', '')
  call deoplete#custom#set('typescript', 'mark', '')
  call deoplete#custom#set('omni', 'mark', 'omni')
  call deoplete#custom#set('file', 'mark', 'file')
  " let g:deoplete#omni_patterns = {}
  " let g:deoplete#omni_patterns.html = ''
  "
  " autocmd FileType css,sass,scss setlocal omnifunc=
  " let g:deoplete#omni_patterns.html = ''
  function! Preview_func()
    if &pvw
      setlocal nonumber norelativenumber
     endif
  endfunction
  autocmd WinEnter * call Preview_func()
  call deoplete#custom#set('_', 'matchers', ['matcher_fuzzy'])
  " let g:deoplete#enable_debug = 1
  " call deoplete#enable_logging('DEBUG', 'deoplete.log')
  " call deoplete#custom#set('typescript', 'debug_enabled', 1)
"}}}

" Emmet customization -------------------------------------------------------{{{
" Enable Emmet in all modes
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

  autocmd FileType html,css,scss imap <silent><buffer><expr><tab> <sid>expand_html_tab()
  let g:user_emmet_mode='a'
  let g:user_emmet_complete_tag = 0
  let g:user_emmet_install_global = 0
  autocmd FileType html,css,scss EmmetInstall
"}}}

" Denite --------------------------------------------------------------------{{{
"
  set showtabline=0

  autocmd FileType unite call s:uniteinit()
  augroup END
  function! s:uniteinit()
      set nonumber
      set norelativenumber
      nunmap <buffer> d
      nunmap <buffer> a
      nunmap <buffer> <c-n>
      nunmap <buffer> <c-k>
      nunmap <buffer> <c-p>

      nmap <silent> <Esc> <Plug>(unite_all_exit)
      nmap <silent> <c-n> <Plug>(unite_loop_cursor_down)
      nmap <silent> <c-p> <Plug>(unite_loop_cursor_up)

    endfunction
	call unite#custom#profile('default', 'context', {
	\   'winheight': 40,
	\   'direction': 'botright',
  \   'no-resize': 1
	\ })

  call denite#custom#option('default', 'prompt', '❯')
  "  \     'rg', '--glob', '!.git', ''

  call denite#custom#source(
	\ 'file_rec', 'vars', {
	\   'command': [
  \      'ag', '--follow','--nogroup','--hidden', '-g', '', '--ignore', '.git', '--ignore', '*.png'
	\   ] })
  let s:menus = {}
	call denite#custom#var('grep', 'command', ['rg'])
	call denite#custom#var('grep', 'default_opts',
			\ ['--vimgrep', '--no-heading'])
	call denite#custom#var('grep', 'recursive_opts', [])
	call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
	call denite#custom#var('grep', 'separator', ['--'])
	call denite#custom#var('grep', 'final_opts', [])
  " call denite#custom#source('file_rec', 'sorters', ['sorter_sublime'])
  " call denite#custom#option('default', 'statusline', 0)
  call denite#custom#option('default', 'highlight-matched-char', '')
  call denite#custom#option('default', 'highlight-matched-range', '')
  hi deniteMatched guibg=None
  hi deniteMatchedChar guibg=None

  nnoremap <silent> <c-p> :Denite file_rec<CR>
  nnoremap <silent> <leader>h :Denite  help<CR>
  nnoremap <silent> <leader>c :Denite colorscheme<CR>
  nnoremap <silent> <leader>u :call dein#update()<CR>
  nnoremap <silent> <leader>b :Denite buffer<CR>
  call denite#custom#map(
      \ 'insert',
      \ '<C-n>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
	call denite#custom#map(
	      \ 'insert',
	      \ '<C-p>',
	      \ '<denite:move_to_previous_line>',
	      \ 'noremap'
	      \)

  call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
    \ [ '.git/', '.ropeproject/', '__pycache__/',
    \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

  call denite#custom#var('menu', 'menus', s:menus)
  nnoremap <silent> <Leader>i :Denite -auto-resize menu:ionic <CR>

"}}}

" Git from denite...ERMERGERD -----------------------------------------------{{{
  let s:menus.git = {
    \ 'description' : 'Fugitive interface',
    \}
  let s:menus.git.command_candidates = [
    \[' git status', 'Gstatus'],
    \[' git diff', 'Gvdiff'],
    \[' git commit', 'Gcommit'],
    \[' git stage/add', 'Gwrite'],
    \[' git checkout', 'Gread'],
    \[' git rm', 'Gremove'],
    \[' git cd', 'Gcd'],
    \[' git push', 'exe "Git! push " input("remote/branch: ")'],
    \[' git pull', 'exe "Git! pull " input("remote/branch: ")'],
    \[' git pull rebase', 'exe "Git! pull --rebase " input("branch: ")'],
    \[' git checkout branch', 'exe "Git! checkout " input("branch: ")'],
    \[' git fetch', 'Gfetch'],
    \[' git merge', 'Gmerge'],
    \[' git browse', 'Gbrowse'],
    \[' git head', 'Gedit HEAD^'],
    \[' git parent', 'edit %:h'],
    \[' git log commit buffers', 'Glog --'],
    \[' git log current file', 'Glog -- %'],
    \[' git log last n commits', 'exe "Glog -" input("num: ")'],
    \[' git log first n commits', 'exe "Glog --reverse -" input("num: ")'],
    \[' git log until date', 'exe "Glog --until=" input("day: ")'],
    \[' git log grep commits',  'exe "Glog --grep= " input("string: ")'],
    \[' git log pickaxe',  'exe "Glog -S" input("string: ")'],
    \[' git index', 'exe "Gedit " input("branchname\:filename: ")'],
    \[' git mv', 'exe "Gmove " input("destination: ")'],
    \[' git grep',  'exe "Ggrep " input("string: ")'],
    \[' git prompt', 'exe "Git! " input("command: ")'],
    \] " Append ' --' after log to get commit info commit buffers
"}}}

" Ionic denite source -------------------------------------------------------{{{

    function! s:JobHandler(job_id, data, event) dict
      if a:event == 'stdout'
        let str = self.shell.' stdout: '.join(a:data)
      elseif a:event == 'stderr'
        let str = self.shell.' stderr: '.join(a:data)
      else
        let str = self.shell.' exited'
      endif

      call append(line('$'), str)
    endfunction
    let s:callbacks = {
    \ 'on_stdout': function('s:JobHandler'),
    \ 'on_stderr': function('s:JobHandler'),
    \ 'on_exit': function('s:JobHandler')
    \ }

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
      call termopen('ionic '. a:job . ' ' . platform)
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
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_skip_empty_sections = 1
  set hidden
  let g:airline#extensions#tabline#fnamemod = ':t'
  " let g:airline#extensions#tabline#buffer_nr_show = 1
  " let g:airline#extensions#tabline#buffer_nr_format = '%s '
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#neomake#error_symbol='✖ '
  let g:airline#extensions#neomake#warning_symbol='⚠️  '
  " let g:airline_theme='oceanicnextlight'
  let g:airline_theme='oceanicnext'
  cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == 'x' ? 'Sayonara' : 'x'
  tmap <leader>x <c-\><c-n>:bp! <BAR> bd! #<CR>
  nmap <leader>t :term<cr>
  nmap <leader>, :bnext<CR>
  tmap <leader>, <C-\><C-n>:bnext<cr>
  nmap <leader>. :bprevious<CR>
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

   " let g:airline_section_z = airline#section#create(['circleci'])

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
        \ '10': '10 '
        \}

"}}}

" Linting -------------------------------------------------------------------{{{

  let g:neomake_warning_sign = {'text': '•', 'texthl': 'NeomakeWarningSign'}
  let g:neomake_error_sign = {'text': '•', 'texthl': 'NeomakeErrorSign'}

  let g:ale_sign_error = '•'
  let g:ale_sign_warning = '•'

  hi ALEErrorSign guifg=#ec5f67 ctermfg=203 guibg=#343d46 ctermbg=237
  hi ALEWarningSign guifg=#fac863 ctermfg=221 guibg=#343d46 ctermbg=237


  let g:neomake_typescript_tsc_maker = {
            \ 'args': ['--project', getcwd() . '/tsconfig.json', '--noEmit'],
            \ 'append_file': 0,
            \ 'errorformat':
            \   '%E%f %#(%l\,%c): error %m,' .
            \   '%E%f %#(%l\,%c): %m,' .
            \   '%Eerror %m,' .
            \   '%C%\s%\+%m'
          \ }

      " let g:neomake_typescript_tslint_maker = {
      "     \ 'args': [ '%:p', '--format verbose', '--stdin', '--stdin-filename'],
      "     \ 'errorformat': '%f[%l\, %c]: %m'
      "     \ }
      "
  " let g:neomake_open_list = 2
  " let g:neomake_verbose = 3
  let g:neomake_markdown_alex_maker = {
                \ 'errorformat': '%P%f,' .
                \ '%-Q,' .
                \ '%*[ ]%l:%c-%*\d:%n%*[ ]%tarning%*[ ]%m,' .
                \ '%-G%.%#'
                \}
  let g:neomake_ft_maker_remove_invalid_entries = 0
  let g:neomake_markdown_enabled_makers = ['alex']
  let g:neomake_html_enabled_makers = []
  let g:neomake_javascript_enabled_makers = ['eslint']
  " autocmd! BufWritePost * Neomake
  autocmd! BufEnter,BufRead,BufWritePost * Neomake
  " autocmd! TextChanged,TextChangedI * Neomake
  function! TsLintFix()
      let l:winview = winsaveview()
      let l:config = getcwd() . '/tslint.json'
      let l:command = 'tslint --config '. l:config . '--x'
      %
      call winrestview(l:winview)
  endfunction
  command TsLintFix :call TsLintFix()
"}}}

let g:tagbar_type_typescript = {
  \ 'ctagstype': 'typescript',
  \ 'kinds': [
  \ 'c:classes',
  \ 'n:modules',
  \ 'f:functions',
  \ 'v:variables',
  \ 'v:varlambdas',
  \ 'm:members',
  \ 'i:interfaces',
  \ 'e:enums',
  \ ]
  \ }
