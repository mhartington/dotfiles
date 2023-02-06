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
    "wbthomason/packer.nvim",
    "Raimondi/delimitMate",
    "tpope/vim-repeat",
    "tpope/vim-unimpaired",
    "AndrewRadev/switch.vim",
    "christoomey/vim-tmux-navigator",
    "tpope/vim-surround",
    {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup(
          {
            pre_hook = function(ctx)
              -- Only calculate commentstring for tsx filetypes
              if vim.bo.filetype == "typescriptreact" then
                local U = require("Comment.utils")

                -- Detemine whether to use linewise or blockwise commentstring
                local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"

                -- Determine the location where to calculate commentstring from
                local location = nil
                if ctx.ctype == U.ctype.block then
                  location = require("ts_context_commentstring.utils").get_cursor_location()
                elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                  location = require("ts_context_commentstring.utils").get_visual_start_location()
                end

                return require("ts_context_commentstring.internal").calculate_commentstring(
                  {
                    key = type,
                    location = location
                  }
                )
              end
            end
          }
        )
      end
    },
    "JoosepAlviste/nvim-ts-context-commentstring",
    "junegunn/vim-easy-align",
    "junegunn/goyo.vim",
    "tmux-plugins/vim-tmux",
    "mg979/vim-visual-multi",
    "Xuyuanp/yanil",
    "kyazdani42/nvim-tree.lua",
    {
      "luukvbaal/stabilize.nvim",
      config = function()
        require("stabilize").setup()
      end
    },
    {
      "folke/trouble.nvim",
      config = function()
        require("trouble").setup {}
      end
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("indent_blankline").setup {
           show_end_of_line = true,
           space_char_blankline = " ",
           -- char = "¦",
           show_trailing_blankline_indent = false,
           buftype_exclude = {"terminal", "nofile", "quickfix", "prompt"},
           filetype_exclude = {"help", "startify", "dashboard", "packer", "Yanil"},
        }
        -- vim.g.indent_blankline_buftype_exclude = {"terminal"}
        -- vim.g.indent_blankline_filetype_exclude = {"help", "startify", "dashboard", "packer", "Yanil"}
        -- vim.g.indent_blankline_char = "¦"
        -- vim.g.indent_blankline_use_treesitter = true
        -- vim.g.indent_blankline_show_current_context = false
        -- vim.g.indent_blankline_show_trailing_blankline_indent = false
      end
    },
    "nvim-lualine/lualine.nvim",
    "akinsho/bufferline.nvim",
    "Pocco81/true-zen.nvim",
    {
      "catppuccin/nvim",
      config = function()
        local catppuccin = require("catppuccin")
        catppuccin.setup {
          {
            colorscheme = "dark_catppuccino",
            transparency = false,
            term_colors = false,
            styles = {
              comments = "italic",
              functions = "italic",
              keywords = "italic",
              strings = "NONE",
              variables = "NONE"
            },
            integrations = {
              treesitter = true,
              native_lsp = {
                enabled = true,
                virtual_text = {
                  errors = "italic",
                  hints = "italic",
                  warnings = "italic",
                  information = "italic"
                },
                underlines = {
                  errors = "underline",
                  hints = "underline",
                  warnings = "underline",
                  information = "underline"
                }
              },
              lsp_trouble = false,
              lsp_saga = false,
              gitgutter = false,
              gitsigns = false,
              telescope = false,
              nvimtree = {
                enabled = true,
                show_root = true
              },
              which_key = false,
              indent_blankline = {
                enabled = false,
                colored_indent_levels = false
              },
              dashboard = false,
              neogit = false,
              vim_sneak = false,
              fern = false,
              barbar = false,
              bufferline = false,
              markdown = false,
              lightspeed = false,
              ts_rainbow = false,
              hop = false
            }
          }
        }
      end
    },
    "morhetz/gruvbox",
    "rose-pine/neovim",
    "patstockwell/vim-monokai-tasty",
    "arzg/vim-colors-xcode",
    "chuling/vim-equinusocio-material",
    "romgrk/github-light.vim",
    "Khaledgarbaya/night-owl-vim-theme",
    "kenwheeler/glow-in-the-dark-gucci-shark-bites-vim",
    "TroyFletcher/vim-colors-synthwave",
    "bluz71/vim-nightfly-guicolors",
    "gpanders/editorconfig.nvim",
    {
      "max397574/colortils.nvim",
      cmd = "Colortils",
      config = function()
        require("colortils").setup()
      end,
    },
    {
      "lewis6991/gitsigns.nvim",
      config = function()
        require "gitsigns".setup {
          debug_mode = false,
          signs = {
            add = {hl = "GitGutterAdd", text = "│"},
            change = {hl = "GitGutterChange", text = "│"},
            delete = {hl = "GitGutterDelete", text = "_"},
            topdelete = {hl = "GitGutterDelete", text = "‾"},
            changedelete = {hl = "GitGutterChangeDelete", text = "~"}
          }
        }
      end
    },
    {
      "pwntester/octo.nvim",
      config = function()
        require "octo".setup()
      end
    },
    "maxmx03/FluoroMachine.nvim",
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "sgeb/vim-diff-fold",
    "TimUntersberger/neogit",
    'sindrets/diffview.nvim',
    {"tpope/vim-markdown", ft = "markdown"},
    "rhysd/vim-grammarous",
    {"nelstrom/vim-markdown-folding", ft = "markdown"},
    "dhruvasagar/vim-table-mode",
    {
      "iamcco/markdown-preview.nvim",
      build = "cd app && yarn install"
    },
    "rust-lang/rust.vim",
    "racer-rust/vim-racer",
    {"tmhedberg/SimpylFold", ft = "python"},
    "othree/yajs.vim",
    "MaxMEllon/vim-jsx-pretty",
    "elzr/vim-json",
    "neoclide/jsonc.vim",
    "HerringtonDarkholme/yats.vim",
    "antonk52/vim-browserslist",
    "Quramy/vison",
    "jxnblk/vim-mdx-js",
    "othree/html5.vim",
    "mattn/emmet-vim",
    "posva/vim-vue",
    "leafOfTree/vim-svelte-plugin",
    "skwp/vim-html-escape",
    {"kana/vim-textobj-user", dependencies= {
      "whatyouhide/vim-textobj-xmlattr"
    }},
    "pedrohdz/vim-yaml-folds",
    "hail2u/vim-css3-syntax",
    { "norcalli/nvim-colorizer.lua", config = function() require "colorizer".setup() end },
    { "tami5/xbase", build = "make install" },
    "keith/swift.vim",
    "gfontenot/vim-xcode",
    "tbastos/vim-lua",

    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "f3fora/cmp-spell"
      },
    },
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/playground",
    "nyngwang/NeoClear.lua",
    "nvim-lua/lsp-status.nvim",
    "neovim/nvim-lspconfig",
    { "nvim-telescope/telescope.nvim", dependencies= {
      "nvim-telescope/telescope-github.nvim",
      "nvim-telescope/telescope-node-modules.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
    }},
    "kyazdani42/nvim-web-devicons",
    "dstein64/vim-startuptime",

    { dir="~/GitHub/mhartington/formatter.nvim"},
    { dir="~/GitHub/mhartington/vim-folds"},
    { dir="~/GitHub/mhartington/oceanic-next"},
})

