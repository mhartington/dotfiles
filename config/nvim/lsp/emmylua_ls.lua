return {
  settings = {
    Lua = {
      runtime = {
        path = { "?.lua", "?/init.lua" },
        pathStrict = true,
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        ignoreDir = { "/lua" },
        library = {
          "/Users/mhartington/bin/nvim/share/nvim/runtime/lua",
          "${3rd}/luv/library",
          "/Users/mhartington/.local/share/nvim/lazy/nvim-lspconfig/lua",
          "/Users/mhartington/.local/share/nvim/lazy/blink.cmp/lua",
        },
      },
    },
  },
}
