local M = {}
function foldText()
  local fs = vim.api.nvim_get_vvar("foldstart")
  local fe = vim.api.nvim_get_vvar("foldend")
  local line =
    vim.fn.substitute(vim.fn.getline(fs), "\t", string.rep(" ", vim.bo.tabstop), "g") ..
    "" .. vim.fn.getline(fe):gsub("%s+", "")
  return line
end
--
