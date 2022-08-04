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
    modified = {guifg = colors.green, guibg = "#0D1519"},
    modified_visible = {guifg = "#3C706F", guibg = "#101920"},
    modified_selected = {guifg = colors.cyan, guibg = "#142832"},
    fill = {guibg = "#0D1519"},
    background = {guibg = "#0D1519", guifg = colors.base04},
    tab = {guibg = "#0D1519", guifg = colors.base01},
    tab_selected = {guibg = "#142832"},
    tab_close = {guibg = "#0D1519"},
    buffer_visible = {guibg = "#101920"},
    buffer_selected = {guibg = "#142832", guifg = colors.white},
    indicator_selected = {guifg = colors.cyan, guibg = "#142832"},
    separator = {guibg = "#62b3b2"},
    separator_selected = {guifg = colors.cyan, guibg = "#142832"},
    separator_visible = {guibg = colors.cyan},
    duplicate = {guibg = "#0D1519", guifg = colors.base04},
    duplicate_selected = {guibg = "#142832", guifg = colors.white},
    duplicate_visible = {guibg = "#101920"},
    numbers = {guibg = "#0D1519", guifg = colors.base04},
    numbers_selected = {guibg = "#142832"},
    numbers_visible = {guibg = "#101920"},
  }
}
