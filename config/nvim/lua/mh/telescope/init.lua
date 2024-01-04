local vim = vim
local telescope = require("telescope")

local themes = require("telescope.themes")
local builtIn = require("telescope.builtin")
local actions = require("telescope.actions")
local action_set = require("telescope.actions.set")

local devicons = require("nvim-web-devicons")
local entry_display = require("telescope.pickers.entry_display")
local M = {}

telescope.load_extension("gh")
telescope.load_extension("fzy_native")
telescope.load_extension("octo")

local entry_maker = function(opts)
  opts = opts or {}
  local default_icons, _ = devicons.get_icon("file", "", { default = true })

  local displayer = entry_display.create({
    separator = " ",
    items = {
      { width = vim.fn.strwidth(default_icons) },
      { remaining = true },
      { remaining = true },
    },
  })

  local make_display = function(entry)
    return displayer({
      { entry.devicons, entry.devicons_highlight },
      entry.file_name,
      { entry.dir_name, "Comment" },
    })
  end

  return function(entry)
    local dir_name = vim.fn.fnamemodify(entry, ":.")
    local file_name = vim.fn.fnamemodify(entry, ":p:t")

    local icons, highlight = devicons.get_icon(entry, string.match(entry, "%a+$"), { default = true })

    return {
      valid = true,
      value = entry,
      ordinal = entry,
      display = make_display,
      devicons = icons,
      devicons_highlight = highlight,
      file_name = file_name,
      dir_name = dir_name,
    }
  end
end

telescope.setup({
  defaults = {
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    mappings = {
      i = {
        -- ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<Tab>"] = actions.toggle_selection,
      },
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      attach_mappings = function(prompt_bufnr)
        action_set.select:enhance({
          post = function()
            vim.cmd("normal! zx")
          end,
        })
        return true
      end,
    },
  },
})
local function generateOpts(opts)
  local common_opts = {
    entry_maker = entry_maker(),
    layout_strategy = "center",
    sorting_strategy = "ascending",
    results_title = false,
    preview_title = "Preview",
    picker_title = nil,
    prompt_title = nil,
    previewer = false,
    hidden = false,
    layout_config = {
      width = 80,
      height = 15,
    },
    borderchars = {
      { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    color_devicons = true,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
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
