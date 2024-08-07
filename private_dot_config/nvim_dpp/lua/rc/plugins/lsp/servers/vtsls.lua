-- Refer:
-- https://github.com/ryoppippi/dotfiles/blob/e6e0f02/nvim/lua/plugin/nvim-lspconfig/servers/vtsls.lua#L44-L70

---@param path string?
---@return string?
local find_root = function(path)
  if path == nil then
    return nil
  end

  local ft = require("rc.plugins.lsp.utils").ft
  local project_root = vim.fs.root(path, vim.list_extend({ ".git" }, ft.node_specific_files))

  if project_root == nil or project_root == vim.env.HOME then
    return nil
  end

  local is_node_project = vim.iter(ft.node_files):any(function(file)
    return vim.uv.fs_stat(vim.fs.joinpath(project_root, file)) ~= nil
  end)
  if is_node_project then
    return project_root
  end

  return nil
end

return function()
  local utils = require "rc.plugins.lsp.utils"
  require("lspconfig").vtsls.setup {
    filetypes = utils.ft.js_like,
    single_file_support = false,
    root_dir = function(path, _)
      return find_root(vim.fs.dirname(path))
    end,
    capabilities = utils.make_client_capabilities(),
    settings = {
      complete_function_calls = true,
      vtsls = {
        enableMoveToFileCodeAction = true,
        autoUseWorkspaceTsdk = true,
        experimental = {
          completion = {
            enableServerSideFuzzyMatch = true,
          },
        },
      },
      typescript = {
        updateImportsOnFileMove = { enabled = "always" },
        suggest = {
          completeFunctionCalls = true,
        },
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterNames = { enabled = "literals" },
          parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = false },
        },
      },
    },
  }
end
