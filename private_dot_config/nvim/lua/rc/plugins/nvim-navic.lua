return {
  -- enabled = false,
  -- Simple winbar/statusline plugin that shows your current code context
  "SmiteshP/nvim-navic",
  init = function()
    vim.g.navic_silence = true
    -- vim.api.nvim_create_autocmd("LspAttach", {
    --   group = vim.api.nvim_create_augroup("UserNavicConfig", { clear = true }),
    --   callback = function(args)
    --     local buffer = args.buf
    --     local client = vim.lsp.get_client_by_id(args.data.client_id)
    --     if client.server_capabilities.documentSymbolProvider then
    --       require("nvim-navic").attach(client, buffer)
    --     end
    --   end,
    -- })
  end,
  opts = {
    icons = require("rc.core.config").icons.kinds,
    lsp = {
      auto_attach = true,
    },
    separator = " > ",
    highlight = true,
    depth_limit = 5,
  },
}
