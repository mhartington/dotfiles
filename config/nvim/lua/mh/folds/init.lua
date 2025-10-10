local M = {}

local parsers = require("nvim-treesitter.parsers")
local configs = parsers.get_parser_configs()
local ft_str = vim.tbl_map(function(ft)
  return configs[ft].filetype or ft
end, parsers.available_parsers())

vim.api.nvim_create_autocmd("Filetype", {
  pattern = ft_str,
  desc = "Use Treesitter for Folds",
  callback = function()
    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  end,
})




function foldText()
	local fs = vim.api.nvim_get_vvar("foldstart")
	local fe = vim.api.nvim_get_vvar("foldend")
	local line = vim.fn.substitute(vim.fn.getline(fs), "\t", string.rep(" ", vim.bo.tabstop), "g") .. ""
	return line
end
--
