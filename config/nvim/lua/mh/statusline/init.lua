local lualine = require("lualine")
local bufferline = require("bufferline")
local oceanic_next = require("mh.statusline.oceanic_next")

lualine.setup({
  options = { theme = oceanic_next },
  sections = {
    lualine_a = { "" },
    lualine_b = { { "branch", icon = "" } },
    lualine_c = { "filename" },
    lualine_x = { "b:gitsigns_status" },
    lualine_y = { "filetype" },
    lualine_z = {
      "location",
      { "diagnostics", sources = { "nvim_diagnostic" } },
    },
  },
})

bufferline.setup({
  options = {
    numbers = function(opts)
      return string.format("%s.", opts.ordinal)
    end,

    offsets = {
      {
        filetype = "Yanil",
        text = "Explorer",
        highlight = "Directory",
        text_align = "left",
        separator = false, -- use a "true" to enable the default, or set your own character
      },
    },
    buffer_close_icon = "x",
    modified_icon = "",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    -- style_preset = bufferline.style_preset.minimal, -- or bufferline.style_preset.minimal,
    max_name_length = 18,
    max_prefix_length = 15,
    show_buffer_close_icons = false,
    persist_buffer_sort = true,
    separator_style = { "", "" },
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    color_icons = true,
  },
  highlights = {
    -- tabline bar
    fill = { link = "TabLineFill" },

    -- default tab styles
    background = { bg = { highlight = "TabLine", attribute = "bg" } },
    numbers = { bg = { highlight = "TabLine", attribute = "bg" } },
    -- For duplicate files, this will control the path before the file name
    duplicate = { bg = { highlight = "TabLine", attribute = "bg" } },

    -- Modifer Symbol, consisten
    modified = { fg = vim.g.cyan, bg = { highlight = "TabLine", attribute = "bg" } },
    modified_visible = { fg = vim.g.cyan, bg = { highlight = "TabLineSel", attribute = "bg" } },
    modified_selected = { fg = vim.g.cyan, bg = { highlight = "TabLineSel", attribute = "bg" } },

    -- Active buffer indicator
    indicator_selected = { fg = vim.g.cyan, bg = vim.g.cyan },
    indicator_visible = { fg = vim.g.cyan, bg = vim.g.cyan },

    -- Selected, Visable, not Focused
    buffer_visible = {
      fg = { highlight = "Normal", attribute = "fg" },
      bg = { highlight = "TabLineSel", attribute = "bg" },
      italic = true,
      bold = true,
    },
    numbers_visible = {
      fg = { highlight = "Normal", attribute = "fg" },
      bg = { highlight = "TabLineSel", attribute = "bg" },
      italic = true,
      bold = true,
    },
    duplicate_visible = { bg = { highlight = "TabLineSel", attribute = "bg" }, italic = true },

    -- Selected, Visable, Focused
    buffer_selected = {
      fg = { highlight = "Normal", attribute = "fg" },
      bg = { highlight = "TabLineSel", attribute = "bg" },
    },
    numbers_selected = {
      fg = { highlight = "Normal", attribute = "fg" },
      bg = { highlight = "TabLineSel", attribute = "bg" },
    },
    duplicate_selected = { bg = { highlight = "TabLineSel", attribute = "bg" } },
  },
})
-- local root = vim.fn.getcwd()
--
-- local workspace = root:sub(root:find('[^/]*$'))
-- local bufferline_groups = require('bufferline.groups')
-- local groups = require('bufferline.groups')
-- local bufferline = require('bufferline')
--
-- bufferline.setup({
--   options = {
--     close_command = 'Bdelete! %d',
--     tab_size = 0,
--     enforce_regular_tabs = false,
--     show_buffer_close_icons = false,
--     show_close_icon = false,
--     show_buffer_icons = false,
--     themable = true,
--     style_preset = bufferline.style_preset.default,
--     left_trunc_marker = '',
--     right_trunc_marker = '',
--     groups = {
--       options = {
--         toggle_hidden_on_enter = false,
--       },
--       items = {
--         bufferline_groups.builtin.pinned:with({ icon = ' ' }),
--         groups.builtin.ungrouped,
--         {
--           name = 'notes',
--           separator = {
--             style = require('bufferline.groups').separator.tab,
--           },
--           matcher = function(buf)
--             for _, ext in ipairs({ 'md', 'txt', 'org', 'norg', 'wiki' }) do
--               if ext == vim.fn.fnamemodify(buf.path, ':e') then return true end
--             end
--           end,
--         },
--       },
--     },
--
--     right_mouse_command = 'Bdelete! %d',
--     left_mouse_command = 'buffer %d',
--     indicator = {
--       style = 'none',
--     },
--     separator_style = { '', '' },
--     modified_icon = '',
--     offsets = {
--       {
--         filetype = 'neo-tree',
--         text_align = 'left',
--         text = string.format('  %s', workspace),
--         padding = 1,
--       },
--     },
--   },
--   highlights = {
--     fill = {
--       bg = { attribute = 'bg', highlight = 'TabLine' },
--     },
--     background = {
--       fg = { attribute = 'fg', highlight = 'TabLine' },
--       sp = { attribute = 'sp', highlight = 'BufferlineFill' },
--       underline = not vim.g.neovide,
--     },
--   },
-- })
