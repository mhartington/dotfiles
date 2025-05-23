local vim = vim
local formatter = require("formatter")
local util = require("formatter.util")

local prettierConfig = function()
	return {
		exe = "prettier",
		args = { "--stdin-filepath", util.escape_path(util.get_current_buffer_file_path()), "--single-quote" },
		stdin = true,
	}
end
-- local biomeConfig = function()
-- 	return {
-- 		exe = "biome",
-- 		args = { "format", "--stdin-file-path", util.escape_path(util.get_current_buffer_file_path()) },
-- 		stdin = true,
-- 	}
-- end

local formatterConfig = {
	lua = {
		function()
			return {
				exe = "stylua",
				args = { "-" },
				stdin = true,
			}
		end,
		-- function()
		--   return {
		--     exe = "luafmt",
		--     args = {"--indent-count", 2, "--stdin"},
		--     stdin = true
		--   }
		-- end
	},
	vue = {
		function()
			return {
				exe = "prettier",
				args = {
					"--stdin-filepath",
					vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
					"--single-quote",
					"--parser",
					"vue",
				},
				stdin = true,
			}
		end,
	},
	rust = {
		-- Rustfmt
		function()
			return {
				exe = "rustfmt",
				args = { "--emit=stdout" },
				stdin = true,
			}
		end,
	},
	swift = {
		-- Swiftlint
		function()
			return {
				exe = "swift-format",
				args = { vim.api.nvim_buf_get_name(0) },
				stdin = true,
			}
		end,
	},
	r = {
		function()
			return {
				exe = "R",
				args = {
					"--slave",
					"--no-restore",
					"--no-save",
					"-e",
					"'con <- file(\"stdin\"); styler::style_text(readLines(con)); close(con)'",
					"2>/dev/null",
				},
				stdin = true,
			}
		end,
	},
	dart = {
		function()
			return {
				exe = "dart",
				args = {
					"format",
				},
				stdin = true,
			}
		end,
	},
	cs = {
		function()
			return {
				exe = "dotnet",
				args = {
					"format",
					"whitespace",
					"--include",
				},
				no_append = true,
				ignore_exitcode = true,
				stdin = false,
			}
		end,
	},
  java = {
    require("formatter.filetypes.java").clangformat()
  },
	["*"] = {
		require("formatter.filetypes.any").substitute_trailing_whitespace(),
	},

}
local commonFT = {
	"css",
	"scss",
	"html",
	"angular.html",
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
	"markdown",
	"markdown.mdx",
	"json",
	"jsonc",
	"yaml",
	"xml",
	"svg",
	"svelte",
}
for _, ft in ipairs(commonFT) do
	formatterConfig[ft] = {
		prettierConfig,
		-- biomeConfig
	}
end
-- Setup functions
formatter.setup({
	logging = true,
	filetype = formatterConfig,
	log_level = 2,
})
