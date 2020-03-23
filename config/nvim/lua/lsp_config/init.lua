local nvim_lsp = require "nvim_lsp"
local diagnostic = require'diagnostic'
-- local configs = require'nvim_lsp/config'


-- -- Check if it's already defined for when I reload this file.
-- configs.sourcekit_lsp = {
--   default_config = {
--     cmd = {'sourcekit-lsp'};
--     filetypes = {'swift'};
--     root_dir = function(fname)
--       return nvim_lsp.util.find_git_ancestor(fname) or vim.loop.os_homedir()
--     end;
--     log_level = vim.lsp.protocol.MessageType.Warning;
--     settings = {};
--   };
-- }
-- nvim_lsp.sourcekit_lsp.setup{}


nvim_lsp.pyls_ms.setup {on_attach=diagnostic.on_attach}
nvim_lsp.cssls.setup   {on_attach=diagnostic.on_attach}
nvim_lsp.html.setup    {on_attach=diagnostic.on_attach}
nvim_lsp.jsonls.setup  {on_attach=diagnostic.on_attach}
nvim_lsp.bashls.setup  {on_attach=diagnostic.on_attach}
-- nvim_lsp.tsserver.setup {}
