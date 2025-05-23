local vim = vim
local uv = vim.uv
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")
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
-- capabilities = vim.tbl_extend("keep", capabilities or {}, require("cmp_nvim_lsp").default_capabilities())

local M = {}
-- Diagnostic settings
vim.diagnostic.config({
  virtual_lines = false, --{ current_line = true },
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

local function get_node_modules(root_dir)
  local lspNMRoot = vim.fs.dirname(vim.fs.find("node_modules", { path = root_dir, upward = true })[1])
  if lspNMRoot == nil then
    return ""
  else
    return lspNMRoot
  end
end
vim.lsp.buf.references = Snacks.picker.lsp_references
local default_node_modules = get_node_modules(vim.fn.getcwd())

local on_attach = function(client, bufnr)
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

  -- vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
  --
  vim.api.nvim_create_autocmd({ "CursorHold" }, {
    group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
    callback = function()
      vim.diagnostic.open_float(nil, { focus = false })
    end,
  })

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

  -- if client:supports_method("textDocument/foldingRange") then
  --   local win = vim.api.nvim_get_current_win()
  --   vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
  -- end
end

local servers = { "pylsp", "bashls", "html", "cssls", "vimls", "svelte", "zls", "jdtls", "nxls" } --"biome" }

for _, lsp in ipairs(servers) do
  vim.lsp.enable(lsp)
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    capabilities = capabilities,
  })
  -- lspconfig[lsp].setup({
  -- })
end

lspconfig.sourcekit.setup({
  on_attach = on_attach,
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
    capabilities.textDocument,
  },
})
vim.lsp.enable('vtsls')
vim.lsp.config('vtslt', {
  root_dir = function(file)
    return vim.fs.dirname(vim.fs.find(".git", { path = file, upward = true })[1])
      or util.root_pattern(".git", "package.json", "tsconfig.json")(file)
  end,
  on_attach = on_attach,
  capabilities = capabilities,
  single_file_support = true,

  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = { enableServerSideFuzzyMatch = true },
      },
    },
    typescript = {
      updateImportsOnFileMove = "always",
      suggest = { completeFunctionCalls = true },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
    referencesCodeLens = {
      showOnAllFunctions = true,
      enabled = true,
    },
  },
})


configs.emmet_ls = {
  default_config = {
    cmd = { "emmet-ls", "--stdio" },
    filetypes = { "html", "css", "scss", "typescriptreact" },
    root_dir = function()
      return uv.cwd()
    end,
    settings = {},
  },
}
lspconfig.emmet_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.dartls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.jsonls.setup({
  cmd = { "vscode-json-language-server", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "json", "jsonc" },
  settings = {
    json = {
      -- Schemas https://www.schemastore.org
      schemas = {
        {
          fileMatch = { "package.json" },
          url = "https://json.schemastore.org/package.json",
        },
        {
          fileMatch = { "manifest.json", "manifest.webmanifest" },
          url = "https://json.schemastore.org/web-manifest-combined.json",
        },
        {
          fileMatch = { "tsconfig*.json" },
          url = "https://json.schemastore.org/tsconfig.json",
        },
        {
          fileMatch = {
            ".prettierrc",
            ".prettierrc.json",
            "prettier.config.json",
          },
          url = "https://json.schemastore.org/prettierrc.json",
        },
        {
          fileMatch = { ".eslintrc", ".eslintrc.json" },
          url = "https://json.schemastore.org/eslintrc.json",
        },
        {
          fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
          url = "https://json.schemastore.org/babelrc.json",
        },
        {
          fileMatch = { "lerna.json" },
          url = "https://json.schemastore.org/lerna.json",
        },
        {
          fileMatch = { "now.json", "vercel.json" },
          url = "https://json.schemastore.org/now.json",
        },
        {
          fileMatch = {
            ".stylelintrc",
            ".stylelintrc.json",
            "stylelint.config.json",
          },
          url = "http://json.schemastore.org/stylelintrc.json",
        },
      },
    },
  },
})

lspconfig.angularls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = util.root_pattern("angular.json", "project.json"),
})

lspconfig.volar.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    typescript = {
      tsdk = default_node_modules .. "/typescript/lib",
    },
  },
})

-- lspconfig.harper_ls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     ["harper-ls"] = {
--       userDictPath = "",
--       fileDictPath = "",
--       linters = {
--         SpellCheck = true,
--         SpelledNumbers = false,
--         AnA = true,
--         SentenceCapitalization = true,
--         UnclosedQuotes = true,
--         WrongQuotes = false,
--         LongSentences = true,
--         RepeatedWords = true,
--         Spaces = true,
--         Matcher = true,
--         CorrectNumberSuffix = true
--       },
--       codeActions = {
--         ForceStable = false
--       },
--       markdown = {
--         IgnoreLinkTitle = false
--       },
--       diagnosticSeverity = "hint",
--       isolateEnglish = false
--     }
--   }
-- }

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
return M
