local colors = require "mh.colors"
local M = {}
M.normal = {
  a = {bg = colors.base01, fg = colors.white},
  b = {bg = colors.base01, fg = colors.white},
  c = {bg = colors.base01, fg = colors.white}
}
M.insert = {
  a = {bg = colors.base01, fg = colors.green},
  b = {bg = colors.base01, fg = colors.green},
  c = {bg = colors.base01, fg = colors.green}
}
M.visual = {
  a = {bg = colors.base01, fg = colors.orange},
  b = {bg = colors.base01, fg = colors.orange},
  c = {bg = colors.base01, fg = colors.orange}
}
M.replace = {
  a = {bg = colors.base01, fg = colors.red},
  b = {bg = colors.base01, fg = colors.red},
  c = {bg = colors.base01, fg = colors.red}
}
M.command = {
  a = {bg = colors.base01, fg = colors.cyan},
  b = {bg = colors.base01, fg = colors.cyan},
  c = {bg = colors.base01, fg = colors.cyan}
}

M.terminal = M.normal

M.inactive = {
  a = {bg = colors.base01, fg = colors.base03},
  b = {bg = colors.base01, fg = colors.base03},
  c = {bg = colors.base01, fg = colors.base03}
}
return M
