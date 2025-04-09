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

local local_pkgs = {
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
}

return require("lazy").setup({
  { "nvim-lua/plenary.nvim" },
  { "nvim-treesitter/nvim-treesitter" },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },

  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = false },
      statuscolumn = { enabled = true, right = { "git" } },
      dim = { animate = { enabled = false } },
      zen = { enabled = false },
      notifier = { enabled = true, style = "minimal", top_down = false },
      picker = {
        ui_select = true,
        layout = {
          layout = {
            backdrop = false,
            row = 2,
            width = 0.4,
            min_width = 80,
            height = 0.8,
            border = "none",
            box = "vertical",
          },
        },
        formatters = {
          file = {
            filename_first = true,
            truncate = 80,
          },
        },
        sources = {
          select = {
            layout = {
              layout = {
                backdrop = false,
                row = 2,
                width = 120,
                min_width = 80,
                height = 0.8,
                border = "none",
                box = "vertical",
                {
                  win = "input",
                  height = 1,
                  row = 1,
                  border = "single",
                  title = "{title} {live} {flags}",
                  title_pos = "left",
                },
                { win = "list", border = "single", height=5 },
              },
            },

          },
          colorschemes = {
            prompt = "󱥚 ",
            layout = {
              preview = true,
              layout = {
                backdrop = false,
                row = 1,
                width = 0.4,
                min_width = 80,
                height = 0.8,
                border = "none",
                box = "vertical",
                {
                  win = "input",
                  height = 1,
                  border = "single",
                  title = "{title} {live} {flags}",
                  title_pos = "center",
                },
                { win = "list", border = "single" },
                { win = "preview", title = "{preview}", border = "single" },
              },
            },
          },
          files = {
            prompt = "󰍉 ",
            layout = {
              layout = {
                backdrop = false,
                row = 2,
                width = 120,
                min_width = 80,
                height = 0.8,
                border = "none",
                box = "vertical",
                {
                  win = "input",
                  height = 1,
                  row = 1,
                  border = "single",
                  title = "{title} {live} {flags}",
                  title_pos = "left",
                },
                { win = "list", border = "single" },
              },
            },
          },
          grep = {
            prompt = "󰐰 ",
            layout = {
              preview = true,
              layout = {
                backdrop = false,
                row = 2,
                width = 120,
                min_width = 80,
                height = 0.8,
                border = "none",
                box = "vertical",
                title="",
                  {
                    win = "input",
                    height = 1,
                    row = 1,
                    border = "single",
                    title = "{title} {live} {flags}",
                    title_pos = "center",
                  },
                  {
                    box = "horizontal",
                    { win = "list", border = "single" },
                    { win = "preview", title = "{preview}", border = "single", width = 0.5, minimal=true },
                  },
              },
            },
          },
          lsp_references = {
            prompt = " ",
            layout = {
              preview = true,
              layout = {
                backdrop = false,
                row = 2,
                width = 150,
                min_width = 80,
                height = 0.8,
                border = "none",
                box = "vertical",
                title="",
                  {
                    win = "input",
                    height = 1,
                    row = 1,
                    border = "single",
                    title = "{title} {live} {flags}",
                    title_pos = "center",
                  },
                  {
                    box = "horizontal",
                    { win = "list", border = "single" },
                    { win = "preview", title = "{preview}", border = "single", width = 0.5, minimal=true },
                  },
              },
            },
          },
        },
      },
      words = { enabled = false },
      indent = {
        scope = { enabled = false },
        char = "│",
      },
      input = { enabled = true },
    },
  },
  { "folke/todo-comments.nvim", config = true },
  -- Utils
  { "junegunn/vim-easy-align" },
  { "mg979/vim-visual-multi" },
  {
    "OXY2DEV/helpview.nvim",
    lazy = false,
  },

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
  { "scajanus/jbeans" },
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

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  { "christoomey/vim-tmux-navigator" },
  -- Markdown
  { "dhruvasagar/vim-table-mode" },
  { "iamcco/markdown-preview.nvim", build = "cd app && yarn install" },
  {
    "davidmh/mdx.nvim",
    config = true,
  },
  {
    "tigion/nvim-asciidoc-preview",
    ft = { "asciidoc" },
    build = "cd server && npm install --omit=dev",
    opts = {
      -- Add user configuration here
    },
  },
  { "antonk52/vim-browserslist" },

  -- Swift/
  -- { "wojciech-kulik/xcodebuild.nvim", config = true },
  -- Rust
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  -- Completion
  {
    "saghen/blink.cmp",
    dependencies = {
      { "rafamadriz/friendly-snippets" },
      { "Kaiser-Yang/blink-cmp-git" },
      { "Kaiser-Yang/blink-cmp-dictionary" },
    },
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = "super-tab" },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        ghost_text = { enabled = true },
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
        trigger = {
          show_on_trigger_character = true,
        },
        documentation = { auto_show = true, window = { border = "bold" } },
        menu = {
          draw = {
            padding = 0,
            columns = { { "kind_icon", gap = 1 }, { gap = 1, "label" }, { "kind", gap = 2 } },
            components = {
              kind_icon = {
                text = function(ctx)
                  return " " .. ctx.kind_icon .. " "
                end,
                highlight = function(ctx)
                  return { { group = "BlinkCmpKindIcon" .. ctx.kind, priority = 50000 } }
                end,
              },
              kind = {
                text = function(ctx)
                  return " " .. ctx.kind .. " "
                end,
              },
            },
          },
        },
      },
      sources = {
        default = { "git", "dictionary", "lsp", "path", "snippets", "buffer" },
        providers = {
          git = {
            module = "blink-cmp-git",
            name = "Git",
            enabled = function()
              return vim.tbl_contains({ "octo", "gitcommit", "markdown" }, vim.bo.filetype)
            end,
            opts = {},
          },
          dictionary = {
            module = "blink-cmp-dictionary",
            name = "Dict",
            min_keyword_length = 3,
            opts = {},
          },
        },
      },
      fuzzy = { implementation = "prefer_rust" },
    },
    opts_extend = { "sources.default" },
  },

  -- {
  --   "iguanacucumber/magazine.nvim",
  --   name = "nvim-cmp",
  --   dependencies = {
  --     { "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
  --     { "L3MON4D3/LuaSnip" },
  --     { "rafamadriz/friendly-snippets" },
  --     { "saadparwaiz1/cmp_luasnip" },
  --     { "hrsh7th/cmp-nvim-lsp-signature-help" },
  --     { "f3fora/cmp-spell" },
  --     { "onsails/lspkind.nvim" },
  --   },
  -- },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
      { "windwp/nvim-ts-autotag" },
      { "yioneko/nvim-vtsls" },
    },
  },

  -- Telescope
  { "nvim-telescope/telescope.nvim" },
  -- { "MunifTanjim/nui.nvim" },
  { "nvim-tree/nvim-web-devicons" },
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
  local_pkgs,
}, {

  ui = {
    border = "bold",
    backdrop = 100,
  },
})
