local keymap = require("mh.mappings").keymap

local capabilities = {
  textDocument = {
    completion = {
      completionItem = {
        snippetSupport = true,
        resolveSupport = {
          properties = { "documentation", "detail", "additionalTextEdits", "documentHighlight" },
        },
      },
    },
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
}
capabilities.textDocument.colorProvider = { dynamicRegistration = false }
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

local M = {}

-- Diagnostic settings
vim.diagnostic.config({
  virtual_lines = false,
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "•",
      [vim.diagnostic.severity.WARN] = "•",
      [vim.diagnostic.severity.INFO] = "•",
      [vim.diagnostic.severity.HINT] = "•",
    },
  },
  update_in_insert = true,
  float = {
    focusable = false,
    border = "rounded",
    scope = "cursor",
    header = "",
    prefix = " ",
  },
})

vim.lsp.buf.references = Snacks.picker.lsp_references
vim.lsp.config("*", { capabilities = capabilities })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    local float_opts = { border = "rounded", silent = true }
    keymap("n", "<Leader>gdc", vim.lsp.buf.declaration, bufopts)
    keymap("n", "<Leader>gd", vim.lsp.buf.definition, bufopts)
    keymap("n", "<Leader>gh", function()
      vim.lsp.buf.hover(float_opts)
    end)
    keymap("n", "<Leader>gi", vim.lsp.buf.implementation, bufopts)
    keymap("n", "<Leader>gs", vim.lsp.buf.signature_help, bufopts)
    keymap("n", "<Leader>gtd", vim.lsp.buf.type_definition, bufopts)
    keymap("n", "<Leader>rn", vim.lsp.buf.rename, bufopts)
    keymap("n", "<Leader>gr", vim.lsp.buf.references, bufopts)
    keymap("n", "<Leader>ca", vim.lsp.buf.code_action, bufopts)
    keymap("v", "<Leader>ca", vim.lsp.buf.code_action, bufopts)
    keymap("n", "<Leader>sd", vim.diagnostic.open_float, bufopts)
  end,
})
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
  callback = function()
    vim.diagnostic.open_float({ focus = false, scope = "cursor" })
  end,
})

vim.lsp.handlers["client/registerCapability"] = (function(overridden)
  return function(err, res, ctx)
    local result = overridden(err, res, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if not client then
      return
    end
    for bufnr, _ in pairs(client.attached_buffers) do
      if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
        vim.api.nvim_create_autocmd("CursorHold", {
          callback = vim.lsp.buf.document_highlight,
          buffer = bufnr,
          group = "lsp_document_highlight",
          desc = "Document Highlight",
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
          callback = vim.lsp.buf.clear_references,
          buffer = bufnr,
          group = "lsp_document_highlight",
          desc = "Clear All the References",
        })
      end

      if client:supports_method("textDocument/documentColor") then
        vim.lsp.document_color.enable(true, bufnr, { style = "virtual" })
      end
    end
    return result
  end
end)(vim.lsp.handlers["client/registerCapability"])

local servers = {
  "pylsp",
  "bashls",
  "html",
  "cssls",
  "vimls",
  "svelte",
  "zls",
  "nxls",
  "sourcekit",
  "emmylua_ls",
  "harper_ls",
  "vtsls",
  "emmet_language_server",
  "vue_ls",
  "angularls",
  "gh_actions_ls",
  "jsonls",
  "dartls",
  -- "eslint-lsp",
  "rust_analyzer",
  "kotlin_lsp"
}
vim.lsp.enable(servers)

return M
