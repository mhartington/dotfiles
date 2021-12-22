local lualine = require "lualine"
local bufferline = require "bufferline"
local oceanic_next = require "mh.statusline.oceanic_next"
local colors = require "mh.colors"
local messages = require("lsp-status/messaging").messages
local spinner_frames = {"⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"}

local function get_lsp_progress()
  local buf_messages = messages()
  local msgs = {}
  for _, msg in ipairs(buf_messages) do
    local contents
    if msg.progress then
      contents = msg.title
      if msg.spinner then
        contents = spinner_frames[(msg.spinner % #spinner_frames) + 1] .. " " .. contents
      end
    elseif msg.status then
      contents = msg.content
      if msg.uri then
        local filename = vim.uri_to_fname(msg.uri)
        filename = vim.fn.fnamemodify(filename, ":~:.")
        local space = math.min(60, math.floor(0.6 * vim.fn.winwidth(0)))
        if #filename > space then
          filename = vim.fn.pathshorten(filename)
        end
        contents = "(" .. filename .. ") " .. contents
      end
    else
      contents = msg.content
    end
    table.insert(msgs, contents)
  end
  return table.concat(msgs, " ")
end

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
    lualine_c = {"filename", get_lsp_progress},
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
    buffer_selected = {guibg = "#142832", guifg = colors.white, gui = "NONE"},
    indicator_selected = {guifg = colors.cyan, guibg = "#142832"},
    separator = {guibg = "#62b3b2"},
    separator_selected = {guifg = colors.cyan, guibg = "#142832"},
    separator_visible = {guibg = colors.cyan},
    duplicate = {guibg = "#0D1519", guifg = colors.base04, gui = "NONE"},
    duplicate_selected = {guibg = "#142832", gui = "NONE", guifg = colors.white},
    duplicate_visible = {guibg = "#101920", gui = "NONE"}
  }
}
