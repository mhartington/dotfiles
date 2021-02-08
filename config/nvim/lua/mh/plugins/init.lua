local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

return require "packer".startup(
  function(use)
    -- Packer can manage itself as an optional plugin
    use {"wbthomason/packer.nvim"}
    use {"Raimondi/delimitMate"}
    use {"tpope/vim-repeat"}
    use {"tpope/vim-unimpaired"}
    use {"AndrewRadev/switch.vim"}
    use {"christoomey/vim-tmux-navigator"}
    use {"tpope/vim-surround"}
    use {"tyru/caw.vim"}
    use {"junegunn/vim-easy-align"}
    use {"tmux-plugins/vim-tmux"}
    use {"Shougo/context_filetype.vim"}
    use {"mhinz/vim-sayonara"}
    use {"ojroques/nvim-bufdel"}
    use {"mg979/vim-visual-multi"}
    use {"MartinLafreniere/vim-PairTools"}
    use {"sjl/vitality.vim"}


    use {"kyazdani42/nvim-tree.lua"}

    use {"preservim/nerdtree"}
    use {"Xuyuanp/nerdtree-git-plugin"}
    use {"Xuyuanp/yanil"}

    use {"Yggdroot/indentLine"}
    use {"hoob3rt/lualine.nvim"}
    use {"akinsho/nvim-bufferline.lua"}

    -- Colors
    use {"morhetz/gruvbox"}
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
    use {"TimUntersberger/neogit"}
    -- -- Markdown
    use {"tpope/vim-markdown", ft = "markdown"}
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
    use {"heavenshell/vim-jsdoc"}
    use {"elzr/vim-json"}
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
    --
    use {"nvim-treesitter/nvim-treesitter"}
    use {"nvim-treesitter/nvim-treesitter-angular"}
    use {"nvim-treesitter/playground"}
    use {"nvim-lua/completion-nvim"}
    use {"hrsh7th/nvim-compe"}

    use {"Shougo/deoplete.nvim", run = "remote#host#UpdateRemotePlugins()"}
    use {"shougo/deoplete-lsp"}
    use {"neovim/nvim-lspconfig"}
    -- use {"hrsh7th/nvim-compe"}
    use {"glepnir/lspsaga.nvim"}
    --
    use {"nvim-lua/popup.nvim"}
    use {"nvim-lua/plenary.nvim"}
    use {"nvim-telescope/telescope.nvim"}
    use {"nvim-telescope/telescope-github.nvim"}
    use {"nvim-telescope/telescope-packer.nvim"}
    use {"nvim-telescope/telescope-node-modules.nvim"}
    --
    use {
      "kyazdani42/nvim-web-devicons",
      config = function()
        require "nvim-web-devicons".setup(
          {
            overrides = {
              git = {icon = ""},
              js = {icon = ""},
              vim = {icon = ""},
              css = {icon = ""},
              html = {icon = ""},
              json = {icon = ""},
              md = {icon = ""},
              sql = {icon = ""}
            }
          }
        )
      end
    }
  end
)
