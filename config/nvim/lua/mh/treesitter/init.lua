local ts = require "nvim-treesitter.configs"

ts.setup {
  context_commentstring = {enable = true},
  ensure_installed = "all",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
  indent = {enable = true},
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = {"BufWrite", "CursorHold"}
  }
}
