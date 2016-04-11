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
  if (!isdirectory(expand("$HOME/.config/nvim/repos/github.com/Shougo/dein.vim")))
    call system(expand("mkdir -p $HOME/.config/nvim/repos/github.com"))
    call system(expand("git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/repos/github.com/Shougo/dein.vim"))
  endif

  set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim/
  call dein#begin(expand('~/.config/nvim'))

  call dein#add('Shougo/dein.vim')
" syntax
  call dein#add('sheerun/vim-polyglot')
  " call dein#add('othree/yajs.vim', {'on_ft': 'javascript'})
  " call dein#add('othree/jsdoc-syntax.vim', {'on_ft':['javascript', 'typescript']})
  " call dein#add('othree/es.next.syntax.vim', {'on_ft': 'javascript'})
  " call dein#add('othree/javascript-libraries-syntax.vim')
  " call dein#add('kchmck/vim-coffee-script', {'on_ft': 'coffee'})
  " call dein#add('hail2u/vim-css3-syntax', {'on_ft':['css','scss']})
  call dein#add('elzr/vim-json', {'on_ft': 'json'})
  " call dein#add('tpope/vim-markdown', {'on_ft': 'markdown'})
  call dein#add('dhruvasagar/vim-table-mode')
  call dein#add('suan/vim-instant-markdown', {'on_ft': 'markdown'})
  call dein#add('tmhedberg/SimpylFold', {'on_ft': 'python'})
  " call dein#add('HerringtonDarkholme/yats.vim', {'on_ft': 'typescript'})
  call dein#add('Quramy/tsuquyomi')

  call dein#add('mhartington/oceanic-next')
  call dein#add('Yggdroot/indentLine')
  call dein#add('Raimondi/delimitMate', {'on_ft': ['javascript', 'typescript', 'css', 'scss']})
  call dein#add('valloric/MatchTagAlways', {'on_ft': 'html'})

  call dein#add('tpope/vim-fugitive')
  call dein#add('jreybert/vimagit')
  call dein#add('mhinz/vim-signify')
  call dein#add('Xuyuanp/nerdtree-git-plugin')
  call dein#add('https://github.com/jaxbot/github-issues.vim')

  call dein#add('tpope/vim-repeat')
  call dein#add('benekastah/neomake')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('AndrewRadev/switch.vim')
  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('tmux-plugins/vim-tmux-focus-events')
  call dein#add('vim-airline/vim-airline')
  call dein#add('tpope/vim-surround')
  call dein#add('tomtom/tcomment_vim')
  call dein#add('mattn/emmet-vim', {'on_ft': 'html'})
  call dein#add('Chiel92/vim-autoformat')
  call dein#add('ap/vim-css-color')
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/unite-outline')
  call dein#add('ujihisa/unite-colorscheme')
  call dein#add('junkblocker/unite-codesearch')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('carlitux/deoplete-ternjs')
  " call dein#add('mhartington/deoplete-typescript')
  call dein#add('Shougo/neco-vim', {'on_ft': 'vim'})
  call dein#add('Shougo/neoinclude.vim')
  call dein#add('ujihisa/neco-look', {'on_ft': ['markdown','text','html']})
  call dein#add('zchee/deoplete-jedi')
  call dein#add('Konfekt/FastFold')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('honza/vim-snippets')
  call dein#add('matthewsimo/angular-vim-snippets')
  call dein#add('mhinz/vim-sayonara')
  call dein#add('mattn/webapi-vim')
  call dein#add('mattn/gist-vim')
  call dein#add('terryma/vim-multiple-cursors')
  call dein#add('rhysd/github-complete.vim')
  call dein#add('junegunn/goyo.vim')
  call dein#add('vim-scripts/SyntaxRange')
  call dein#add('itchyny/vim-cursorword')
  " call dein#add('zchee/deoplete-go', {'build': 'make'})
  call dein#add('rhysd/nyaovim-popup-tooltip')
  call dein#add('troydm/asyncfinder.vim')
  call dein#add('nelstrom/vim-markdown-folding')
  call dein#add('tyru/markdown-codehl-onthefly.vim')
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
" Neovim Settings
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  let $NEOVIM_JS_DEBUG='nvimjs.log'
  set clipboard+=unnamedplus
" Currently needed for neovim paste issue
  set pastetoggle=<f6>
  set nopaste
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
  let g:used_javascript_libs = 'angularjs,angularuirouter'
  autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
  autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
  let g:indentLine_char='│'
  " enable deoplete
  let g:deoplete#enable_at_startup = 1
  let g:go_fmt_command = "goimports"
  let g:deoplete#sources#go = 'vim-go'
  let g:unite_source_codesearch_command = '$HOME/bin/csearch'
  let g:table_mode_corner="|"
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
  noremap <leader>TM :TableModeToggle<CR>
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
  vnoremap y "*y<CR>
  nnoremap Y "*Y<CR>
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

  function! s:PlaceholderImgTag(size)
    let url = 'http://dummyimage.com/' . a:size . '/000000/555555'
    let [width,height] = split(a:size, 'x')
    execute "normal a<img src=\"".url."\" width=\"".width."\" height=\"".height."\" />"
    endfunction
  command! -nargs=1 PlaceholderImgTag call s:PlaceholderImgTag(<f-args>)
  nmap <silent>gi <Plug>(nyaovim-popup-tooltip-open)
  vmap <silent>gi <Plug>(nyaovim-popup-tooltip-open)

  " If you prefer the Omni-Completion tip window to close when a selection is
  " made, these lines close it on movement in insert mode or when leaving
  " insert mode
  autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
  autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"}}}"

" Themes, Commands, etc  ----------------------------------------------------{{{
" Theme
  syntax on
  colorscheme OceanicNext
  set background=dark
  " set background=light
  " no need to fold things in markdown all the time
  let g:vim_markdown_folding_disabled = 1
  " turn on spelling for markdown files
  autocmd FileType markdown,text,html setlocal spell complete+=kspell
  " highlight bad words in red
  autocmd FileType markdown,text,html hi SpellBad guibg=#ff2929 guifg=#ffffff" ctermbg=224
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

"{{{
  let s:exclude_tags_list = [
        \ '\/',
        \ '!',
        \ 'html',
        \ 'area',
        \ 'base',
        \ 'br',
        \ 'col',
        \ 'embed',
        \ 'hr',
        \ 'img',
        \ 'input',
        \ 'keygen',
        \ 'link',
        \ 'menuitem',
        \ 'meta',
        \ 'param',
        \ 'source',
        \ 'track',
        \ 'wbr',
        \ 'ion-spinner',
        \ 'ion-tab',
        \ 'ion-icon',
        \ 'ion-item',
        \ 'ion-input',
        \ 'ion-content'
        \ ]
  let s:exclude_tags = join(s:exclude_tags_list, '\|')
"}}}

  function! HTMLFolds() "{{{
    let line = getline(v:lnum)

    " Ignore tags that open and close in the same line
    if line =~# '<\(\w\+\).*<\/\1>'
      return '='
    endif

    if line =~# '<\%(' . s:exclude_tags . '\)\@!'
      return 'a1'
    endif

    if line =~# '<\/\%(' . s:exclude_tags . '\)\@!'
      return 's1'
    endif

    return '='
  endfunction "}}}

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
  autocmd FileType html setl foldexpr=HTMLFolds()

  autocmd FileType javascript,typescript,json setl foldmethod=syntax
" }}}

" NERDTree ------------------------------------------------------------------{{{

  map <C-\> :NERDTreeToggle<CR>
  autocmd StdinReadPre * let s:std_in=1
  " autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  let NERDTreeShowHidden=1
  let g:NERDTreeWinSize=45
  let g:NERDTreeAutoDeleteBuffer=1
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
" let g:neosnippet#snippets_directory='~/.config/repos/github.com/Shougo/neosnippet-snippets/neosnippets, ~/Github/ionic-snippets, ~/.config/repos/github.com/matthewsimo/angular-vim-snippets/snippets'

" SuperTab like snippets behavior.
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \: pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \: "\<TAB>"

"}}}

" Typescript & Javscript omni complete --------------------------------------{{{

let g:tsuquyomi_disable_quickfix = 1
  " autocmd FileType typescript setlocal completeopt+=menu,preview
  " autocmd FileType typescript setlocal completeopt+=menu,preview
  " set completeopt+=menu,preview,noselect
  let g:vim_json_syntax_conceal = 0
  set splitbelow
  set completeopt+=noselect
  autocmd FileType vmailMessageList let b:deoplete_disable_auto_complete=1
  function! Multiple_cursors_before()
    let b:deoplete_disable_auto_complete=1
  endfunction
  function! Multiple_cursors_after()
    let b:deoplete_disable_auto_complete=0
  endfunction
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
    return "\<C-y>,"
  endif
" return a regular tab character
  return "\<tab>"
  endfunction
  autocmd FileType html,markdown imap <buffer><expr><tab> <sid>expand_html_tab()
  let g:user_emmet_mode='a'
  let g:user_emmet_complete_tag = 1
  let g:user_emmet_install_global = 0
  autocmd FileType html,css EmmetInstall
"}}}

" unite ---------------------------------------------------------------------{{{
"
  let g:unite_data_directory='~/.nvim/.cache/unite'
  let g:unite_source_history_yank_enable=1
  let g:unite_prompt='» '
  let g:unite_source_rec_async_command =['ag', '--follow', '--nocolor', '--nogroup','--hidden', '-g', '', '--ignore', '.git', '--ignore', '*.png', '--ignore', 'lib']

  nnoremap <silent> <c-p> :Unite -auto-resize -start-insert -direction=botright file_rec/neovim<CR>
  nnoremap <silent> <leader>c :Unite -auto-resize -start-insert -direction=botright colorscheme<CR>
  nnoremap <silent> <leader>u :call dein#update()<CR>
  nnoremap <silent> <leader>m :Unite -auto-resize -start-insert -direction=botright redismru<CR>

  " Custom mappings for the unite buffer
  autocmd FileType unite call s:unite_settings()

function! s:unite_settings() "{{{
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction "}}}

" Git from unite...ERMERGERD ------------------------------------------------{{{
let g:unite_source_menu_menus = {} " Useful when building interfaces at appropriate places
let g:unite_source_menu_menus.git = {
  \ 'description' : 'Fugitive interface',
  \}
let g:unite_source_menu_menus.git.command_candidates = [
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
nnoremap <silent> <Leader>g :Unite -direction=botright -silent -buffer-name=git -start-insert menu:git<CR>
"}}}
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
  " let g:airline_theme='base16_solarized'
  cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == 'x' ? 'Sayonara' : 'x'
  tmap <leader>x <c-\><c-n>:bp! <BAR> bd! #<CR>
  nmap <leader>t :term<cr>
  nmap <leader>, :bnext<CR>
  tmap <leader>, <C-\><C-n>:bnext<cr>
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
"}}}

" Linting -------------------------------------------------------------------{{{

  let g:neomake_javascript_enabled_makers = ['eslint']
  function! neomake#makers#ft#javascript#eslint()
      return {
          \ 'args': ['-f', 'compact'],
          \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
          \ '%W%f: line %l\, col %c\, Warning - %m'
          \ }
  endfunction
  function! neomake#makers#ft#typescript#tsc()
      return {
          \ 'args': [
              \ '-m', 'commonjs', '--noEmit','-t','ES5', '--emitDecoratorMetadata', '--experimentalDecorators'
          \ ],
          \ 'errorformat':
              \ '%E%f %#(%l\,%c): error %m,' .
              \ '%E%f %#(%l\,%c): %m,' .
              \ '%Eerror %m,' .
              \ '%C%\s%\+%m'
          \ }
  endfunction
  autocmd! BufWritePost * Neomake

  function! JscsFix()
      let l:winview = winsaveview()
      % ! jscs -x
      call winrestview(l:winview)
  endfunction
  command JscsFix :call JscsFix()
  noremap <leader>j :JscsFix<CR>
"}}}
