" if !exists(':Neomake')
"   finish
" endif
"
" let s:error_symbol = get(g:, 'airline#extensions#neomake#error_symbol', 'E:')
" let s:warning_symbol = get(g:, 'airline#extensions#neomake#warning_symbol', 'W:')
"
" function! s:get_counts()
"   return TSGetErrorCountForFile()
" endfunction
"
" " function! airline#extensions#neomake#get_warnings()
" "   let counts = s:get_counts()
" "   let warnings = get(counts, 'W', 0)
" "   return warnings ? s:warning_symbol.warnings : ''
" " endfunction
"
" function! airline#extensions#nvim_typescript#get_errors()
"   let counts = s:get_counts()
"   let errors = get(counts, 'E', 0)
"   return errors ? s:error_symbol.errors : ''
" endfunction
"
" function! airline#extensions#nvim_typescript#init(ext)
"   call airline#parts#define_function('nvim_typescript_error_count', 'airline#extensions#nvim_typescript#get_errors')
"   call a:ext.add_statusline_func('airline#extensions#nvim_typescript#apply')
" endfunction
"
"
" function! airline#extensions#nvim_typescript#apply(...) abort
"     let g:airline_section_error = get(w:, 'airline_section_error', g:airline_section_error)
"     let g:airline_section_error .= '%{airline#extensions#nvim_typescript#get_errors()}'
" endfunction
"
"
" " if !exists('g:airline_section_error')
" "     let g:airline_section_error = airline#section#create(['ycm_error_count', 'syntastic-err', 'eclim', 'neomake_error_count', 'ale_error_count'])
" "   endif
