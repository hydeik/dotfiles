--- [rustaceanvim](https://github.com/mrcjkb/rustaceanvim)
--- Supercharge your Rust experience in Neovim!

-- lua_source {{{

---@return rustaceanvim.Opts
vim.g.rustaceanvim = function()
  local capabilities = require("rc.plugins.lsp.utils").make_client_capabilities()
  -- add experimental features
  -- See, https://github.com/mrcjkb/rustaceanvim/blob/master/lua/rustaceanvim/config/server.lua
  capabilities.experimental = {
    hoverActions = true,
    colorDiagnosticOutput = true,
    hoverRange = true,
    serverStatusNotification = true,
    snippetTextEdit = true,
    codeActionGroup = true,
    ssr = true,
    commands = {
      commands = {
        "rust-analyzer.runSingle",
        "rust-analyzer.showReferences",
        "rust-analyzer.gotoLocation",
        "editor.action.triggerParameterHints",
        "rust-analyzer.debugSingle", -- requires nvim-dap
      },
    },
  }

  return {
    server = {
      capabilities = capabilities,
      default_settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            buildScripts = { enable = true },
          },
          checkOnSave = true,
          procMacro = {
            enable = true,
            ignored = {
              ["async-recursion"] = { "async_recursion" },
              ["async-trait"] = { "async_trait" },
              ["napi-derive"] = { "napi" },
            },
          },
        },
      },
    },
  }
end

-- }}}

-- lua_rust {{{
-- Override some keymaps
local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "J", function()
  vim.cmd.RustLsp "joinLines"
end, { desc = "Join Lines", buffer = bufnr })

-- vim.keymap.set("n", "<Space>cA", function()
--   vim.cmd.RustLsp "codeAction"
-- end, { desc = "Code Action", buffer = bufnr })

vim.keymap.set("n", "<Space>dr", function()
  vim.cmd.RustLsp "debuggables"
end, { desc = "Rust Debuggables", buffer = bufnr })

-- }}}
