return {
  -- Incremental LSP renaming based on Neovim's command-preview feature.
  {
    "smjonas/inc-rename.nvim",
    cmd = { "IncRename" },
    opts = {},
  },
  -- LSP keymap (overrite)
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("rc.plugins.lsp.keymaps").get_keys()
      keys[#keys + 1] = {
        "<Space>cr",
        function()
          local inc_rename = require "inc_rename"
          return (":%s %s"):format(inc_rename.config.cmd_name, vim.fn.expand "<cword>")
        end,
        expr = true,
        desc = "Rename (inc-rename.nvim)",
        has = "textDocument/rename",
      }
    end,
  },
  -- Noice integration
  {
    "folke/noice.nvim",
    optional = true,
    opts = {
      preset = { inc_rename = true },
    },
  },
}
