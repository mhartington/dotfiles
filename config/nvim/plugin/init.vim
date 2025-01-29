" Remapping <C-y>, just doesn't cut it.
"
let loaded_netrwPlugin = 1
if &term =~ 'xterm\|kitty\|alacritty\|tmux\|ghostty'
    let &t_Ts = "\e[9m"   " Strikethrough
    let &t_Te = "\e[29m"
    let &t_Cs = "\e[4:3m" " Undercurl
    let &t_Ce = "\e[4:0m"
endif
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
endif

" return a regular tab character
return "\<tab>"

endfunction


" autocmd FileType angular.html,html,css,scss,typescriptreact,vue,javascript,markdown imap <silent><buffer><expr><tab> <sid>expand_html_tab()
" let g:user_emmet_mode='a'
" let g:user_emmet_complete_tag = 0
" let g:user_emmet_install_global = 0
" autocmd FileType angular.html,html,css,scss,typescriptreact,vue,javascript,markdown EmmetInstall
"
