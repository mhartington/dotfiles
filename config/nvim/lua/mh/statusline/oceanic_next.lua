local M = {}
M.normal = {
  a = {bg = vim.g.base00, fg = vim.g.base07},
  b = {bg = vim.g.base00, fg = vim.g.base07},
  c = {bg = vim.g.base00, fg = vim.g.base07}
}
M.insert = {
  a = {bg = vim.g.base00, fg = vim.g.base07},
  b = {bg = vim.g.base00, fg = vim.g.base07},
  c = {bg = vim.g.base00, fg = vim.g.green}
}
M.visual = {
  a = {bg = vim.g.base00, fg = vim.g.base07},
  b = {bg = vim.g.base00, fg = vim.g.base07},
  c = {bg = vim.g.base00, fg = vim.g.orange}
}
M.replace = {
  a = {bg = vim.g.base00, fg = vim.g.base07},
  b = {bg = vim.g.base00, fg = vim.g.base07},
  c = {bg = vim.g.base00, fg = vim.g.red}
}
M.command = {
  a = {bg = vim.g.base00, fg = vim.g.base07},
  b = {bg = vim.g.base00, fg = vim.g.base07},
  c = {bg = vim.g.base00, fg = vim.g.cyan}
}

M.terminal = M.normal

M.inactive = {
  a = {bg = vim.g.base00, fg = vim.g.base03},
  b = {bg = vim.g.base00, fg = vim.g.base03},
  c = {bg = vim.g.base00, fg = vim.g.base03}
}
return M
