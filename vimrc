"|  \/  (_) |             | | | (_)
"| .  . |_| | _____  ___  | | | |_ _ __ ___  _ __ ___
"| |\/| | | |/ / _ \/ __| | | | | | '_ ` _ \| '__/ __|
"| |  | | |   <  __/\__ \ \ \_/ / | | | | | | | | (__
"\_|  |_/_|_|\_\___||___/  \___/|_|_| |_| |_|_|  \___|
"
" Author: Mike Hartington
" repo  : https://github.com/mhartington/dotfiles/
"

" Setup NeoBundle  ----------------------------------------------------------{{{
" If vundle is not installed, do it first
  if (!isdirectory(expand('$HOME/.vim/repos/github.com/Shougo/dein.vim')))
    call system(expand('mkdir -p $HOME/.vim/repos/github.com'))
    call system(expand('git clone https://github.com/Shougo/dein.vim $HOME/.vim/repos/github.com/Shougo/dein.vim'))
  endif


  set nocompatible

" Required:
    set runtimepath+=~/.vim/repos/github.com/Shougo/dein.vim/
  call dein#begin(expand('~/.vim'))
" Let NeoBundle manage NeoBundle
" Required:
  call dein#add('Shougo/dein.vim')
  call dein#add('haya14busa/dein-command.vim')
  " syntax
  call dein#add('HerringtonDarkholme/yats.vim')
  call dein#add('posva/vim-vue')
  call dein#add('Quramy/tsuquyomi')
  call dein#add('Quramy/tsuquyomi-vue')
  call dein#add('mhartington/oceanic-next')
  if dein#check_install()
    call dein#install()
  endif
  call dein#end()

" Required:
  filetype plugin indent on
" }}}

" System Settings  ----------------------------------------------------------{{{
" Let airline tell me my status

let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"
  set termguicolors
  hi SpellBad  gui=undercurl guisp=red term=undercurl cterm=undercurl
  set noshowmode
  set noswapfile
  filetype on
  set number
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

  autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
  autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
  let g:indentLine_char='│'
  " enable deoplete

  let g:neocomplete#enable_at_startup = 1
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
  " map <esc> :noh<cr>
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

"}}}

" Themes, Commands, etc  ----------------------------------------------------{{{
" Theme
syntax enable
colorscheme OceanicNext
"}}}

" " Fold, gets it's own section  ----------------------------------------------{{{
"
" function! MyFoldText() " {{{
"     let line = getline(v:foldstart)
"
"     let nucolwidth = &fdc + &number * &numberwidth
"     let windowwidth = winwidth(0) - nucolwidth - 3
"     let foldedlinecount = v:foldend - v:foldstart
"
"     " expand tabs into spaces
"     let onetab = strpart('          ', 0, &tabstop)
"     let line = substitute(line, '\t', onetab, 'g')
"
"     let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
"     let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
"     return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
" endfunction " }}}
"
" function! JavaScriptFold() "{{{
"   " syntax region foldBraces start=/{/ end=/}/ transparent fold keepend extend
"   setlocal foldmethod=syntax
"   setlocal foldlevel=99
"   echo "hello"
"   syn region foldBraces start=/{/ skip=/\(\/\/.*\)\|\(\/.*\/\)/ end=/}/ transparent fold keepend extend
" endfunction "}}}
"
" " function! HTMLFold() "{{{
" "   " syn sync fromstart
" "   set foldmethod=syntax
" "   syn region HTMLFold start=+^<\([^/?!><]*[^/]>\)\&.*\(<\1\|[[:alnum:]]\)$+ end=+^</.*[^-?]>$+ fold transparent keepend extend
" "   syn match HTMLCData "<!\[CDATA\[\_.\{-}\]\]>" fold transparent extend
" "   syn match HTMLCommentFold "<!--\_.\{-}-->" fold transparent extend
" " endfunction "}}}
"
" set foldtext=MyFoldText()
"
" autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
" autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
"
" autocmd FileType vim setlocal fdc=1
" set foldlevel=99
" " Space to toggle folds.
" nnoremap <Space> za
" vnoremap <Space> za
" autocmd FileType vim setlocal foldmethod=marker
" autocmd FileType vim setlocal foldlevel=0
"
" " au FileType html call HTMLFold()
" " autocmd FileType html setlocal foldmethod=syntax
" autocmd FileType html setlocal fdl=99
"
" " autocmd FileType javascript call JavaScriptFold()
" autocmd FileType javascript,html,css,scss,typescript setlocal foldlevel=99
" autocmd FileType javascript,typescript,css,scss,json setlocal foldmethod=marker
" autocmd FileType javascript,typescript,css,scss,json setlocal foldmarker={,}
" autocmd FileType coffee setl foldmethod=indent
" " au FileType html nnoremap <buffer> <leader>F zfat
" " }}}

" let g:deoplete#enable_at_startup = 1
" autocmd FileType css setl omnifunc=csscomplete#CompleteCSS
