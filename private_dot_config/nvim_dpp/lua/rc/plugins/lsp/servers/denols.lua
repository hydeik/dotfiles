-- Refer:
-- https://github.com/yasunori0418/dotfiles/blob/main/config/nvim/lua/user/lsp/servers/denols.lua

---@param path string
---@param bufnr integer
---@return string|nil
local find_root = function(path, bufnr)
  local ft = require("rc.plugins.lsp.utils").ft

  ---@type string|nil
  local project_root = vim.fs.root(path, vim.list_extend({ ".git" }, ft.deno_files))
  project_root = project_root or vim.env.PWD --[[@as string]]

  -- When node files found, do not launch denols.
  local is_node_project = vim.iter(ft.node_specific_files):any(function(file)
    return vim.uv.fs_stat(vim.fs.joinpath(project_root, file)) ~= nil
  end)
  if is_node_project then
    return nil
  end

  -- When node files not found, lauch denols
  local deps_path = vim.fs.joinpath(project_root, "deps.ts")
  if vim.uv.fs_stat(deps_path) ~= nil then
    vim.b[bufnr].deno_deps_candidate = deps_path
  end
  return project_root
end

return function()
  require("lspconfig").denols.setup {
    root_dir = function(path, bufnr)
      return find_root(vim.fs.dirname(path), bufnr)
    end,
    capabilities = require("rc.plugins.lsp.utils").make_client_capabilities(),
    settings = {
      deno = {
        enable = true,
        unstable = true,
        lint = true,
        suggest = {
          completeFunctionCalls = true,
          autoImports = false,
          imports = {
            hosts = {
              ["https://deno.land"] = true,
              ["https://denopkg.com"] = true,
              ["https://crux.land"] = true,
              ["https://x.nest.land"] = true,
              ["https://jsr.io"] = true,
            },
          },
        },
      },
    },
  }
end
