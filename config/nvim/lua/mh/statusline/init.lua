local lualine = require "lualine"
local bufferline = require "bufferline"
local oceanic_next = require "mh.statusline.oceanic_next"
local colors = require "mh.colors"

local function get_short_cwd()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ":.:t")
end

local yanil_statusline = {
  sections = {
    lualine_a = {get_short_cwd}
  },
  filetypes = {"Yanil"}
}

lualine.setup {
  extensions = {yanil_statusline},
  options = {theme = oceanic_next},
  sections = {
    lualine_a = {""},
    lualine_b = {"branch"},
    lualine_c = {"filename"},
    lualine_x = {"b:gitsigns_status"},
    lualine_y = {"filetype"},
    lualine_z = {
      "location",
      {"diagnostics", sources = {"nvim_diagnostic"}, symbols = {error = " ", warn = " ", info = " "}}
    }
  }
}

bufferline.setup {
  options = {
    view = "default",
    numbers = function(opts)
      return string.format("%s.", opts.ordinal)
    end,
    buffer_close_icon = "",
    modified_icon = "•",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 18,
    max_prefix_length = 15,
    show_buffer_close_icons = false,
    persist_buffer_sort = true,
    separator_style = {"", ""},
    enforce_regular_tabs = false,
    always_show_bufferline = true
  },
  highlights = {
    modified = {fg = colors.green, bg = "#0D1519"},
    modified_visible = {fg = "#3C706F", bg = "#101920"},
    modified_selected = {fg = colors.cyan, bg = "#142832"},
    fill = {bg = "#0D1519"},
    background = {bg = "#0D1519", fg = colors.base04},
    tab = {bg = "#0D1519", fg = colors.base01},
    tab_selected = {bg = "#142832"},
    tab_close = {bg = "#0D1519"},
    buffer_visible = {bg = "#101920"},
    buffer_selected = {bg = "#142832", fg = colors.white},
    indicator_selected = {fg = colors.cyan, bg = "#142832"},
    separator = {bg = "#62b3b2"},
    separator_selected = {fg = colors.cyan, bg = "#142832"},
    separator_visible = {bg = colors.cyan},
    duplicate = {bg = "#0D1519", fg = colors.base04},
    duplicate_selected = {bg = "#142832", fg = colors.white},
    duplicate_visible = {bg = "#101920"},
    numbers = {bg = "#0D1519", fg = colors.base04},
    numbers_selected = {bg = "#142832"},
    numbers_visible = {bg = "#101920"},
  }
}
