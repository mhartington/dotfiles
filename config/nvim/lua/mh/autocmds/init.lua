-- local M = {}

vim.api.nvim_command("autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif")
vim.api.nvim_command("autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif")
vim.api.nvim_command("autocmd FileType vue syntax sync fromstart")
vim.api.nvim_command("autocmd CompleteDone * pclose")
vim.api.nvim_command('autocmd BufEnter * if &buftype == "terminal" | :startinsert | endif')
vim.api.nvim_command("autocmd TermOpen * set bufhidden=hide")
vim.api.nvim_command("autocmd TermOpen * startinsert")
vim.api.nvim_command("autocmd BufWritePre * %s/\\s\\+$//e")
vim.api.nvim_command(
  [[ autocmd BufReadPost *
              if line("'\"") > 0 && line ("'\"") <= line("$") |
                exe "normal! g'\"" |
              endif
]]
)

vim.api.nvim_command( 'autocmd InsertEnter * let save_cwd = getcwd() | set autochdir' )
vim.api.nvim_command( "autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)" )
vim.api.nvim_command("autocmd ColorScheme * lua require('mh.colors').setItalics()")


-- vim.api.nvim_command('autocmd WinEnter * v:lua.mh.autocmds.Preview_func()')

-- autocmd BufEnter term://* startinsert
-- autocmd TermOpen * set bufhidden=hide
-- autocmd WinEnter * call Preview_func()
--
-- function! Preview_func()
--   if &pvw
--     setlocal nonumber norelativenumber
--    endif
-- endfunction
--
--
