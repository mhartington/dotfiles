"|  \/  (_) |                        (_)
"| .  . |_| | _____  ___   _ ____   ___ _ __ ___  _ __ ___
"| |\/| | | |/ / _ \/ __| | '_ \ \ / / | '_ ` _ \| '__/ __|
"| |  | | |   <  __/\__ \ | | | \ V /| | | | | | | | | (__
"\_|  |_/_|_|\_\___||___/ |_| |_|\_/ |_|_| |_| |_|_|  \___|
"
"  Author: Mike Hartington
"  repo  : https://github.com/mhartington/dotfiles/
"

" System mappings  ----------------------------------------------------------{{{
  nnoremap <leader>e :call <SID>SynStack()<CR>
  function! <SID>SynStack()
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



" Fold, gets it's own section  ----------------------------------------------{{{


" }}}



" Nvim terminal -------------------------------------------------------------{{{
" }}}



" Completion ----------------------------------------------------------------{{{
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


" vim-airline ---------------------------------------------------------------{{{

  let g:webdevicons_enable_airline_statusline = 1
  if !exists('g:airline_symbols')
    le g:airline_symbols = {
      \ 'branch': '',
      \ 'modified': ' ●'
      \}
  endif

"}}}



