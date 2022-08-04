local vim = vim
local telescope = require("telescope")

local themes = require('telescope.themes')
local builtIn = require("telescope.builtin")
local actions = require("telescope.actions")
local action_set = require("telescope.actions.set")
local M = {}

telescope.load_extension("gh")
telescope.load_extension("packer")
telescope.load_extension("fzy_native")
telescope.load_extension("octo")

telescope.setup {
  defaults = {
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    mappings = {
      i = {
        -- ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<Tab>"] = actions.toggle_selection
      }
    }
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true
    }
  },
  pickers = {
    find_files = {
      hidden = true,
      attach_mappings = function(prompt_bufnr)
        action_set.select:enhance(
          {
            post = function()
              vim.cmd("normal! zx")
            end
          }
        )
        return true
      end
    }
  }
}
local function generateOpts(opts)
  local common_opts = {
    layout_strategy = "center",
    sorting_strategy = "ascending",
    results_title = false,
    preview_title = "Preview",
    picker_title = '',
    previewer = false,
    hidden = false,
    layout_config = {
      width = 80,
      height = 15
    },
    borderchars = {
      {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
      prompt = {"─", "│", " ", "│", "╭", "╮", "│", "│"},
      results = {"─", "│", "─", "│", "├", "┤", "╯", "╰"},
      preview = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"}
    },
    color_devicons = true,
    use_less = true,
    set_env = {["COLORTERM"] = "truecolor"} -- default = nil,
  }
  return themes.get_dropdown(vim.tbl_extend("force", opts, common_opts))
  -- return themes.get_ivy({previewer = false, layout_config = { height = 10, }, borderchars = {}})
end
function M.colors()
  local opts = generateOpts({})
  builtIn.colorscheme(opts)
end
function M.find_files()
  local cmn_opts = generateOpts({})
  -- cmn_opts.find_command = {"fd", "--type", "f", "-L"}
  builtIn.find_files(cmn_opts)
end
function M.help_tags()
  local opts = generateOpts({})
  builtIn.help_tags(opts)
end
function M.code_actions()
  local opts = generateOpts({})
  builtIn.lsp_code_actions(opts)
end
return M
