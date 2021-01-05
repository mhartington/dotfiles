local ts = require "nvim-treesitter.configs"

ts.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
    use_languagetree = true
  },
  indent = {
    enable = true
  }
}
