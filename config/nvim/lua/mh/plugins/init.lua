local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
	"nvim-lua/plenary.nvim",
	"Raimondi/delimitMate",
	"tpope/vim-repeat",
	"tpope/vim-surround",

	-- Utils
	"junegunn/vim-easy-align",
	"mg979/vim-visual-multi",

	-- FileTree
	"Xuyuanp/yanil",

	{ "folke/trouble.nvim", config = true },
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("ibl").setup({
				indent = { char = "│" },
				scope = { enabled = false },
				whitespace = { remove_blankline_trail = false },
				exclude = {
					buftypes = { "terminal", "nofile", "quickfix", "prompt" },
					filetypes = { "help", "startify", "dashboard", "packer", "Yanil" },
				},
			})
		end,
	},

	-- Code Comments
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				pre_hook = function(ctx)
					if vim.bo.filetype == "typescriptreact" then
						local U = require("Comment.utils")
						local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"
						local location = nil
						if ctx.ctype == U.ctype.block then
							location = require("ts_context_commentstring.utils").get_cursor_location()
						elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
							location = require("ts_context_commentstring.utils").get_visual_start_location()
						end

						return require("ts_context_commentstring.internal").calculate_commentstring({
							key = type,
							location = location,
						})
					end
				end,
			})
		end,
	},
	"JoosepAlviste/nvim-ts-context-commentstring",

	-- {
	-- UI Stuff
	"nvim-lualine/lualine.nvim",
	"akinsho/bufferline.nvim",
	"folke/zen-mode.nvim",
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	-- ColorScheme
	{ "Khaledgarbaya/night-owl-vim-theme", lazy = true },
	{ "bluz71/vim-nightfly-guicolors", lazy = true },
	{ "maxmx03/FluoroMachine.nvim", lazy = true },

	-- GIT
	{ "NeogitOrg/neogit", config = true, dependencies = {
		"sindrets/diffview.nvim",
	} },
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				debug_mode = false,
				signs = {
					-- add = { hl = "GitGutterAdd", text = "│" },
					-- change = { hl = "GitGutterChange", text = "│" },
					-- delete = { hl = "GitGutterDelete", text = "_" },
					-- topdelete = { hl = "GitGutterDelete", text = "‾" },
					-- changedelete = { hl = "GitGutterChangeDelete", text = "~" },
					add = { hl = "GitGutterAdd", text = "▍" },
					change = { hl = "GitGutterChange", text = "▍" },
					delete = { hl = "GitGutterDelete", text = "▍" },
					topdelete = { hl = "GitGutterDelete", text = "▍" },
					changedelete = { hl = "GitGutterChangeDelete", text = "▍" },
          --  ▍
				},
			})
		end,
	},
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	-- "sgeb/vim-diff-fold",
	{ "pwntester/octo.nvim", config = true },

	"tmux-plugins/vim-tmux",
	"christoomey/vim-tmux-navigator",

	-- Markdown
	{ "tpope/vim-markdown", ft = "markdown" },
	-- { "nelstrom/vim-markdown-folding", ft = "markdown" },
	"dhruvasagar/vim-table-mode",
	{ "iamcco/markdown-preview.nvim", build = "cd app && yarn install" },

	-- "rust-lang/rust.vim",
	-- "racer-rust/vim-racer",

	-- { "tmhedberg/SimpylFold", ft = "python" },

	-- "othree/yajs.vim",
	-- "MaxMEllon/vim-jsx-pretty",
	-- "elzr/vim-json",
	-- "neoclide/jsonc.vim",
	"antonk52/vim-browserslist",

	-- "othree/html5.vim",
	"mattn/emmet-vim",
	-- "posva/vim-vue",
	-- "leafOfTree/vim-svelte-plugin",
	-- "skwp/vim-html-escape",
	-- { "kana/vim-textobj-user", dependencies = {
	-- 	"whatyouhide/vim-textobj-xmlattr",
	-- } },
	-- "pedrohdz/vim-yaml-folds",
	-- "hail2u/vim-css3-syntax",

	-- Swift/
	"keith/swift.vim",
	"wojciech-kulik/xcodebuild.nvim",
	"tbastos/vim-lua",

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"f3fora/cmp-spell",
			"onsails/lspkind.nvim",
		},
	},
	{ "nvim-treesitter/nvim-treesitter" },
	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "Fildo7525/pretty_hover", event = "LspAttach", opts = {} },
		},
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-github.nvim",
			"nvim-telescope/telescope-node-modules.nvim",
			"nvim-telescope/telescope-fzy-native.nvim",
		},
	},
	{ "nvim-tree/nvim-web-devicons" },
	-- {
	--  "stevearc/dressing.nvim",
	--  config = function()
	--    require("dressing").setup({
	--      input = {
	--        enabled = true,
	--        default_prompt = "Input:",
	--        prompt_align = "left",
	--        insert_only = true,
	--        relative = "cursor",
	--        prefer_width = 40,
	--        width = nil,
	--        max_width = { 140, 0.9 },
	--        min_width = { 20, 0.2 },
	--        win_options = { },
	--        override = function(conf)
	--          return conf
	--        end,
	--        get_config = nil,
	--      },
	--      select = {
	--        enabled = true,
	--        backend = { 'builtin' },
	--        trim_prompt = true,
	--        -- builtin = {
	--        --   -- These are passed to nvim_open_win
	--        --   anchor = "NW",
	--        --   border = "rounded",
	--        --   -- 'editor' and 'win' will default to being centered
	--        --   relative = "cursor",
	--        --   -- Window transparency (0-100)
	--        --   win_options = {
	--        --     winblend = 0,
	--        --     -- Change default highlight groups (see :help winhl)
	--        --     winhighlight = "Normal:Normal",
	--        --   },
	--        --   -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
	--        --   -- the min_ and max_ options can be a list of mixed types.
	--        --   -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
	--        --   width = nil,
	--        --   max_width = { 140, 0.8 },
	--        --   min_width = { 40, 0.2 },
	--        --   height = nil,
	--        --   max_height = 0.9,
	--        --   min_height = { 5, 0.2 },
	--        --   override = function(conf)
	--        --     -- This is the config that will be passed to nvim_open_win.
	--        --     -- Change values here to customize the layout
	--        --     return conf
	--        --   end,
	--        -- },
	--        -- Used to override format_item. See :help dressing-format
	--        format_item_override = {},
	--        -- see :help dressing_get_config
	--        get_config = nil,
	--      },
	--    })
	--  end,
	-- },

	-- Local stuff
	{ dir = "~/GitHub/mhartington/formatter.nvim" },
	{ dir = "~/GitHub/mhartington/vim-folds" },
	{ dir = "~/GitHub/mhartington/oceanic-next" },
}, {

	ui = { 
      -- border = "rounded" 
    },
})
