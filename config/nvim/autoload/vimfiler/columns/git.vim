let s:GitStatusCacheTimeExpiry = 2
let s:GitStatusCacheTime = 0

function! vimfiler#columns#git#define() abort "{{{
  return s:column
endfunction "}}}
let s:column = {
      \ 'name' : 'git',
      \ 'description' : 'git file status',
      \ 'syntax' : 'vimfilerColumnGit',
      \ }

function! s:column.get(file, context) abort "{{{
  return s:GetGitStatusPrefix(a:file)
endfunction "}}}
function! s:column.length(files, context) abort "{{{
  return 2
endfunction "}}}
if !exists('g:VimFilerGitIndicatorMap') "{{{
  let g:VimFilerGitIndicatorMap = {
        \ "Modified"  : "✹",
        \ "Staged"    : "✚",
        \ "Untracked" : "✭",
        \ "Renamed"   : "➜",
        \ "Unmerged"  : "═",
        \ "Deleted"   : "✖",
        \ "Dirty"     : "✗",
        \ "Unknown"   : "?"
        \ }
endif "}}}
function! s:column.define_syntax(context) abort "{{{
  syntax match   vimfilerColumnGitModified     '✹'
        \ contained containedin=vimfilerColumnGit
  syntax match   vimfilerColumnGitStaged       '✚'
        \ contained containedin=vimfilerColumnGit
  syntax match   vimfilerColumnGitUnstaged     '✭'
        \ contained containedin=vimfilerColumnGit
  syntax match   vimfilerColumnGitRenamed      '➜'
        \ contained containedin=vimfilerColumnGit
  syntax match   vimfilerColumnGitUnmerged     '═'
        \ contained containedin=vimfilerColumnGit
  syntax match   vimfilerColumnGitDeleted      '✖'
        \ contained containedin=vimfilerColumnGit
  syntax match   vimfilerColumnGitDirty        '✗'
        \ contained containedin=vimfilerColumnGit
  syntax match   vimfilerColumnGitUnknown      '?'
        \ contained containedin=vimfilerColumnGit

  highlight def link  vimfilerColumnGitModified Special
  highlight def link  vimfilerColumnGitStaged   Function
  highlight def link  vimfilerColumnGitUnstaged Text
  highlight def link  vimfilerColumnGitRenamed  Title
  highlight def link  vimfilerColumnGitUnmerged Label
  highlight def link  vimfilerColumnGitDeleted  Text
  highlight def link  vimfilerColumnGitDirty    Text
  highlight def link  vimfilerColumnGitUnknown  Text
endfunction "}}}
function! s:GitStatusRefresh() abort "{{{
  let b:CachedGitFileStatus  = {}
  let b:CachedGitDirtyDir    = {}
  let b:NOT_A_GIT_REPOSITORY = 1
  let l:gitcmd = 'git -c color.status=false status -s'
  let l:statusesStr = system('cd "' . getcwd() . '" && ' . l:gitcmd)
  let l:statusesSplit = split(l:statusesStr, '\n')
  if l:statusesSplit != [] && l:statusesSplit[0] =~# 'fatal:.*'
    let l:statusesSplit = []
    return
  endif
  for l:statusLine in l:statusesSplit "{{{
    " cache git status of files
    let l:pathStr = substitute(l:statusLine, '...', '', '')
    let l:pathSplit = split(l:pathStr, ' -> ')
    if len(l:pathSplit) == 2
      call s:CacheDirtyDir(l:pathSplit[0])
      let l:pathStr = l:pathSplit[1]
    else
      let l:pathStr = l:pathSplit[0]
    endif
    let l:pathStr = s:TrimDoubleQuotes(l:pathStr)
    if l:pathStr =~# '\.\./.*'
      continue
    endif
    let l:statusKey = s:GetFileGitStatusKey(l:statusLine[0], l:statusLine[1])
    let b:CachedGitFileStatus[fnameescape(l:pathStr)] = l:statusKey
    call s:CacheDirtyDir(l:pathStr)
  endfor "}}}
endfunction
"}}}
function! s:CacheDirtyDir(pathStr) abort "{{{
  let l:dirtyPath = s:TrimDoubleQuotes(a:pathStr)
  if l:dirtyPath =~# '\.\./.*'
    return
  endif
  let l:dirtyPath = substitute(l:dirtyPath, '/[^/]*$', '/', '')
  while l:dirtyPath =~# '.\+/.*' && has_key(b:CachedGitDirtyDir, fnameescape(l:dirtyPath)) == 0
    let b:CachedGitDirtyDir[fnameescape(l:dirtyPath)] = 'Dirty'
    let l:dirtyPath = substitute(l:dirtyPath, '/[^/]*/$', '/', '')
  endwhile
endfunction "}}}
function! s:TrimDoubleQuotes(pathStr) abort "{{{
  let l:toReturn = substitute(a:pathStr, '^"', '', '')
  let l:toReturn = substitute(l:toReturn, '"$', '', '')
  return l:toReturn
endfunction "}}}
function! s:GetFileGitStatusKey(us, them) abort "{{{
  if a:us ==# '?' && a:them ==# '?'
    return 'Untracked'
  elseif a:us ==# ' ' && a:them ==# 'M'
    return 'Modified'
  elseif a:us =~# '[MAC]'
    return 'Staged'
  elseif a:us ==# 'R'
    return 'Renamed'
  elseif a:us ==# 'U' || a:them ==# 'U' || a:us ==# 'A' && a:them ==# 'A' || a:us ==# 'D' && a:them ==# 'D'
    return 'Unmerged'
  elseif a:them ==# 'D'
    return 'Deleted'
  else
    return 'Unknown'
  endif
endfunction "}}}
function! s:GetGitStatusPrefix(path) abort "{{{
  if localtime() - s:GitStatusCacheTime > s:GitStatusCacheTimeExpiry
    let s:GitStatusCacheTime = localtime()
    call s:GitStatusRefresh()
  endif
  let l:pathStr = a:path.action__path
  let l:cwd = getcwd() . '/'
  let l:pathStr = substitute(l:pathStr, fnameescape(l:cwd), '', '')
  let l:statusKey = ''
  if a:path.vimfiler__is_directory
    let l:statusKey = get(b:CachedGitDirtyDir, fnameescape(l:pathStr . '/'), '')
  else
    let l:statusKey = get(b:CachedGitFileStatus, fnameescape(l:pathStr), '')
  endif
  return s:GetIndicator(l:statusKey)
endfunction "}}}
function! s:GetIndicator(statusKey) abort "{{{
  let l:indicator = get(g:VimFilerGitIndicatorMap, a:statusKey, '')
  if l:indicator !=# ''
    return l:indicator
  endif
  return ''
endfunction "}}}
" vim: foldmethod=marker
