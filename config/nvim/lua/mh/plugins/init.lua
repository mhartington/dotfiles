local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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
  { "nvim-lua/plenary.nvim" },
  { "nvim-treesitter/nvim-treesitter" },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },

  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      statuscolumn = { enabled = true, right = { "git" } },
      dim={animate={enabled=false}},
      zen = { enabled = true },
      notifier = { enabled = true },
      picker = {
        ui_select = false,
        sources = {
          files = {
            layout = "vscode",
          },
          colorschemes = {
            layout = {
              preview = true,
              layout = {
                backdrop = false,
                row = 1,
                width = 0.4,
                min_width = 80,
                height = 0.4,
                border = "none",
                box = "vertical",
                {
                  win = "input",
                  height = 1,
                  border = "rounded",
                  title = "{title} {live} {flags}",
                  title_pos = "center",
                },
                { win = "list", border = "hpad" },
                { win = "preview", title = "{preview}", border = "rounded" },
              },
            },
          },
        },
      },
      words = { enabled = true },
      indent = {
        scope = { enabled = false },
        char = "│",
      },
    },
  },

  -- Utils
  { "junegunn/vim-easy-align" },
  { "mg979/vim-visual-multi" },

  -- FileTree
  { "folke/trouble.nvim", config = true },

  {
    "bezhermoso/tree-sitter-ghostty",
    build = "make nvim_install",
  },

  -- Code Comments
  { "JoosepAlviste/nvim-ts-context-commentstring" },
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

  -- {
  -- UI Stuff
  { "nvim-lualine/lualine.nvim" },
  { "akinsho/bufferline.nvim" },
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "virtual",
        virtual_symbol = "■",
        enable_named_colors = true,
      })
    end,
  },

  -- ColorScheme
  { "clearaspect/onehalf" },
  { "Khaledgarbaya/night-owl-vim-theme" },
  { "bluz71/vim-nightfly-colors" },
  { "maxmx03/FluoroMachine.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
  { "EdenEast/nightfox.nvim" },
  -- GIT
  {
    "NeogitOrg/neogit",
    config = true,
    opts = {
      kind = "replace",
    },
  },
  { "sindrets/diffview.nvim" },
  {
    "lewis6991/gitsigns.nvim",
    config = true,
    opts = {
      signs = {
        add = { text = "▍" },
        change = { text = "▍" },
        delete = { text = "▍" },
        topdelete = { text = "▍" },
        changedelete = { text = "▍" },
      },
    },
  },

  { "christoomey/vim-tmux-navigator" },
  -- Markdown
  { "dhruvasagar/vim-table-mode" },
  { "iamcco/markdown-preview.nvim", build = "cd app && yarn install" },
  { "antonk52/vim-browserslist" },

  -- Swift/
  { "wojciech-kulik/xcodebuild.nvim", config = true },

  -- Completion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-nvim-lsp-signature-help" },
  { "f3fora/cmp-spell" },
  { "onsails/lspkind.nvim" },

  -- LSP
  { "neovim/nvim-lspconfig" },
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
  { "windwp/nvim-ts-autotag" },
  { "yioneko/nvim-vtsls" },

  -- Telescope
  { "nvim-telescope/telescope.nvim" },
  { "MunifTanjim/nui.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup({
        input = {
          enabled = true,
          default_prompt = "Input:",
          prompt_align = "left",
          insert_only = true,
          relative = "cursor",
          prefer_width = 40,
          width = nil,
          max_width = { 140, 0.9 },
          min_width = { 20, 0.2 },
          win_options = {},
          override = function(conf)
            return conf
          end,
          get_config = nil,
        },
        select = {
          enabled = true,
          backend = { "builtin" },
          trim_prompt = true,
          builtin = {
            border = "rounded",
            relative = "cursor",
            win_options = {
              cursorline = false,
              cursorlineopt = "both",
              statuscolumn = "",
            },
            width = nil,
            max_width = { 140, 0.8 },
            min_width = { 40, 0.2 },
            height = nil,
            max_height = 0.9,
            min_height = { 5, 0.2 },
            override = function(conf)
              -- print(vim.inspect(conf))
              conf.anchor = "NW"

              return conf
            end,
          },
        },
      })
    end,
  },
  {
    "Equilibris/nx.nvim",
    config = true,
    opts = {
      nx_cmd_root = "npx nx",
    },
    keys = {
      { "<leader>nx", "<cmd>Telescope nx actions<CR>", desc = "nx actions" },
    },
  },
  -- Local stuff
  { dir = "~/GitHub/mhartington/formatter.nvim" },
  { dir = "~/GitHub/mhartington/yanil" },
  { dir = "~/GitHub/mhartington/tree-sitter-analog" },
  {
    dir = "~/GitHub/mhartington/oceanic-next",
    config = function()
      vim.opt.background = "dark"
      vim.cmd.colorscheme("OceanicNext")
    end,
  },
}, {

  ui = {
    border = "rounded",
    backdrop = 100,
  },
})
