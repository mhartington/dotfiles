local vim = vim
local builtIn = require("telescope.builtin")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local path = require('telescope.path')
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local M = {}
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
  return vim.tbl_extend('force', opts, common_opts)
end

function M.colors()
  local opts = generateOpts({})
  builtIn.colorscheme(opts)

end
function M.find_files()
  local cmn_opts = generateOpts({})
  builtIn.find_files(cmn_opts)
end

function M.help_tags()

  local all_tag_files = {}
  local all_help_files = {}
  for _, v in ipairs(vim.split(vim.fn.globpath(vim.o.runtimepath, 'doc/*', 1), '\n')) do
    local split_path = vim.split(v, path.separator, true)
    local filename = split_path[#split_path]
    if filename == 'tags' then
      table.insert(all_tag_files, v)
    else
      all_help_files[filename] = v
    end
  end

  local delim = string.char(9)
  local tags = {}
  for _, file in ipairs(all_tag_files) do
    local data = vim.split(path.read_file(file), '\n')
    for _, line in ipairs(data) do
      if line ~= '' then
        local matches = {}

        for match in (line..delim):gmatch("(.-)" .. delim) do
          table.insert(matches, match)
        end

        if table.getn(matches) ~= 0 then
          table.insert(tags, {
            name = matches[1],
            filename = all_help_files[matches[2]],
            cmd = matches[3]
          })
        end
      end
    end
  end

  local opts = generateOpts({})
  pickers.new(
    opts,
    {
      prompt_title = "Help",
      finder = finders.new_table {
        results = tags,
        entry_maker = function(entry)
        return {
          value = entry.name,
          display = entry.name,
          ordinal = entry.name,
        }
      end,
      },
      sorter = sorters.get_generic_fuzzy_sorter(opts),
      attach_mappings = function(prompt_bufnr)
        actions._goto_file_selection:replace(
          function()
            local selection = actions.get_selected_entry()
            actions.close(prompt_bufnr)
            vim.cmd("help " .. selection.value)
          end
        )
        return true
      end
    }
  ):find()
end
return M
