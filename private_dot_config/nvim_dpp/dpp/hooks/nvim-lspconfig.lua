--- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

-- lua_source {{{

local lsp_utils = require "rc.plugins.lsp.utils"

-- Diagnostics
lsp_utils.setup_diagnostic()

-- Events executed on attach server
vim.api.nvim_create_autocmd({ "LspAttach" }, {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    lsp_utils.setup_codelens(client, bufnr)
    lsp_utils.setup_document_highlight(client, bufnr)
    lsp_utils.setup_inlay_hint(client, bufnr)
    lsp_utils.setup_keymap(client, bufnr)
  end,
  desc = "[LSP] on attach server",
})

-- Setup LSP servers
local mlsp = require "mason-lspconfig"

mlsp.setup {
  ensure_installed = {
    "bashls",
    "fortls",
    "lua_ls",
    "jsonls",
    "ruff",
    "taplo",
    "texlab",
    "vtsls",
    "yamlls",
  },
  automatic_installation = false,
}

mlsp.setup_handlers {
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
      capabilities = lsp_utils.make_client_capabilities(),
    }
  end,
  lua_ls = require "rc.plugins.lsp.servers.lua_ls",
  vtsls = require "rc.plugins.lsp.servers.vtsls",
  ts_ls = function()
    -- disable
  end,
  jsonls = require "rc.plugins.lsp.servers.jsonls",
  yamlls = require "rc.plugins.lsp.servers.yamlls",
  ruff = require "rc.plugins.lsp.servers.ruff",
  rust_analyzer = function()
    -- Do not use mason.nvim installations of rust-analyzer, as the binary
    -- might be built with a different toolchain than your project.
    -- See, https://github.com/mrcjkb/rustaceanvim/blob/master/doc/mason.txt.
  end,
}

-- I don't use mason.nvim installation of Deno, so need to configure denols separately.
require "rc.plugins.lsp.servers.denols"()

-- }}}
