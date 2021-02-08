-- YANIL
local map = require("mh.mappings").map
local vim = vim
local api = vim.api
local loop = vim.loop
local dotutil = require("mh/util")
local yanil = require("yanil")
local git = require("yanil/git")
local decorators = require("yanil/decorators")
local devicons = require("yanil/devicons")
local canvas = require("yanil/canvas")
local utils = require("yanil/utils")

local open_mode = loop.constants.O_CREAT + loop.constants.O_WRONLY + loop.constants.O_TRUNC
local M = {}


local function pretty_indent(node)
  if not node.parent then
    return
  end
  local text = string.rep("  ", node.depth)
  return text, "SpecialComment"
end

local function pretty_indent_with_git(node)
  local text, hl = pretty_indent(node)
  if not text then
    return
  end

  local hls = {
    {
      col_start = 0,
      col_end = text:len(),
      hl_group = hl
    }
  }

  local git_icon, git_hl = git.get_icon_and_hl(node.abs_path)
  if git_icon then
    local suffix_len = vim.endswith(text, "╴ ") and 4 or 2
    text = text:sub(0, -(suffix_len + 1)) .. git_icon .. " "
    hls = {
      {
        col_start = 0,
        col_end = text:len() - git_icon:len() - 1,
        hl_group = hl
      },
      {
        col_start = text:len() - git_icon:len() - 1,
        col_end = text:len() - 1,
        hl_group = git_hl
      }
    }
  end
  return text, hls
end

local function git_diff(_, node)
  local diff = git.diff(node)
  if not diff then
    return
  end

  -- content
  local bufnr = api.nvim_create_buf(false, true)
  api.nvim_buf_set_option(bufnr, "filetype", "diff")
  api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")
  api.nvim_buf_set_option(bufnr, "swapfile", false)
  api.nvim_buf_set_lines(bufnr, 0, -1, false, diff)

  local winnr = dotutil.floating_window_big(bufnr)

  api.nvim_win_set_option(winnr, "cursorline", true)
  api.nvim_win_set_option(winnr, "winblend", 0)
  api.nvim_win_set_option(winnr, "winhl", "NormalFloat:")
  api.nvim_win_set_option(winnr, "number", true)

  api.nvim_command(string.format([[command! -buffer Apply lua require("yanil/git").apply_buf(%d)]], bufnr))
end

local function default_decorator(node)
  local text = node.name
  local hl_group = "YanilTreeFile"
  if node:is_dir() then
    if not node.parent then
      text = vim.fn.fnamemodify(node.name, ":~")
      hl_group = "YanilTreeRoot"
    else
      hl_group = node:is_link() and "YanilTreeLink" or "YanilTreeDirectory"
    end
  else
    if node:is_link() then
      hl_group = node:is_broken() and "YanilTreeLinkBroken" or "YanilTreeLink"
    elseif node.is_exec then
      hl_group = "YanilTreeFileExecutable"
    end
  end
  return text, hl_group
end

local function toggle_zoom()
  vim.b.oldWindowSize = vim.b.oldWindowSize or vim.api.nvim_win_get_width(0)
  if vim.b.nvimTreeIsZoomed then
    vim.b.nvimTreeIsZoomed = false
    vim.cmd("silent vertical resize" .. vim.b.oldWindowSize)
  else
    vim.b.nvimTreeIsZoomed = true
    vim.cmd "silent vertical resize"
  end
end


-- FileSystem operations
-- Mode Node
local function move_node(tree, node)
  node = node:is_dir() and node or node.parent
  local name =
    vim.fn.input(
    string.format(
      [[Rename the current node
==========================================================
Enter the new path for the node:
%s]],
      node.abs_path
    )
  )

  print(name)
  -- if not name or name == "" then
  --   return
  -- end
  -- local path = node.abs_path .. name
  --
  -- -- checking file exists in schedule function to make input prompt close
  -- vim.schedule(
  --   function()
  --     if tree.root:find_node_by_path(path) then
  --       print("path", path, "is already exists")
  --       return
  --     end
  --   end
  -- )
  --
  -- local refresh =
  --   vim.schedule_wrap(
  --   function()
  --     tree:refresh(
  --       node,
  --       {},
  --       function()
  --         node:load(true)
  --         node:open()
  --       end
  --     )
  --     git.update(tree.cwd)
  --   end
  -- )
  --
  -- if vim.endswith(path, "/") then
  --   -- 0755
  --   loop.fs_mkdir(
  --     path,
  --     16877,
  --     function(err, ok)
  --       assert(not err, err)
  --       assert(ok, "mkdir failed")
  --       refresh()
  --     end
  --   )
  --   return
  -- end
  --
  -- -- 0644
  -- loop.fs_open(
  --   path,
  --   "w+",
  --   33188,
  --   function(err, fd)
  --     assert(not err, err)
  --     loop.fs_close(
  --       fd,
  --       function(c_err, ok)
  --         assert(not c_err and ok, "create file failed")
  --       end
  --     )
  --     refresh()
  --   end
  -- )
end

-- Create Node
local function create_node(tree, node)
  node = node:is_dir() and node or node.parent
  local msg_tag = "Enter the dir/file name to be created. Dirs end with a '/'\n"
  local msg = string.format("Add a childnode \n%s \n%s", string.rep("=", 58), msg_tag)
  local ans = vim.fn.input(msg, node.abs_path)

  local function create_dirs_if_needed(dirs)
    local parentDir = vim.fn.fnamemodify(dirs, ":h")
    local dir_split = vim.split(parentDir, "/")

    dotutil.reduce(
      dir_split,
      "",
      function(directories, dir)
        directories = directories .. dir .. "/"
        local stats = loop.fs_stat(directories)
        if stats == nil then
          loop.fs_mkdir(directories, 493)
        end
        return directories
      end
    )


  tree:refresh( node, {}, function()
    node:load(true)
    node:open()
  end)
  git.update(tree.cwd)
  end
  local function file_writer(path)
    create_dirs_if_needed(path)
    loop.fs_open(
      path,
      "w",
      open_mode,
      vim.schedule_wrap(
        function(err, fd)
          if err then
            api.nvim_err_writeln("Could not create file " .. path)
          else
            -- FIXME: i don't know why but libuv keeps creating file with executable permissions
            -- this is why we need to chmod to default file permissions
            loop.fs_chmod(path, 420)
            loop.fs_close(fd)
            api.nvim_out_write("File " .. path .. " was properly created\n")

            tree:refresh(
              node,
              {},
              function()
                node:load(true)
                node:open()
              end
            )
            git.update(tree.cwd)
          end
        end
      )
    )
  end

  if not ans or ans == "" then
    return
  end

  if vim.endswith(ans, "/") then
    create_dirs_if_needed(ans)
  else
    file_writer(ans)
  end

end

-- Delete Node
local function delete_node(tree, node)
  if node == tree.root then
    print("You can NOT delete the root")
    return
  end
  if node:is_dir() then
    node:load()
  end
  local msg_tag = string.format("Are you sure you want to delete (y/n) \n%s: ", node.abs_path)
  if node:is_dir() and #node.entries > 0 then
    msg_tag = "STOP! Directory is not empty \n" .. msg_tag
  end
  local msg = string.format("Delete the current node \n%s \n%s", string.rep("=", 58), msg_tag)
  local answer = vim.fn.input(msg)
  if answer:lower() ~= "y" then
    print("Operation canceld")
    return
  end

  local handle
  handle =
    loop.spawn(
    "rm",
    {args = {"-rf", node.abs_path}},
    function(code)
      handle:close()
      if code ~= 0 then
        print("delete node failed")
        return
      end

      vim.schedule(
        function()
          local next_node = tree:find_neighbor(node, 1) or tree:find_neighbor(node, -1)
          local path = next_node.abs_path
          local parent = node.parent
          tree:refresh(
            parent,
            {},
            function()
              parent:load(true)
            end
          )
          tree:go_to_node(tree.root:find_node_by_path(path))
          git.update(tree.cwd)
        end
      )
    end
  )
end

-- TODO: FS Menu
local function menu_float(tree, node)
  -- print(vim.inspect(node))
  local settings = {
    "Add a node",
    "Delete a node",
    "Move a node",
    "Reveal in system finder"
  }

  local bufnr = api.nvim_create_buf(false, true)
  api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")
  api.nvim_buf_set_option(bufnr, "swapfile", false)
  api.nvim_buf_set_lines(bufnr, 0, -1, false, settings)

  local winnr = dotutil.floating_window_small(bufnr, {})

  api.nvim_win_set_option(winnr, "cursorline", true)
  api.nvim_win_set_option(winnr, "winblend", 0)
  api.nvim_win_set_option(winnr, "winhl", "NormalFloat:")
  api.nvim_win_set_option(winnr, "number", true)

  -- api.nvim_command(string.format([[command! -buffer Apply lua require("yanil/git").apply_buf(%d)]], bufnr))
end

yanil.setup( {
  git = {
    icons = {
      Unstaged = "✗",
      Staged = "✓",
      Unmerged = "",
      Renamed = "➜",
      Untracked = "★",
      Modified = "✹",
      Deleted = "✖",
      Dirty = "✗",
      Ignored = " ",
      Clean = "✔︎",
      Unknown = "?"
    }
  }
})

local tree = require("yanil/sections/tree"):new()

tree:setup {
  draw_opts = {
    decorators = {
      pretty_indent_with_git,
      devicons.decorator(),
      decorators.space,
      default_decorator,
      decorators.executable,
      decorators.readonly,
      decorators.link_to
    }
  },
  keymaps = {
    m = menu_float,
    ["]c"] = git.jump_next,
    ["[c"] = git.jump_prev,
    gd = git_diff,
    ["A"] = create_node,
    ["D"] = delete_node,
    ["M"] = move_node,
    ["<tab>"] = toggle_zoom,
    C = dotutil.noop,
    U = dotutil.noop,
    K = function()
      vim.api.nvim_feedkeys("5k", "n", true)
    end,
    J = function()
      vim.api.nvim_feedkeys("5j", "n", true)
    end
  }
}
canvas.register_hooks {
  on_enter = function()
    vim.cmd("hi YanilTreeDirectory guifg=#6699cc")
    vim.cmd("set nowrap")
    vim.cmd("silent vertical resize 45")
    git.update(tree.cwd)
    utils.buf_set_keymap(
      canvas.bufnr,
      "n",
      "q",
      function()
        vim.fn.execute("quit")
      end
    )
  end
}
canvas.setup {
  sections = {
    tree
  },
  win_options = {"nowrap"},
  autocmds = {
    {
      event = "User",
      pattern = "YanilGitStatusChanged",
      cmd = function()
        git.refresh_tree(tree)
      end
    }
  }
}

map("n", "-", "<Cmd>YanilToggle<cr>", {noremap = true, silent = true, nowait = true})

return M
