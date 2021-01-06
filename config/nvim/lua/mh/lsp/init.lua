local vim = vim
local lspconfig = require "lspconfig"
local util = require "lspconfig/util"
local mapBuf = require "mh.mappings".mapBuf
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {virtual_text = false})

local on_attach = function(client, bufnr)
  require "completion".on_attach()
  mapBuf(bufnr, "n", "<Leader>gdc", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
  mapBuf(bufnr, "n", "<Leader>gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
  mapBuf(bufnr, "n", "<Leader>gt", "<Cmd>lua vim.lsp.buf.hover()<CR>")
  mapBuf(bufnr, "n", "<Leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  mapBuf(bufnr, "n", "<Leader>gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  mapBuf(bufnr, "n", "<Leader>gtd", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
  mapBuf(bufnr, "n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  mapBuf(bufnr, "n", "<Leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  mapBuf(bufnr, "n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  vim.api.nvim_command "autocmd CursorHold  <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()"
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  vim.fn.sign_define("LspDiagnosticsSignError", {text = "•"})
  vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "•"})
  vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "•"})
  vim.fn.sign_define("LspDiagnosticsSignHint", {text = "•"})
  vim.cmd("hi LspDiagnosticsUnderlineError gui=undercurl")
  vim.cmd("hi LspDiagnosticsUnderlineWarning gui=undercurl")
  vim.cmd("hi LspDiagnosticsUnderlineInformation gui=undercurl")
  vim.cmd("hi LspDiagnosticsUnderlineHint gui=undercurl")
end
local servers = {"vimls", "pyls", "bashls"}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {on_attach = on_attach}
end

local vs_code_extracted = {
  html = "vscode-html-language-server",
  cssls = "vscode-css-language-server",
  jsonls = "vscode-json-language-server"
}

for ls, cmd in pairs(vs_code_extracted) do
  lspconfig[ls].setup {
    cmd = {cmd, "--stdio"},
    on_attach = on_attach,
    capabilities = capabilities
  }
end
local lua_lsp_loc = "/Users/mhartington/Github/lua-language-server"

local function get_node_modules(root_dir)
  local project_root = util.find_node_modules_ancestor(root_dir)
  return project_root and project_root .. "/node_modules" or ""
end

local default_node_modules = get_node_modules(vim.fn.getcwd())
local ngls_cmd = {
  "ngls",
  "--stdio",
  "--tsProbeLocations",
  default_node_modules,
  "--ngProbeLocations",
  default_node_modules
  -- "--experimental-ivy"
}

lspconfig.angularls.setup {
  cmd = ngls_cmd,
  on_attach = on_attach,
  capabilities = capabilities,
  on_new_config = function(new_config, new_root_dir)
    new_config.cmd = ngls_cmd
  end
}

lspconfig.sumneko_lua.setup {
  cmd = {lua_lsp_loc .. "/bin/macOS/lua-language-server", "-E", lua_lsp_loc .. "/main.lua"},
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {version = "LuaJIT", path = vim.split(package.path, ";")},
      diagnostics = {globals = {"vim"}},
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true
        }
      }
    }
  }
}
