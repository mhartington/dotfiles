vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Move Cursor to last line",
  callback = function()
    vim.cmd([[if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif]])
  end,
})
vim.api.nvim_create_autocmd("ColorScheme", {
  desc = "Set Italics",
  callback = function()
    require("mh.colors").setItalics()
  end,
})


vim.api.nvim_create_autocmd("User", {
  desc = "Tell LSP whne file has moved and update imports",
  pattern= "YanilTreeFileMoved",
  callback = function(event)
    Snacks.rename.on_rename_file(event.data.prev, event.data.next)
  end,
})

vim.api.nvim_create_autocmd("CompleteDone", {
  desc = "Close Pmenu when done",
  callback = function()
    vim.cmd("pclose")
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Hide number, hide buffer, make insert for terminal",
  callback = function()
    vim.opt_local.bufhidden = "hide"
    vim.opt_local.number = false
    vim.cmd("startinsert")
  end,
})

vim.api.nvim_create_autocmd("LspProgress", {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(vim.lsp.status(), "info", {
      id = "lsp_progress",
      title = "LSP Progress",
    })
  end,
})

vim.api.nvim_create_autocmd("TermResponse", {
  once= true,
  callback = function(args)
    -- print(vim.inspect(args))
    -- local bg = vim.o.bg
    -- if bg == "dark" then
    --   vim.cmd.colorscheme("OceanicNext")
    -- else
    --   vim.cmd.colorscheme("OceanicNextLight")
    -- end
  end,
})
