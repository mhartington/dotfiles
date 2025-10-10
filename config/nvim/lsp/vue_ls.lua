local function get_node_modules(root_dir)
  local lspNMRoot = vim.fs.dirname(vim.fs.find("node_modules", { path = root_dir, upward = true })[1])
  if lspNMRoot == nil then
    return ""
  else
    return lspNMRoot
  end
end

local default_node_modules = get_node_modules(vim.fn.getcwd())
return { init_options = { typescript = { tsdk = default_node_modules .. "/typescript/lib" } } }
