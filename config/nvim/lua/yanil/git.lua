local vim = vim
local api = vim.api
local loop = vim.loop

local utils = require("yanil/utils")

local default_options = {
  icons = {
    Modified = "",
    Staged = "",
    Untracked = "",
    Renamed = "",
    Unmerged = "",
    Deleted = "",
    Dirty = "",
    Ignored = "",
    Clean = "",
    Unknown = ""
  },
  highlights = {}
}

do
  for status, _ in pairs(default_options.icons) do
    default_options.highlights[status] = "YanilGit" .. status
  end
end

local M = {
  state = {},
  options = {}
}

function M.setup(opts)
  opts = opts or {}
  M.options.icons = vim.tbl_deep_extend("keep", opts.icons or {}, default_options.icons)
  M.options.highlights = vim.tbl_deep_extend("keep", opts.highlights or {}, default_options.highlights)

  api.nvim_command("augroup yanil_git")
  api.nvim_command("autocmd!")
  api.nvim_command(
    [[autocmd BufWritePost * if empty(&buftype) | call luaeval('require("yanil/git").update()') | endif]]
  )
  api.nvim_command("autocmd User FugitiveChanged lua require('yanil/git').update()")
  api.nvim_command("augroup end")
end

local delimiter = string.char(0)

-- man git-status
-- X          Y     Meaning
-- -------------------------------------------------
--           [MD]   not updated
-- M        [ MD]   updated in index
-- A        [ MD]   added to index
-- D         [ M]   deleted from index
-- R        [ MD]   renamed in index
-- C        [ MD]   copied in index
-- [MARC]           index and work tree matches
-- [ MARC]     M    work tree changed since index
-- [ MARC]     D    deleted in work tree
local function get_status(x, y)
  if y == "M" then
    return "Modified"
  elseif x == "D" or y == "D" then
    return "Deleted"
  elseif x == "M" or x == "A" then
    return "Staged"
  else
    error(string.format("unexpected status %s%s", x, y))
  end
end

local parsers = {
  ["1"] = function(line)
    return get_status(line:sub(3, 3), line:sub(4, 4)), line:sub(114, -1)
  end,
  ["2"] = function(line)
    -- 2 RM N... 100644 100644 100644 71aa5b06856d39533d3f38db3d99dd1fc03f7352 71aa5b06856d39533d3f38db3d99dd1fc03f7352 R100 <new-path>
    local percent_path = line:sub(114, -1)
    return "Renamed", vim.split(percent_path, " ")[2]
  end,
  ["u"] = function(line)
    return "Unmerged", line:sub(162, -1)
  end,
  ["?"] = function(line)
    return "Untracked", line:sub(3, -1)
  end,
  ["!"] = function(line)
    return "Ignored", line:sub(3, -1)
  end
}

function M.update(cwd)
  cwd = cwd or loop.cwd()
  if not cwd then
    return
  end
  if not vim.endswith(cwd, utils.path_sep) then
    cwd = cwd .. utils.path_sep
  end

  local git_root

  local status_callback =
    vim.schedule_wrap(
    function(code, _signal, stdout, stderr)
      if code > 0 then
        api.nvim_err_writeln(string.format("git status failed: %s", stderr))
        return
      end

      local state = {}
      stdout = stdout or ""
      local lines = vim.split(stdout, delimiter)

      local is_rename = false

      for _, line in ipairs(lines) do
        if line == "" then break end

        local status, path
        if is_rename then
          status = "Dirty"
          path = line
          is_rename = false
        else

          local parser = parsers[line:sub(1, 1)]
          status, path = parser(line)
          is_rename = status == "Renamed"
        end

        local abs_path = git_root .. path
        state[abs_path] = status

        if state[abs_path] ~= 'Ignored' then
          while vim.startswith(abs_path, git_root) do
            abs_path = vim.fn.fnamemodify(abs_path, ":h")
            local dir = abs_path .. utils.path_sep
            if state[dir] then break end
            state[dir] = "Dirty"
          end
        end
      end
      -- End for loop

      -- Eval State and fire event
      if not utils.table_equal(M.state, state) then
        M.prev_state = M.state
        M.state = state
        if vim.fn.exists("#User#YanilGitStatusChanged") then
          api.nvim_command("doautocmd User YanilGitStatusChanged")
        end
      end
    end
  )

  local function root_callback(code, _signal, stdout, _stderr)
    if code > 0 then
      return
    end

    git_root = vim.trim(stdout) .. "/"
    utils.spawn(
      "git",
      {
        args = {
          "-C",
          vim.trim(stdout),
          "status",
          "--porcelain=v2",
          "-z",
          "--ignored=traditional"
        },
        cwd = git_root
      },
      status_callback
    )
  end

  utils.spawn(
    "git",
    {
      args = {
        "rev-parse",
        "--show-toplevel"
      },
      cwd = cwd
    },
    root_callback
  )
end

function M.get_icon_and_hl(path)
  local status = M.state[path]
  if not status then
    return
  end

  return M.options.icons[status], M.options.highlights[status]
end

function M.decorator()
  return function(node)
    local icon, hl = M.get_icon_and_hl(node.abs_path)
    if not icon then
      if node.parent then
        return "  "
      end
      return
    end

    local text = string.format("%s ", icon)
    return text, hl
  end
end

function M.diff(node)
  -- if M.state[node.abs_path] ~= "Modified" then return end

  return vim.fn.systemlist({"git", "diff", "--patch", "--no-color", "--diff-algorithm=default", node.abs_path})
end

function M.apply_buf(bufnr)
  bufnr = bufnr or 0
  local patch = api.nvim_buf_get_lines(bufnr, 0, -1, false)
  if not patch or #patch == 0 or (#patch == 1 and patch[1] == "") then
    vim.fn.execute("q")
    return
  end
  if patch[-1] ~= " " then
    table.insert(patch, " ")
  end
  patch = table.concat(patch, "\n")
  local output = vim.fn.system({"git", "apply", "--cached"}, patch)
  if vim.v.shell_error > 0 then
    api.nvim_err_writeln(string.format("git apply failed: %s", output))
    return
  end

  vim.fn.execute("q")

  if vim.g.loaded_fugitive then
    api.nvim_command("doautocmd User FugitiveChanged")
  else
    M.update()
  end
end

function M.refresh_tree(tree)
  for node in tree:iter() do
    if M.prev_state[node.abs_path] ~= M.state[node.abs_path] then
      tree:refresh(node, {non_recursive = true})
    end
  end
end

function M.jump(tree, linenr, step)
  local total_lines = tree:total_lines()
  local start, total = step, step * total_lines
  for i = start, total, step do
    local index = (i + linenr) % total_lines
    local node = tree.root:get_node_by_index(index) -- TODO: optimaze
    if node.parent and M.get_icon_and_hl(node.abs_path) then
      tree:go_to_node(node)
      return
    end
  end
end

function M.jump_next(tree, _node, _key, linenr)
  M.jump(tree, linenr, 1)
end

function M.jump_prev(tree, _node, _key, linenr)
  M.jump(tree, linenr, -1)
end

function M.debug()
  print(vim.inspect(M.state))
end

return M
