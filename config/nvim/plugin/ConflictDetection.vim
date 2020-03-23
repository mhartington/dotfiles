if exists('g:loaded_ConflictDetection') "{{{
    finish
endif "}}}
let g:loaded_ConflictDetection = 1

"- configuration ---------------------------------------------------------------
if ! exists('g:ConflictDetection_AutoDetectEvents') "{{{
    let g:ConflictDetection_AutoDetectEvents = 'BufReadPost,BufWritePre'
endif "}}}
"- utils -----------------------------------------------------------------------
function! s:getSearchArguments(timeout) "{{{
    return [(a:timeout == 0 ? 0 : line('.') + a:timeout * 10)]
endfunction "}}}
function! s:search( pattern, flags, ... ) "{{{
    let l:timeout = (a:0 ? a:1 : 100)
    return call('search', [a:pattern, a:flags] + s:getSearchArguments(l:timeout))
endfunction "}}}
function! s:isBufferContains( pattern, ... ) "{{{
    return call('s:search', [a:pattern, 'cnw'] + a:000)
endfunction "}}}
"- functions -------------------------------------------------------------------
function! s:ConflictCheck() "{{{
  " let doc = nvim_buf_get_lines(0, 0, -1, v:true)



  let l:conflictLnum = s:isBufferContains('^\([<=>|]\)\{7}\1\@!')
  if l:conflictLnum == 0
    let b:conflicted = v:false
    return
  endif
  " To avoid false positives (e.g. in nested email replies), ensure that both
  " "our" and "theirs" markers do exist.
  let l:conflictType = strpart(getline(l:conflictLnum), 0, 1) " Dealing with pure ASCII characters.
  if l:conflictType ==# '<'
    let b:conflicted = !! s:isBufferContains('^\(>\)\{7}\1\@!', 0)
  elseif l:conflictType ==# '>'
    let b:conflicted = !! s:isBufferContains('^\(<\)\{7}\1\@!', 0)
  else
    let b:conflicted = (
    \   s:isBufferContains('^\(<\)\{7}\1\@!', 0) &&
    \   s:isBufferContains('^\(>\)\{7}\1\@!', 0)
    \)
  endif
endfunction "}}}
function! s:ConflictHighlight() "{{{
  if !exists('b:conflicted')
    call s:ConflictCheck()
  endif
  if b:conflicted
    call s:Highlight()
  endif
endfunction "}}}
function! s:Highlight() "{{{
    syntax region conflictOurs   matchgroup=conflictOursMarker start="^<\{7}<\@!.*$"   end="^\([=|]\)\{7}\1\@!"me=s-1 keepend containedin=TOP
    syntax region conflictBase   matchgroup=conflictBaseMarker start="^|\{7}|\@!.*$"   end="^=\{7}=\@!"me=s-1         keepend containedin=TOP
    syntax region conflictTheirs start="^=\{7}=\@!.*$" matchgroup=conflictTheirsMarker end="^>\{7}>\@!.*$"            keepend containedin=TOP contains=conflictSeparatorMarkerSymbol
    syntax match conflictOursMarkerSymbol       "^<\{7}"        contained
    syntax match conflictBaseMarkerSymbol       "^|\{7}"        contained
    syntax match conflictSeparatorMarkerSymbol  "^=\{7}"        contained
    syntax match conflictTheirsMarkerSymbol     "^>\{7}"        contained
endfunction "}}}
"- autocmds --------------------------------------------------------------------
augroup ConflictDetection "{{{
  autocmd!
    if !empty(g:ConflictDetection_AutoDetectEvents)
      execute 'autocmd' g:ConflictDetection_AutoDetectEvents '* call <SID>ConflictCheck()'
    endif
  autocmd BufReadPost,FileType * call <SID>ConflictHighlight()
augroup END "}}}
"- highlight groups ------------------------------------------------------------
highlight conflictOurs guibg=#0F474B
highlight conflictTheirs guibg=#13405B
highlight conflictOursMarker guibg=#007771
highlight conflictTheirsMarker guibg=#0E6699

highlight def link conflictBase DiffChange
highlight def link conflictSeparatorMarkerSymbol NonText
