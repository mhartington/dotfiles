local ts = require "nvim-treesitter.configs"

ts.setup {
  ensure_installed = "all",
  highlight = {
    enable = false,
    use_languagetree = false
  },
  indent = {
    enable = false
  }
}
