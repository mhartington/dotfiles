return {

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
  --   config = function()
  --
  --     local cmp = require("cmp")
  --     local lspkind = require("lspkind")
  --     local types = require('cmp.types')
  --     local luasnip = require("luasnip")
  --     require("luasnip.loaders.from_vscode").lazy_load()
  --     cmp.setup({
  --       experimental = { ghost_text = true },
  --       completion = {
  --         completeopt = "menu,menuone,noinsert",
  --       },
  --       snippet = {
  --         expand = function(args)
  --           luasnip.lsp_expand(args.body)
  --         end,
  --       },
  --       mapping = {
  --         ["<Tab>"] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             -- local entry = cmp.get_active_entry()
  --             -- if not entry then
  --             --   fallback()
  --             -- else
  --             cmp.confirm({
  --               behavior = cmp.ConfirmBehavior.Insert,
  --               select = true,
  --             })
  --           -- end
  --           else
  --             fallback()
  --           end
  --         end),
  --         ["<CR>"] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             -- local entry = cmp.get_active_entry()
  --             -- if not entry then
  --             --   fallback()
  --             -- else
  --             cmp.confirm({
  --               behavior = cmp.ConfirmBehavior.Insert,
  --               select = true,
  --             })
  --           -- end
  --           else
  --             fallback()
  --           end
  --         end),
  --         ["<C-n>"] = cmp.mapping({
  --           c = function()
  --             if cmp.visible() then
  --               cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
  --             else
  --               vim.api.nvim_feedkeys(t("<Down>"), "n", true)
  --             end
  --           end,
  --           i = function(fallback)
  --             if cmp.visible() then
  --               cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
  --             else
  --               fallback()
  --             end
  --           end,
  --         }),
  --         ["<C-p>"] = cmp.mapping({
  --           c = function()
  --             if cmp.visible() then
  --               cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
  --             else
  --               vim.api.nvim_feedkeys(t("<Up>"), "n", true)
  --             end
  --           end,
  --           i = function(fallback)
  --             if cmp.visible() then
  --               cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
  --             else
  --               fallback()
  --             end
  --           end,
  --         }),
  --       },
  --       formatting = {
  --         fields = { "kind", "abbr", "menu" },
  --         format = function(entry, vim_item)
  --           local kind = lspkind.cmp_format({ preset = "codicons", maxwidth = 50 })(entry, vim_item)
  --
  --           local strings = vim.split(kind.kind, "%s", { trimempty = true })
  --           kind.kind = " " .. (strings[1] or "") .. " "
  --           kind.menu = "    " .. (strings[2] or "")
  --           return kind
  --         end,
  --       },
  --       sources = {
  --         { name = "nvim_lsp" },
  --         { name = "luasnip" },
  --         { name = "spell" },
  --         { name = "nvim_lsp_signature_help" },
  --       },
  --       window = {
  --         completion = {
  --           winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
  --           col_offset = -3,
  --           side_padding = 0,
  --         },
  --         documentation = {
  --           border = "rounded",
  --           side_padding = 2,
  --           winhighlight = "Normal:CmpDocumentation,FloatBorder:CmpDocumentationBorder,CursorLine:Visual,Search:None",
  --         },
  --       },
  --     })
  --   end,
  -- },

  {
    "saghen/blink.cmp",
    dependencies = {
      { "rafamadriz/friendly-snippets" },
      { "Kaiser-Yang/blink-cmp-git" },
      { "Kaiser-Yang/blink-cmp-dictionary" },
      { "giuxtaposition/blink-cmp-copilot" },
    },
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "super-tab",
        ["<CR>"] = { "accept", "fallback" },
      },
      appearance = { nerd_font_variant = "mono" },
      signature = { enabled = true },
      completion = {
        ghost_text = { enabled = true },
        list = { selection = { preselect = true, auto_insert = false } },
        trigger = { show_on_trigger_character = true },
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
        default = { "lsp", "git", "dictionary", "path", "snippets", "buffer" },
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
          -- copilot = {
          --   name = "copilot",
          --   module = "blink-cmp-copilot",
          --   score_offset = 100,
          --   async = false,
          -- },
        },
      },
      fuzzy = { implementation = "prefer_rust" },
    },
    opts_extend = { "sources.default" },
  },

  { "zbirenbaum/copilot.lua", config = true },
  {
    "olimorris/codecompanion.nvim",
    opts = {
      strategies = {
        chat = { adapter = "copilot" },
        inline = { adapter = "copilot" },
        cmd = { adapter = "copilot" },
      },
    },
  },
}
