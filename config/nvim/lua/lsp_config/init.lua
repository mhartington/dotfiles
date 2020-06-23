local vim = vim
local uv = vim.loop

local nvim_lsp = require "nvim_lsp"
local configs = require'nvim_lsp/configs'
local util = require 'nvim_lsp/util'
local default_callbacks = require 'vim.lsp.callbacks'
local internal_util = require 'vim.lsp.util'


default_callbacks['textDocument/publishDiagnostics'] = function(_, _, result)
  if not result then return end
  local uri = result.uri
  local bufnr = vim.uri_to_bufnr(uri)
  if not bufnr then return end
  internal_util.buf_clear_diagnostics(bufnr)
  internal_util.buf_diagnostics_save_positions(bufnr, result.diagnostics)
  internal_util.buf_diagnostics_underline(bufnr, result.diagnostics)
  internal_util.buf_diagnostics_signs(bufnr, result.diagnostics)
  vim.api.nvim_command("doautocmd User LspDiagnosticsChanged")
end

-- -- "@angular/language-server"
-- local server_name = "tsserver"
-- local bin_name = "typescript-language-server"

-- local is_windows = uv.os_uname().version:match("Windows")
-- local path_sep = is_windows and "\\" or "/"
-- local function path_join(...)
--   return table.concat( vim.tbl_flatten {...}, path_sep):gsub(path_sep.."+", path_sep)
-- end
-- local projectRootAbs = vim.fn.getcwd()
--
--
--
-- -- local lspConfigInfo = vim.api.nvim_command('LspInstallInfo nglsp')
-- -- print(lspConfigInfo)
-- local function make_command()
--   -- print(uv.fs_realpath('/users/mhartington/Github/lsp-test/angular.json'))
--   return {"echo", "foo"}
-- end;
-- local server_name = "nglsp"
-- local bin_name = "@angular/language-server"
-- local installer = nvim_lsp.util.npm_installer {
--   server_name = server_name;
--   packages = { "@angular/language-server" };
--   binaries = { "@angular/language-server" };
-- }
-- configs.nglsp = {
--    default_config = {
--      cmd = make_command();
--      filetypes = {"html", "typescript"};
--      root_dir = util.root_pattern("package.json");
--    };
-- };
-- configs[server_name].install = installer.install
-- configs[server_name].install_info = installer.info

local on_attach = function(_, bufnr)

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  require'completion'.on_attach()

  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gdc', '<Cmd>lua vim.lsp.buf.declaration()<CR>',     opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd',  '<Cmd>lua vim.lsp.buf.definition()<CR>',      opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gt',  '<Cmd>lua vim.lsp.buf.hover()<CR>',           opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gi',  '<cmd>lua vim.lsp.buf.implementation()<CR>',  opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gs',  '<cmd>lua vim.lsp.buf.signature_help()<CR>',  opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gtd',   '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn',  '<cmd>lua vim.lsp.buf.rename()<CR>',          opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr',  '<cmd>lua vim.lsp.buf.references()<CR>',      opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca',  '<cmd>lua vim.lsp.buf.code_action()<CR>',     opts)

  vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.util.show_line_diagnostics()]]
  -- vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
  -- vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
  -- vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
end

local servers = {'cssls', 'html', 'tsserver', 'vimls', 'pyls_ms', 'jsonls', 'bashls'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
  }
end

