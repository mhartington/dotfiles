local M = {}
function M.autocmd(event, triggers, operations)
  local cmd = string.format("autocmd %s %s %s", event, triggers, operations)
 vim.cmd(cmd)
end

M.autocmd("BufEnter",     "*",   "if &buftype == 'terminal' | :startinsert | endif")
M.autocmd("BufReadPost",  "*",   [[if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif]])
M.autocmd("BufWritePre",  "*",   "%s/\\s\\+$//e")

M.autocmd("ColorScheme",  "*",   "lua require('mh.colors').setItalics()")
M.autocmd("CompleteDone", "*",   "pclose")

M.autocmd("FileType",     "vue", "syntax sync fromstart")

M.autocmd("InsertEnter",  "*",   "let save_cwd = getcwd() | set autochdir")
M.autocmd("InsertEnter",  "*",   "if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif")

M.autocmd("InsertLeave",  "*",   "set noautochdir | execute 'cd' fnameescape(save_cwd)")
M.autocmd("InsertLeave",  "*",   "if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif")

M.autocmd("TermOpen",     "*",   "setl bufhidden=hide")
M.autocmd("TermOpen",     "*",   "startinsert")
M.autocmd("TermOpen",     "*",   "setl nonumber")

M.autocmd("WinLeave",     "*",   "if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif")


-- vim.api.nvim_command('autocmd WinEnter * v:lua.mh.autocmds.Preview_func()')

-- autocmd WinEnter * call Preview_func()
--
-- function! Preview_func()
--   if &pvw
--     setlocal nonumber norelativenumber
--    endif
-- endfunction
--
--
return M
