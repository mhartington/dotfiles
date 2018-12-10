let s:maker = {}
function! s:maker.get_list_entries(jobinfo) abort
  call TSGetErrFunc(a:jobinfo)
  return self
endfunction


function! neomake#makers#ft#typescript#nvim_ts() abort
  return s:maker
endfunction
