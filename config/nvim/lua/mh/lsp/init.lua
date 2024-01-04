local vim = vim
local uv = vim.uv
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")
local mapBuf = require("mh.mappings").mapBuf
local methods = vim.lsp.protocol.Methods

local md_namespace = vim.api.nvim_create_namespace("mhartington/lsp_float")
-- local autocmd = require "mh.autocmds".autocmd

local capabilities = {
	textDocument = {
		completion = {
			completionItem = {
				snippetSupport = true,
			},
		},
	},
}
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities = vim.tbl_extend("keep", capabilities or {}, require("cmp_nvim_lsp").default_capabilities())

local M = {}

-- Diagnostic settings
vim.diagnostic.config({
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
	float = { focusable = false },
})

local function get_node_modules(root_dir)
	local lspNMRoot = util.find_node_modules_ancestor(root_dir)
	if lspNMRoot == nil then
		return ""
	else
		return lspNMRoot
	end
end

local default_node_modules = get_node_modules(vim.fn.getcwd())

local function enhanced_float_handler(handler)
	return function(err, result, ctx, config)
		local buf, win = handler(
			err,
			result,
			ctx,
			vim.tbl_deep_extend("force", config or {}, {
				-- border = 'rounded',
				max_height = math.floor(vim.o.lines * 0.5),
				max_width = math.floor(vim.o.columns * 0.4),
			})
		)

		if not buf or not win then
			return
		end

		-- Conceal everything.
		vim.wo[win].concealcursor = "n"

		-- Extra highlights.
		for l, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
			for pattern, hl_group in pairs({
				["|%S-|"] = "@text.reference",
				["@%S+"] = "@parameter",
				["^%s*(Parameters:)"] = "@text.title",
				["^%s*(Return:)"] = "@text.title",
				["^%s*(See also:)"] = "@text.title",
				["{%S-}"] = "@parameter",
			}) do
				local from = 1 ---@type integer?
				while from do
					local to
					from, to = line:find(pattern, from)
					if from then
						vim.api.nvim_buf_set_extmark(buf, md_namespace, l - 1, from - 1, {
							end_col = to,
							hl_group = hl_group,
						})
					end
					from = to and to + 1 or nil
				end
			end
		end
	end
end

vim.lsp.handlers[methods.textDocument_hover] = enhanced_float_handler(vim.lsp.handlers.hover)
vim.lsp.handlers[methods.textDocument_signatureHelp] = enhanced_float_handler(vim.lsp.handlers.signature_help)

local on_attach = function(client, bufnr)
	mapBuf(bufnr, "n", "<Leader>gdc", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
	mapBuf(bufnr, "n", "<Leader>gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
	mapBuf(bufnr, "n", "<Leader>gh", "<Cmd>lua vim.lsp.buf.hover()<CR>")
	mapBuf(bufnr, "n", "<Leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
	mapBuf(bufnr, "n", "<Leader>gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
	mapBuf(bufnr, "n", "<Leader>gtd", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
	mapBuf(bufnr, "n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
	mapBuf(bufnr, "n", "<Leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>")
	mapBuf(bufnr, "n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
	-- mapBuf(bufnr, "n", "<Leader>ca", "<cmd> lua require('mh.telescope').code_actions()<cr>")
	mapBuf(bufnr, "v", "<Leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>")
	mapBuf(bufnr, "n", "<Leader>sd", "<cmd>lua vim.diagnostic.open_float(0, { scope = 'line' })<CR>")
	-- autocmd("CursorHold", "<buffer>", "lua vim.diagnostic.show_position_diagnostics({focusable=false})")

	-- vim.bo.omnifunc = "noselect" --v:lua.vim.lsp.omnifunc"

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
end
local servers = { "pylsp", "bashls", "sourcekit", "html", "cssls", "vimls", "svelte" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end
lspconfig.sourcekit.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
lspconfig.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		preferences = {
			importModuleSpecifierPreference = "relative",
		},
	},
})
configs.emmet_ls = {
	default_config = {
		cmd = { "emmet-ls", "--stdio" },
		filetypes = { "html", "css", "scss" },
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

local lua_lsp_loc = "/Users/mhartington/Github/lua-language-server"
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

local ngls_cmd = {
	"ngserver",
	"--stdio",
	"--tsProbeLocations",
	default_node_modules,
	"--ngProbeLocations",
	default_node_modules,
	-- "--includeCompletionsWithSnippetText",
	-- "--includeAutomaticOptionalChainCompletions",
	-- "--logToConsole",
	-- "--logFile",
	-- "/Users/mhartington/Github/StarTrack-ng/logs.txt"
}
lspconfig.angularls.setup({
	cmd = ngls_cmd,
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = util.root_pattern("angular.json"),
	on_new_config = function(new_config)
		new_config.cmd = ngls_cmd
	end,
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

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.lua_ls.setup({
	-- cmd = {lua_lsp_loc .. "/bin/macOS/lua-language-server", "-E", lua_lsp_loc .. "/main.lua"},
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT", path = runtime_path },
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				-- maxPreload = 2000,
				-- preloadFileSize = 1000
			},
			-- workspace = {
			--   -- Make the server aware of Neovim runtime files
			--   library = {
			--     [vim.fn.expand "$VIMRUNTIME/lua"] = true,
			--     [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true
			--   }
			-- }
		},
	},
})
return M
