local M = {}
local function bufwidth()
  local width = vim.fn.winwidth(0)
  local numwidth = 0
  local wo = vim.wo
  if wo.number or wo.relativenumber then
    numwidth = wo.numberwidth
  end
  local foldwidth = wo.foldcolumn
  local sc = wo.signcolumn
  local signwidth = 0
  if sc == 'yes' then
    signwidth = 2
  elseif sc == 'auto' then
    local signs = vim.fn.execute(string.format("sign place buffer=%d", vim.fn.bufnr("")))
    signs = vim.fn.split(signs, "\n")
    if #signs > 2 then
      signwidth = 2
    else
      signwidth = 0
    end
  end
  return width - numwidth - foldwidth - signwidth
end
function foldText()
  local fs = vim.api.nvim_get_vvar("foldstart")
  local fe = vim.api.nvim_get_vvar("foldend")
  local line = vim.fn.substitute(vim.fn.getline(fs), "\t", string.rep(' ', vim.bo.tabstop), 'g')
  local winSize = bufwidth()
  local fillcharcount = winSize - #line - 2
  return line .. ' '.. string.rep(" ", fillcharcount)

end
--
--
-- " autocmd FileType vim setlocal fdc=1
-- set foldlevel=99
--
-- " Space to toggle folds.
-- autocmd FileType vim setlocal foldmethod=marker
-- autocmd FileType vim setlocal foldlevel=0
--
-- autocmd FileType javascript,html,css,scss,typescript setlocal foldlevel=99
--
-- autocmd FileType css,scss,json setlocal foldmethod=marker
-- autocmd FileType css,scss,json setlocal foldmarker={,}
--
-- autocmd FileType coffee setl foldmethod=indent
-- let g:xml_syntax_folding = 1
-- autocmd FileType xml setl foldmethod=syntax
--
-- autocmd FileType html setl foldmethod=expr
-- autocmd FileType html setl foldexpr=HTMLFolds()
--
-- " autocmd FileType javascript,typescript,typescript.tsx,typescriptreact,json,lua setl foldmethod=syntax
-- set foldmethod=expr
-- set foldexpr=nvim_treesitter#foldexpr()
return M
