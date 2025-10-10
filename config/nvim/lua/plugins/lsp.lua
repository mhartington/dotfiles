return {
  { "neovim/nvim-lspconfig" },
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        width = 0.8,
        height = 0.8,
        border = "bold",
        backdrop = 100,
      },
    },
  },
  { "mason-org/mason-lspconfig.nvim", opts = {} },
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
  { "windwp/nvim-ts-autotag" },
  { "yioneko/nvim-vtsls" },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
  },
}
