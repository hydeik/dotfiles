local function library()
  local dpp = require "dpp"
  local paths = {}
  for _, plugin in pairs(dpp.get()) do
    table.insert(paths, vim.fs.joinpath(plugin.path, "lua"))
  end
  table.insert(paths, vim.fs.joinpath(vim.fn.stdpath "config", "lua"))
  table.insert(paths, vim.fs.joinpath(vim.env.VIMRUNTIME, "lua"))
  table.insert(paths, "${3rd}/luv/library")
  table.insert(paths, "${3rd}/busted/library")
  table.insert(paths, "${3rd}/luassert/library")
  return paths
end

return function()
  require("lspconfig").lua_ls.setup {
    capabilities = require("rc.plugins.lsp.utils").make_client_capabilities(),
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          pathStrict = true,
          version = "LuaJIT",
          path = { "?.lua", "?/init.lua" },
        },
        workspace = {
          checkThirdParty = false,
          library = library(),
          -- maxPreload = 1000,
        },
        completion = {
          callSnippet = "Both",
          enable = true,
          keywordSnippet = "Both",
        },
        doc = {
          privateName = { "^_" },
        },
        hint = {
          enable = true,
          setType = false,
          paramType = true,
          paramName = "Disable",
          semicolon = "Disable",
          arrayIndex = "Disable",
        },
        diagnostics = {
          globals = { "vim" },
        },
        format = {
          -- because use stylua from efm.
          enable = false,
        },
      },
    },
  }
end
