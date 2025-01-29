
local M = {}
M.setItalics = function()
	vim.cmd("hi Keyword gui=italic")
	vim.cmd("hi Identifier gui=italic")
	vim.cmd("hi StorageClass gui=italic")
	vim.cmd("hi @tag.attribute gui=italic")
	vim.cmd("hi pythonSelf gui=italic")
end
M.setItalics()
return M
