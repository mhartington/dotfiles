local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local messages = require("lsp-status/messaging").messages

local function get_lsp_progress()
  local buf_messages = messages()
  local msgs = {}
  -- print(vim.inspect(vim.lsp.util.get_progress_messages()))
  for _, msg in ipairs(buf_messages) do
    local contents

    -- {
    --   name = "sumneko_lua",
    --   title = "Diagnosing workspace"
    --   message = "1340/1394",
    --   percentage = 96,
    --   progress = true,
    --   spinner = 3,
    -- }
    --  [sumneko_lua] ⣟ Loading workspace 373/2425 (15%)
    if msg.progress then
      contents = msg.title

      -- message
      -- if msg.message then
      --   contents = contents .. ' ' .. msg.message
      -- end

      -- if msg.percentage then
      --   contents = contents .. string.format(" (%.0f%%%%)", msg.percentage)
      -- end

      if msg.spinner then
        contents = spinner_frames[(msg.spinner % #spinner_frames) + 1] .. " " .. contents
      end
    elseif msg.status then
      contents = msg.content
      if msg.uri then
        local filename = vim.uri_to_fname(msg.uri)
        filename = vim.fn.fnamemodify(filename, ":~:.")
        local space = math.min(60, math.floor(0.6 * vim.fn.winwidth(0)))

        if #filename > space then
          filename = vim.fn.pathshorten(filename)
        end

        contents = "(" .. filename .. ") " .. contents
      end
    else
      contents = msg.content
    end
    table.insert(msgs, contents)
  end
  return table.concat(msgs, " ")
end

local M = {
  progress = get_lsp_progress
}
return M
