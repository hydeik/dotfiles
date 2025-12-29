return {
  -- enabled = false,
  -- Simple winbar/statusline plugin that shows your current code context
  "SmiteshP/nvim-navic",
  lazy = true,
  init = function()
    vim.g.navic_silence = true
  end,
  opts = function()
    Snacks.util.lsp.on({ method = "textDocument/documentSymbol" }, function(buffer, client)
      require("nvim-navic").attach(client, buffer)
    end)
    return {
      icons = require("mini.icons").list "lsp",
      lsp = {
        auto_attach = true,
      },
      separator = " > ",
      highlight = true,
      depth_limit = 5,
      lazy_update_context = true,
    }
  end,
}
