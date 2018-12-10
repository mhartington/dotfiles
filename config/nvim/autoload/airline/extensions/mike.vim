if !exists(':Neomake')
  finish
endif
let s:spc = g:airline_symbols.space

function! airline#extensions#mike#init(ext) abort
  call airline#parts#define_raw('job_status', '%{airline#extensions#mike#get_jobs()}')
  call a:ext.add_statusline_func('airline#extensions#mike#apply')
endfunction

function! airline#extensions#mike#apply(...) abort
    let w:airline_section_b = get(w:, 'airline_section_b', g:airline_section_b)
    let w:airline_section_b .= '%{airline#extensions#mike#get_jobs()}'
endfunction


function! airline#extensions#mike#get_jobs(...) abort
    if len(neomake#GetJobs())
        return 'Ⓛ'
    else
        return ''
    endif
endfunction

