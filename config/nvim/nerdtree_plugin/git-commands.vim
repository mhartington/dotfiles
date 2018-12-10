call NERDTreeAddMenuItem({'text': '(G)it reset', 'shortcut': 'G', 'callback': 'NERDTreeGitReset'})
call NERDTreeAddMenuItem({'text': '(C)lean untracked files', 'shortcut': 'C', 'callback': 'NERDTreeGitClean'})


function! NERDTreeGitReset() abort "{{{
    let l:currentNode = g:NERDTreeFileNode.GetSelected().path.str()
    let l:confirmed = 0
    let l:choice =input("Reset the current directory\n" .
                     \ "==========================================================\n" .
                     \ "STOP! This action cannot be undone, type 'yes' to continue\n" .
                     \ '' . l:currentNode . ' : ')
    let l:confirmed = l:choice ==# 'yes'
    if l:confirmed
      let l:stdout = system('git checkout ' . l:currentNode)
      " if join(l:stdout, ', ') =~? 'error: pathspec'
      "   call nerdtree#echoWarning('Could not reset, untracked files')
      " endif
    else
      call nerdtree#echo('reset aborted')
    endif
  endfunction "}}}

function! NERDTreeGitClean() abort "{{{
  let l:currentNode = g:NERDTreeFileNode.GetSelected().path.str() . '/*'
  let l:cmd = 'git clean -fd -- ' . l:currentNode
  let l:confirmed = 0
  let l:choice =input("Reset the current directory\n" .
                   \ "==========================================================\n" .
                   \ "STOP! This action cannot be undone, type 'yes' to continue\n" .
                   \ '' . l:currentNode . ' : ')
  let l:confirmed = l:choice ==# 'yes'
  if l:confirmed
    let l:stdout = system(l:cmd)
  else
    call nerdtree#echo('reset aborted')
  endif
endfunction "}}}


