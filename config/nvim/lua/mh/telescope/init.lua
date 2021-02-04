local vim = vim
local telescope = require("telescope")
local builtIn = require("telescope.builtin")
local actions = require("telescope.actions")
local M = {}

telescope.load_extension("gh")
telescope.load_extension("node_modules")
telescope.load_extension("packer")

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.goto_file_selection_edit,
        ["<Tab>"] = actions.toggle_selection
      }
    }
  }
}
local function generateOpts(opts)
  local common_opts = {
    layout_strategy = "center",
    sorting_strategy = "ascending",
    results_title = false,
    preview_title = "Preview",
    previewer = false,
    width = 80,
    results_height = 15,
    borderchars = {
      {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
      prompt = {"─", "│", " ", "│", "╭", "╮", "│", "│"},
      results = {"─", "│", "─", "│", "├", "┤", "╯", "╰"},
      preview = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"}
    }
  }
  return vim.tbl_extend("force", opts, common_opts)
end
function M.colors()
  local opts = generateOpts({})
  builtIn.colorscheme(opts)
end
function M.find_files()
  local cmn_opts = generateOpts({})
  cmn_opts.find_command = {"rg", "--files", "-L", "--glob", "!.git"}
  builtIn.find_files(cmn_opts)
end
function M.help_tags()
  local opts = generateOpts({})
  builtIn.help_tags(opts)
end
return M
