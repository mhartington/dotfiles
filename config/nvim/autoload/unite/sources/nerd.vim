
function! CreateNode(node, kind) abort "{{{
  let l:path = ''
  if a:kind ==# 'file'
    let l:path = getcwd()
  else
    let l:path = a:node
  endif
  let l:newNodeName = input("Add a childnode\n".
        \ "==========================================================\n".
        \ "Enter the dir/file name to be created. Dirs end with a '/'\n" .
        \ '', l:path . '/', 'file')
  if l:newNodeName ==# ''
    echo 'Node Creation Aborted.'
    return
  endif
  if isdirectory(l:newNodeName) || filereadable(l:newNodeName)
    throw "CreatePathError: Directory Exists: '" . l:newNodeName . "'"
  endif
  if l:newNodeName =~# '\(\\\|\/\)$'
    let l:fullpath = substitute(l:newNodeName, '\(\\\|\/\)$', '', '')
    call mkdir(l:fullpath, 'p')
  else
    call s:createParentDirectories(l:newNodeName)
    call writefile([], l:newNodeName)
  endif
  call vimfiler#force_redraw_screen(1)
endfunction "}}}

function! MoveNode(node, kind) abort "{{{
  " Get the current path setup
  let l:path = a:node
  let l:newNodePath = input("Move File\n".
        \ "==========================================================\n".
        \ "Enter the new location for the file\n" .
        \ '', l:path, 'file')
  if l:newNodePath ==# ''
    echo 'Node Move Aborted.'
    return
  endif
  if isdirectory(l:newNodePath) || filereadable(l:newNodePath)
    throw "CreatePathError: Directory Exists: '" . l:newNodePath . "'"
  endif
  call rename(l:path, l:newNodePath)
  echo l:newNodePath
  call vimfiler#force_redraw_screen(1)
endfunction "}}}

function! CopyNode(node, kind) abort "{{{
  " Get the current path setup
  let l:path = a:node
  let l:newNodeName = input("Copy the current node\n" .
                          \ "==========================================================\n" .
                          \ "Enter the new path to copy the node to:                   \n" .
                          \ "", l:path, "file")
  " If there's a new path
  if l:newNodeName !=''
    let confirmed = 1
    " if the new path already exist, prompt for confirmation
    if isdirectory(l:newNodeName) || filereadable(l:newNodeName)
      echo "\nWarning: copying may overwrite files! Continue? (yN): "
      let choice = nr2char(getchar())
      let l:confirmed = choice ==# 'y'
    endif
    if confirmed
        try
          " cp -r
            call s:createParentDirectories(l:newNodeName)
            let cmd = "cp -r " . l:path . " " . l:newNodeName
            let success = system(cmd)
            if v:shell_error != 0
                throw "CopyError: Could not copy ''". l:path ."'' to: '" . l:newNodeName . "'"
            endif
        catch /^CopyError/
            echoerr("Could not copy node")
        endtry
    endif
  else
    echom "Copy aborted"
  endif
  call vimfiler#force_redraw_screen(1)

endfunction "}}}

function! DeleteNode(node, kind) abort "{{{
  let l:currentNode = a:node
  let l:confirmed = 0
  if a:kind ==# 'directory' && s:getChildCount(a:node) > 0
    let choice =input("Delete the current node\n" .
          \ "==========================================================\n" .
          \ "STOP! Directory is not empty! To delete, type 'yes'\n" .
          \ '' . a:node . ': ')
    let l:confirmed = choice ==# 'yes'
  else
    echo "Delete the current node\n" .
          \ "==========================================================\n".
          \ "Are you sure you wish to delete the node:\n" .
          \ '' . l:currentNode . ' (y/n):'
    let l:choice = nr2char(getchar())
    let l:confirmed = l:choice ==# 'y'
  endif
  "
  "
  if l:confirmed
    try
      call system('rm -rf ' . l:currentNode)
      call vimfiler#force_redraw_screen(1)
      "if the node is open in a buffer, ask the user if they want to
      "close that buffer
      let l:bufnum = bufnr('^'.a:node.'$')
      if buflisted(l:bufnum)
        let l:prompt = "\nNode deleted.\n\nThe file is open in buffer ". l:bufnum . (bufwinnr(l:bufnum) ==# -1 ? ' (hidden)' : '') .'. Delete this buffer? (yN)'
        call s:promptToDelBuffer(l:bufnum, l:prompt)
      endif
      redraw
    catch /^NERDTree/
      echoerr 'Could not remove node'
    endtry
  else
    echo 'delete aborted'
  endif

endfunction "}}}


" Util
function! s:createParentDirectories(path) abort "{{{
  let dir_path = fnamemodify(a:path, ':h')
  if !isdirectory(dir_path)
    call mkdir(dir_path, 'p')
  endif
endfunction "}}}

function! s:getChildCount(path) abort "{{{
  return system('ls -l '. a:path . ' | grep -c ^d')
endfunction "}}}

function! s:promptToDelBuffer(bufnum, msg) abort "{{{
  echo a:msg
  if nr2char(getchar()) ==# 'y'
    " 1. ensure that all windows which display the just deleted filename
    " now display an empty buffer (so a layout is preserved).
    " Is not it better to close single tabs with this file only ?
    let s:originalTabNumber = tabpagenr()
    let s:originalWindowNumber = winnr()
    exec 'tabdo windo if winbufnr(0) == ' . a:bufnum . " | exec ':enew! ' | endif"
    exec 'tabnext ' . s:originalTabNumber
    exec s:originalWindowNumber . 'wincmd w'
    " 3. We don't need a previous buffer anymore
    exec 'bwipeout! ' . a:bufnum
  endif
endfunction "}}}

function! s:promptToRenameBuffer(bufnum, msg, newFileName) abort " {{{
  echo a:msg
  if nr2char(getchar()) ==# 'y'
    let l:quotedFileName = fnameescape(a:newFileName)
    " 1. ensure that a new buffer is loaded
    exec 'badd ' . l:quotedFileName
    " 2. ensure that all windows which display the just deleted filename
    " display a buffer for a new filename.
    let s:originalTabNumber = tabpagenr()
    let s:originalWindowNumber = winnr()
    let l:editStr = a:newFileName
    exec 'tabdo windo if winbufnr(0) == ' . a:bufnum . " | exec ':e! " . l:editStr . "' | endif"
    exec 'tabnext ' . s:originalTabNumber
    exec s:originalWindowNumber . 'wincmd w'
    " 3. We don't need a previous buffer anymore
    exec 'bwipeout! ' . a:bufnum
  endif
endfunction "}}}



" Unite source
let s:source = {
      \ 'name': 'nerd',
      \ 'description': 'nerdtree like menu for unite',
      \ }

function! s:source.gather_candidates(args, context) abort "{{{
  let l:node = a:context.file
  return [{
        \ 'word': ' add a childnode',
        \ 'source': s:source.name,
        \ 'kind': 'command',
        \ 'action__command': 'call CreateNode("'. l:node.action__path . '", "'. l:node.kind .'")'
        \ },
        \{
        \ 'word': ' move current node',
        \ 'source': s:source.name,
        \ 'kind': 'command',
        \ 'action__command': 'call MoveNode("'. l:node.action__path . '", "'. l:node.kind .'")'
        \},
        \{
        \ 'word': ' copy current node',
        \ 'source': s:source.name,
        \ 'kind': 'command',
        \ 'action__command': 'call CopyNode("'. l:node.action__path . '", "'. l:node.kind .'")'
        \},
        \{
        \ 'word': ' delete the current node',
        \ 'source': s:source.name,
        \ 'kind': 'command',
        \ 'action__command': 'call DeleteNode("'. l:node.action__path . '", "'. l:node.kind .'")'
        \ }]
endfunction "}}}

function! unite#sources#nerd#define() abort "{{{
  return s:source
endfunction "}}}

