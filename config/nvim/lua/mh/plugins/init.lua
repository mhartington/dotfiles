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

-- { "nvim-telescope/telescope.nvim" },
-- { "Equilibris/nx.nvim", opts = { nx_cmd_root = "npx nx", }, keys = { { "<leader>nx", "<cmd>Telescope nx actions<CR>", desc = "nx actions" }, }, },
return require("lazy").setup({
  spec = { { import = "plugins" }, },
  ui = {
    icons = {
      cmd = " ",
      config = "",
      debug = "● ",
      event = " ",
      favorite = " ",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = " ",
      runtime = " ",
      require = "󰢱 ",
      source = " ",
      start = " ",
      task = "✔ ",
      list = { "●", "➜", "★", "‒", },
    },
    border = "bold",
    backdrop = 100,
  },
})
