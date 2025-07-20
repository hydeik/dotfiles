return {
  -- enabled = false,
  -- Simple winbar/statusline plugin that shows your current code context
  "SmiteshP/nvim-navic",
  lazy = true,
  init = function()
    vim.g.navic_silence = true
    require("rc.utils.lsp").on_attach(function(client, buffer)
      if client:supports_method "textDocument/documentSymbol" then
        require("nvim-navic").attach(client, buffer)
      end
    end)
  end,
  opts = {
    icons = require("mini.icons").list "lsp",
    lsp = {
      auto_attach = true,
    },
    separator = " > ",
    highlight = true,
    depth_limit = 5,
  },
}
