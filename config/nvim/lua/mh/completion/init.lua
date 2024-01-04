local luasnip = require("luasnip")
local cmp = require("cmp")
local lspkind = require('lspkind')

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = {
    ["<CR>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
          local entry = cmp.get_active_entry()
         if not entry then
            fallback()
          else
            cmp.confirm({  
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
          })
          end
      else
        fallback()
      end
        end),
    ["<C-n>"] = cmp.mapping(
      {
        c = function()
          if cmp.visible() then
          cmp.select_next_item()
          else
            vim.api.nvim_feedkeys(t("<Down>"), "n", true)
          end
        end,
        i = function(fallback)
          if cmp.visible() then
          cmp.select_next_item()
          else
            fallback()
          end
        end
      }
    ),
    ["<C-p>"] = cmp.mapping(
      {
        c = function()
          if cmp.visible() then
            cmp.select_prev_item()
          else
            vim.api.nvim_feedkeys(t("<Up>"), "n", true)
          end
        end,
        i = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end
      }
    )
  },
formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = lspkind.cmp_format({
				preset = "codicons",
				maxwidth = 50,
			})(entry, vim_item)
			local strings = vim.split(vim_item.kind, "%s+", { trimempty = true })
			kind.kind = " " .. string.format("%s │", strings[1], strings[2]) .. " "
			return kind
		end,
	},
  sources = {
    {name = "nvim_lsp"},
    {name = "luasnip"},
    {name = "spell"},
    {name = "nvim_lsp_signature_help"}
  },
  completion = {
    completeopt = 'menu,menuone,noinsert,noselect',
  }
}
