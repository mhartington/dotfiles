-- local cmp = require("cmp")
-- local lspkind = require("lspkind")
-- local types = require('cmp.types')
-- local luasnip = require("luasnip")
-- require("luasnip.loaders.from_vscode").lazy_load()

local c = require("oceanic-next.config").colors
local darken = require("oceanic-next.utils").darken
local lighten = require("oceanic-next.utils").lighten


local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- cmp.setup({
--   experimental = { ghost_text = true },
--   completion = {
--     completeopt = 'menu,menuone,noinsert'
--   },
--   snippet = {
--     expand = function(args)
--       luasnip.lsp_expand(args.body)
--     end,
--   },
--   mapping = {
--     ["<Tab>"] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         -- local entry = cmp.get_active_entry()
--         -- if not entry then
--         --   fallback()
--         -- else
--           cmp.confirm({
--             behavior = cmp.ConfirmBehavior.Insert,
--             select = true,
--           })
--         -- end
--       else
--         fallback()
--       end
--     end),
--     ["<CR>"] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         -- local entry = cmp.get_active_entry()
--         -- if not entry then
--         --   fallback()
--         -- else
--           cmp.confirm({
--             behavior = cmp.ConfirmBehavior.Insert,
--             select = true,
--           })
--         -- end
--       else
--         fallback()
--       end
--     end),
--     ["<C-n>"] = cmp.mapping({
--       c = function()
--         if cmp.visible() then
--           cmp.select_next_item({behavior = cmp.SelectBehavior.Select })
--         else
--           vim.api.nvim_feedkeys(t("<Down>"), "n", true)
--         end
--       end,
--       i = function(fallback)
--         if cmp.visible() then
--           cmp.select_next_item({behavior = cmp.SelectBehavior.Select })
--         else
--           fallback()
--         end
--       end,
--     }),
--     ["<C-p>"] = cmp.mapping({
--       c = function()
--         if cmp.visible() then
--           cmp.select_prev_item({behavior = cmp.SelectBehavior.Select })
--         else
--           vim.api.nvim_feedkeys(t("<Up>"), "n", true)
--         end
--       end,
--       i = function(fallback)
--         if cmp.visible() then
--           cmp.select_prev_item({behavior = cmp.SelectBehavior.Select })
--         else
--           fallback()
--         end
--       end,
--     }),
--   },
--   formatting = {
--     fields = { "kind", "abbr", "menu" },
--     format = function(entry, vim_item)
--       local kind = lspkind.cmp_format({ preset = "codicons", maxwidth = 50 })(entry, vim_item)
--
--       local strings = vim.split(kind.kind, "%s", { trimempty = true })
--       kind.kind = " " .. (strings[1] or "") .. " "
--       kind.menu = "    " .. (strings[2] or "")
--       return kind
--     end,
--   },
--   sources = {
--     { name = "nvim_lsp" },
--     { name = "luasnip" },
--     { name = "spell" },
--     { name = "nvim_lsp_signature_help" },
--   },
--   window = {
--     completion = {
--       winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
--       col_offset = -3,
--       side_padding = 0,
--     },
--     documentation = {
--       border = "rounded",
--       side_padding = 2,
--       winhighlight = "Normal:CmpDocumentation,FloatBorder:CmpDocumentationBorder,CursorLine:Visual,Search:None",
--     },
--   },
-- })

vim.api.nvim_set_hl(0, "CmpDocumentation", { bg = darken(c.base00, 5) })
vim.api.nvim_set_hl(0, "CmpDocumentationBorder", { fg = c.base01, bg = darken(c.base00, 5) })
vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = c.base02, bg = "NONE", strikethrough = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = c.blue, bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = c.blue, bg = "NONE", bold = true })

vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = lighten(c.red, 100), bg = c.red })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = lighten(c.red, 100), bg = c.red })
vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = lighten(c.red, 100), bg = c.red })

vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = darken(c.green, 40), bg = c.green })
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = darken(c.green, 40), bg = c.green })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = darken(c.green, 40), bg = c.green })

vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = darken(c.yellow, 50), bg = c.yellow })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = darken(c.yellow, 50), bg = c.yellow })
vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = darken(c.yellow, 50), bg = c.yellow })
vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = darken(c.purple, 30), bg = c.purple })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = darken(c.purple, 30), bg = c.purple })
vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = darken(c.purple, 30), bg = c.purple })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = darken(c.purple, 30), bg = c.purple })
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = darken(c.purple, 30), bg = c.purple })

vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = lighten(c.base03, 100), bg = c.base03 })
vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = lighten(c.base03, 100), bg = c.base03 })

vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = darken(c.orange, 30), bg = c.orange })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = darken(c.orange, 30), bg = c.orange })
vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = darken(c.orange, 30), bg = c.orange })

vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = lighten(c.cyan, 100), bg = c.cyan })
vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = lighten(c.cyan, 100), bg = c.cyan })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = lighten(c.cyan, 100), bg = c.cyan })

vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = lighten(c.blue, 100), bg = c.blue })
vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = lighten(c.blue, 100), bg = c.blue })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = lighten(c.blue, 100), bg = c.blue })


-- BlinkCmp
vim.api.nvim_set_hl(0,'BlinkCmpMenuSelection', {bg=c.base02})
vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = darken(c.base00, 5) })
vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = c.base01, bg = darken(c.base00, 5) })
vim.api.nvim_set_hl(0, "BlinkCmpDocSeparator", { fg = c.base01, bg = darken(c.base00, 5) })

vim.api.nvim_set_hl(0, "BlinkCmpKindIconField", { fg = lighten(c.red, 100), bg = c.red })
vim.api.nvim_set_hl(0, "BlinkCmpKindIconProperty", { fg = lighten(c.red, 100), bg = c.red })
vim.api.nvim_set_hl(0, "BlinkCmpKindIconEvent", { fg = lighten(c.red, 100), bg = c.red })

vim.api.nvim_set_hl(0, "BlinkCmpKindIconText", { fg = darken(c.green, 40), bg = c.green })
vim.api.nvim_set_hl(0, "BlinkCmpKindIconEnum", { fg = darken(c.green, 40), bg = c.green })
vim.api.nvim_set_hl(0, "BlinkCmpKindIconKeyword", { fg = darken(c.green, 40), bg = c.green })

vim.api.nvim_set_hl(0, "BlinkCmpKindIconConstant", { fg = darken(c.yellow, 50), bg = c.yellow })
vim.api.nvim_set_hl(0, "BlinkCmpKindIconConstructor", { fg = darken(c.yellow, 50), bg = c.yellow })
vim.api.nvim_set_hl(0, "BlinkCmpKindIconReference", { fg = darken(c.yellow, 50), bg = c.yellow })
vim.api.nvim_set_hl(0, "BlinkCmpKindIconFunction", { fg = darken(c.purple, 30), bg = c.purple })
vim.api.nvim_set_hl(0, "BlinkCmpKindIconStruct", { fg = darken(c.purple, 30), bg = c.purple })
vim.api.nvim_set_hl(0, "BlinkCmpKindIconClass", { fg = darken(c.purple, 30), bg = c.purple })
vim.api.nvim_set_hl(0, "BlinkCmpKindIconModule", { fg = darken(c.purple, 30), bg = c.purple })
vim.api.nvim_set_hl(0, "BlinkCmpKindIconOperator", { fg = darken(c.purple, 30), bg = c.purple })

vim.api.nvim_set_hl(0, "BlinkCmpKindIconVariable", { fg = lighten(c.base03, 100), bg = c.base03 })
vim.api.nvim_set_hl(0, "BlinkCmpKindIconFile", { fg = lighten(c.base03, 100), bg = c.base03 })

vim.api.nvim_set_hl(0, "BlinkCmpKindIconUnit", { fg = darken(c.orange, 30), bg = c.orange })
vim.api.nvim_set_hl(0, "BlinkCmpKindIconSnippet", { fg = darken(c.orange, 30), bg = c.orange })
vim.api.nvim_set_hl(0, "BlinkCmpKindIconFolder", { fg = darken(c.orange, 30), bg = c.orange })

vim.api.nvim_set_hl(0, "BlinkCmpKindIconInterface", { fg = lighten(c.cyan, 100), bg = c.cyan })
vim.api.nvim_set_hl(0, "BlinkCmpKindIconColor", { fg = lighten(c.cyan, 100), bg = c.cyan })
vim.api.nvim_set_hl(0, "BlinkCmpKindIconTypeParameter", { fg = lighten(c.cyan, 100), bg = c.cyan })

vim.api.nvim_set_hl(0, "BlinkCmpKindIconMethod", { fg = lighten(c.blue, 100), bg = c.blue })
vim.api.nvim_set_hl(0, "BlinkCmpKindIconValue", { fg = lighten(c.blue, 100), bg = c.blue })
vim.api.nvim_set_hl(0, "BlinkCmpKindIconEnumMember", { fg = lighten(c.blue, 100), bg = c.blue })
