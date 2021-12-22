local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

return require "packer".startup(
  function(use)
    -- Packer can manage itself as an optional plugin
    use {"nvim-lua/popup.nvim"}
    use {"nvim-lua/plenary.nvim"}
    use {"wbthomason/packer.nvim"}
    use {"Raimondi/delimitMate"}
    use {"tpope/vim-repeat"}
    use {"tpope/vim-unimpaired"}
    use {"AndrewRadev/switch.vim"}
    use {"christoomey/vim-tmux-navigator"}
    use {"tpope/vim-surround"}
    use {
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
    }
    -- use {
    --   "terrortylor/nvim-comment",
    --   config = function()
    --     require("nvim_comment").setup(
    --       {
    --         hook = function()
    --           require("ts_context_commentstring.internal").update_commentstring()
    --         end
    --       }
    --     )
    --   end
    -- }
    use {"JoosepAlviste/nvim-ts-context-commentstring"}

    use {"junegunn/vim-easy-align"}
    use {"junegunn/goyo.vim"}
    use {"tmux-plugins/vim-tmux"}
    use {"mg979/vim-visual-multi"}
    use {"Xuyuanp/yanil"}
    use {"kyazdani42/nvim-tree.lua"}
    use {
      "luukvbaal/stabilize.nvim",
      config = function()
        require("stabilize").setup()
      end
    }
    use {
      "folke/trouble.nvim",
      config = function()
        require("trouble").setup {}
      end
    }
    use {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        vim.g.indent_blankline_buftype_exclude = {"terminal"}
        vim.g.indent_blankline_filetype_exclude = {"help", "startify", "dashboard", "packer", "Yanil"}
        vim.g.indent_blankline_char = "¦"
        vim.g.indent_blankline_use_treesitter = false
        vim.g.indent_blankline_show_current_context = false
        vim.g.indent_blankline_show_trailing_blankline_indent = false
      end
    }
    use {"nvim-lualine/lualine.nvim"}
    use {"akinsho/nvim-bufferline.lua"}

    -- Colors
    use {"morhetz/gruvbox"}
    use {
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
    }
    use {"rose-pine/neovim"}
    use {"patstockwell/vim-monokai-tasty"}
    use {"arzg/vim-colors-xcode"}
    use {"chuling/vim-equinusocio-material"}
    use {"romgrk/github-light.vim"}
    use {"Khaledgarbaya/night-owl-vim-theme"}
    use {"kenwheeler/glow-in-the-dark-gucci-shark-bites-vim"}
    use {"TroyFletcher/vim-colors-synthwave"}
    use {"bluz71/vim-nightfly-guicolors"}

    -- Editor Config
    use {"editorconfig/editorconfig-vim"}

    -- Git
    use {"tpope/vim-fugitive"}
    use {"tpope/vim-rhubarb"}
    use {"sgeb/vim-diff-fold"}
    use {
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
    }
    use {
      "pwntester/octo.nvim",
      config = function()
        require "octo".setup()
      end
    }
    use {"TimUntersberger/neogit"}

    -- -- Markdown
    use {"tpope/vim-markdown", ft = "markdown"}
    use {"rhysd/vim-grammarous"}
    use {"nelstrom/vim-markdown-folding", ft = "markdown"}
    use {"dhruvasagar/vim-table-mode"}
    use {
      "iamcco/markdown-preview.nvim",
      run = "cd app && yarn install"
    }
    -- Rust
    use {"rust-lang/rust.vim"}
    use {"racer-rust/vim-racer"}
    -- Python
    use {"tmhedberg/SimpylFold", ft = "python"}
    -- JS/TS
    use {"othree/yajs.vim"}
    use {"MaxMEllon/vim-jsx-pretty"}
    -- use {"heavenshell/vim-jsdoc"}
    use {"elzr/vim-json"}
    use {"neoclide/jsonc.vim"}
    use {"HerringtonDarkholme/yats.vim"}
    use {"Quramy/vison"}
    use {"jxnblk/vim-mdx-js"}
    -- HTML
    use {"othree/html5.vim"}
    use {"mattn/emmet-vim"}
    use {"posva/vim-vue"}
    use {"leafOfTree/vim-svelte-plugin"}
    use {"skwp/vim-html-escape"}
    use {"kana/vim-textobj-user"}
    use {"whatyouhide/vim-textobj-xmlattr"}
    use {"pedrohdz/vim-yaml-folds"}
    -- CSS
    use {"hail2u/vim-css3-syntax"}
    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require "colorizer".setup()
      end
    }
    -- Swift
    use {"keith/swift.vim"}
    use {"gfontenot/vim-xcode"}
    -- Reason
    -- use{ "reasonml-editor/vim-reason-plus" }
    -- Go
    -- use{ "fatih/vim-go" }
    -- Lua
    use {"tbastos/vim-lua"}

    -- -- Local
    use {"~/GitHub/mhartington/formatter.nvim"}
    use {"~/GitHub/mhartington/vim-folds"}
    use {"~/GitHub/mhartington/oceanic-next"}

    use {"nvim-treesitter/nvim-treesitter"}
    use {"nvim-treesitter/nvim-treesitter-angular"}
    use {"nvim-treesitter/playground"}

    use {
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "f3fora/cmp-spell"
      }
    }
    use {"simrat39/symbols-outline.nvim"}
    use {"nvim-lua/lsp-status.nvim"}

    use {"neovim/nvim-lspconfig"}
    use {"glepnir/lspsaga.nvim"}
    --
    use {"nvim-telescope/telescope.nvim"}
    use {"nvim-telescope/telescope-github.nvim"}
    use {"nvim-telescope/telescope-packer.nvim"}
    use {"nvim-telescope/telescope-node-modules.nvim"}
    use {"nvim-telescope/telescope-fzy-native.nvim"}

    use {"kyazdani42/nvim-web-devicons"}
    -- use {"yamatsum/nvim-nonicons"}
    use {"mjlbach/neovim-ui"}
    use {"MunifTanjim/nui.nvim"}
    -- use {
    --   "vuki656/package-info.nvim",
    --   requires = "MunifTanjim/nui.nvim",
    --   config = function()
    --     require("package-info").setup(
    --       {
    --         colors = {
    --           up_to_date = "#3C4048", -- Text color for up to date package virtual text
    --           outdated = "#d19a66" -- Text color for outdated package virtual text
    --         },
    --         icons = {
    --           enable = true, -- Whether to display icons
    --           style = {
    --             up_to_date = "|  ", -- Icon for up to date packages
    --             outdated = "|  " -- Icon for outdated packages
    --           }
    --         },
    --         autostart = true,
    --         hide_up_to_date = true,
    --         hide_unstable_versions = false
    --       }
    --     )
    --   end
    -- }
    use {"dstein64/vim-startuptime"}
  end
)
