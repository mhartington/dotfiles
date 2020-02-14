local nvim_lsp = require "nvim_lsp"
local configs = require'nvim_lsp/skeleton'


-- Check if it's already defined for when I reload this file.
configs.sourcekit_lsp = {
  default_config = {
    cmd = {'sourcekit-lsp'};
    filetypes = {'swift'};
    root_dir = function(fname)
      return nvim_lsp.util.find_git_ancestor(fname) or vim.loop.os_homedir()
    end;
    log_level = vim.lsp.protocol.MessageType.Warning;
    settings = {};
  };
}

nvim_lsp.sourcekit_lsp.setup{}
nvim_lsp.pyls_ms.setup {}
nvim_lsp.cssls.setup {}
nvim_lsp.bashls.setup {}
-- nvim_lsp.tsserver.setup {}
