local fn = vim.fn
local api = vim.api
local cmd = vim.cmd

local M = {}

function M.BufDel()
  local buflisted = vim.fn.getbufinfo({buflisted = 1})
  -- local cur_winnr, cur_bufnr = fn.winnr(), fn.bufnr()

  -- for _, winid in ipairs(fn.getbufinfo(cur_bufnr)[1].windows) do
  --   cmd(string.format("%d wincmd w", fn.win_id2win(winid)))
  --   cmd(cur_bufnr == buflisted[#buflisted].bufnr and "bp" or "bn")
  -- end

  -- print(string.format("%d wincmd w", cur_winnr))

  -- Change window/buffer
  -- cmd(string.format("%d wincmd w", cur_winnr))

  local bufType = vim.bo.bt
  -- If it's a quickfix or temporary buffer, not a "real" buffer
  if bufType == "quickfix" or bufType == "nofile" or bufType == "Yanil" then
    cmd("close")
    return
  elseif bufType == "terminal" then
    cmd("bd!")
    return
  else
    -- If there's only a single buffer, and it's an empty one
    if #buflisted == 1 and vim.bo.filetype == "" then
      cmd("confirm qall")
      return
    end

    local buf  = api.nvim_get_current_buf()
    if vim.bo.modified then
      local opts = {"&write", "&skip", "&break"}
      local choice = vim.fn.confirm("Unsaved changes:", table.concat(opts, "\n"))
      if choice == 1 then
        cmd("write")
        cmd("bd")
      elseif choice == 2 then
        cmd("bd!")
      elseif choice == 3 then
        return
      end
    else
      cmd("bp")
      cmd(string.format('bd %d', buf))
    end
  end

  -- cmd(is_terminal and "bd! #" or "silent! confirm bd #")
end
-- vim.cmd([[command! -bang -nargs=? Bdelete lua require('bufdelete').bufdelete_cmd(<q-args>, <q-bang>)]])
return M
