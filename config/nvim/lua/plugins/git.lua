return {
  { "NeogitOrg/neogit", opts = { kind = "replace" } },
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
}
