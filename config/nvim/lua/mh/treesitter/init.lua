local ts = require "nvim-treesitter.configs"

ts.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
    use_languagetree = true
  },
  indent = {
    enable = false
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = {"BufWrite", "CursorHold"},
  },
}
