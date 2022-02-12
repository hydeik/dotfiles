local M = {}
local util = require "rc.core.util"

function M.install_missing(servers)
  local lsp_installer = require "nvim-lsp-installer"
  for name, _ in pairs(servers) do
    local server_is_found, server = lsp_installer.get_server(name)
    if server_is_found then
      if not server:is_installed() then
        server:install()
      end
    else
      util.error("Server " .. name .. " not found")
    end
  end
end

function M.setup(servers, options)
  local lsp_installer = require "nvim-lsp-installer"

  lsp_installer.on_server_ready(function(server)
    local opts = vim.tbl_deep_extend("force", options, servers[server.name] or {})

    if server.name == "clangd" then
      -- Need to update PATH
      opts = vim.tbl_deep_extend("force", server:get_default_options(), opts)
      require("clangd_extensions").setup {
        server = opts,
      }
    elseif server.name == "rust_analyzer" then
      -- Need to update PATH
      opts = vim.tbl_deep_extend("force", server:get_default_options(), opts)
      require("rust-tools").setup(opts)
      server:attach_buffers()
    else
      server:setup(opts)
    end
    vim.cmd [[ do User LspAttachBuffers ]]
  end)

  M.install_missing(servers)
end

return M
