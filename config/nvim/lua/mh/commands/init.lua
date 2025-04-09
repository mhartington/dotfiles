local fn = vim.fn
local api = vim.api
local cmd = vim.cmd

local M = {}
local original_opts = {}
function M.BufDel()
  local buflisted = vim.fn.getbufinfo({ buflisted = 1 })
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
  if bufType == "quickfix" or bufType == "nofile" and vim.bo.filetype == "vim" or bufType == "Yanil" then
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

    local buf = api.nvim_get_current_buf()
    if vim.bo.modified then
      local opts = { "&write", "&skip", "&break" }
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
      -- cmd("bp")
      cmd(string.format("bd"))
    end
  end

  -- cmd(is_terminal and "bd! #" or "silent! confirm bd #")
end
--
local function save_opts()
  original_opts = vim.o
end

local function hide_stuff()
  vim.o.fillchars = "stl: ,stlnc: ,vert: ,diff: ,msgsep: ,eob: ,horiz: ,horizup: ,horizdown: "
  vim.o.number = false
  vim.o.relativenumber = false
  vim.o.showtabline=0
end
local function resize_pads()
  local ui = vim.api.nvim_list_uis()[1]
  local width = ui.width
  local height = ui.height

  local padding_width = math.floor((width / 2 ) / 2)

  for pos, id in pairs(vim.t.padding) do
    if pos == "l" or pos == "r" then
      api.nvim_win_set_width(vim.t.padding[pos].winId, padding_width)
    end
    if pos == "t" or pos == "b" then
      api.nvim_win_set_height(vim.t.padding[pos].winId, 0)
    end
  end
end
local function init_pad(command)
  vim.cmd(command)
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.modifiable = false
  vim.bo.buflisted = false
  vim.bo.swapfile = false
  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.wo.cursorline = false
  vim.wo.cursorcolumn = false
  vim.wo.winfixwidth = true
  vim.wo.winfixheight = true
  vim.wo.statusline = ""

  local bufnr = api.nvim_get_current_buf()
  local winId = api.nvim_get_current_win()

  vim.api.nvim_create_autocmd({ "CursorMoved", "WinEnter" }, {
    buffer = bufnr,
    nested = true,
    callback = function(ev)
      vim.api.nvim_set_current_win(vim.t.main.winId)
    end,
  })

    vim.api.nvim_set_current_win(vim.t.main.winId)
  return {winId = winId, bufnr=bufnr}
end

local function toggle_off()
  vim.o = original_opts
  vim.cmd("tabclose")
end
local function toggle_on()
  save_opts()
  local origina_tab = vim.fn.tabpagenr()
  vim.cmd("tab split")
  vim.t.main = {
    bufnr = api.nvim_get_current_buf(),
    winId = api.nvim_get_current_win(),
  }
  vim.t.padding = {
    l = init_pad("vertical topleft new"),
    r = init_pad("vertical botright new"),
    t = init_pad("topleft new"),
    b = init_pad("botright new"),
  }
  resize_pads()
  hide_stuff()
end
vim.api.nvim_create_user_command("Zen", function()
  if vim.g.goyo_enabled then
    toggle_off()
    vim.g.goyo_enabled = false
  else
    toggle_on()
    vim.g.goyo_enabled = true
  end
end, {})
return M
