" File: jsdoc.vim
" Author: NAKAMURA, Hisashi <https://github.com/sunvisor>
" Modifyed: Shinya Ohyanagi <sohyanagi@gmail.com>
" Version:  0.12.0
" WebPage:  http://github.com/heavenshell/vim-jsdoc/
" Description: Generate JSDoc to your JavaScript file.
" License: BSD, see LICENSE for more details.

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=0 -buffer -complete=customlist,jsdoc#insert JsDoc call jsdoc#insert()

nnoremap <silent> <buffer> <Plug>(jsdoc) :call jsdoc#insert()<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
