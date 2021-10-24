local lspconfig = require "lspconfig"
local platform = require "rc.core.platform"
local utils = require "rc.core.util"

require "rc.config.lsp.diagnostics"
require("rc.config.lsp.kind").setup()

-- custom 'on_attach' function
local function on_attach(client, bufnr)
  require("rc.config.lsp.formatting").setup(client, bufnr)
  require("rc.config.lsp.keymap").setup(client, bufnr)
  require("rc.config.lsp.highlight").setup(client)
  require("rc.config.lsp.code_lens").setup(client)
end

-- Capabilities (for nvim-cmp)
local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
local completionItem = updated_capabilities.textDocument.completion.completionItem
completionItem.documentationFormat = { "markdown" }
completionItem.snippetSupport = true
completionItem.preselectSupport = true
completionItem.insertReplaceSupport = true
completionItem.labelDetailsSupport = true
completionItem.deprecatedSupport = true
completionItem.commitCharactersSupport = true
completionItem.tagSupport = { valueSet = { 1 } }
completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

--[[ LSP servers ]]
local servers = {
  -- https://github.com/bash-lsp/bash-language-server
  bashls = {},
  -- https://clangd.llvm.org/installation.html
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--suggest-missing-includes",
      "--cross-file-rename",
    },
    init_options = {
      clangdFileStatus = true,
      usePlaceholders = true,
      completeUnimported = true,
    },
  },
  -- https://github.com/regen100/cmake-language-server
  cmake = {},
  -- https://github.com/vscode-langservers/vscode-css-languageserver-bin
  cssls = {
    cmd = { "css-languageserver", "--stdio" },
    filetypes = { "css", "scss", "less", "sass" },
    root_dir = lspconfig.util.root_pattern("package.json", ".git"),
  },
  -- https://github.com/hansec/fortran-language-server
  fortls = {},
  -- https://github.com/golang/tools/tree/master/gopls
  gopls = {
    cmd = { "gopls", "--remote=auto" },
    init_options = { usePlaceholders = true, completeUnimported = true },
  },
  -- https://github.com/vscode-langservers/vscode-html-languageserver-bin
  html = { cmd = { "html-languageserver", "--stdio" } },
  -- https://github.com/vscode-langservers/vscode-json-languageserver
  jsonls = { cmd = { "vscode-json-languageserver", "--stdio" } },
  -- https://github.com/jose-elias-alvarez/null-ls.nvim
  ["null-ls"] = {},
  -- https://github.com/microsoft/pyright
  pyright = {
    settings = { python = { formatting = { provider = "black" } } },
  },
  -- https://solargraph.org/
  solargraph = {},
  -- https://github.com/iamcco/vim-language-server vimls = {},
  vimls = {},
  -- https://github.com/redhat-developer/yaml-language-server
  yamlls = {},
}

-- Register null-ls as a language server.
require("rc.config.lsp.null-ls").setup()

-- https://github.com/rust-analyzer/rust-analyzer
-- https://github.com/simrat39/rust-tools.nvim
require("rust-tools").setup {
  server = { on_attach = on_attach, capabilities = updated_capabilities },
}

-- https://github.com/sumneko/lua-language-server
-- https://github.com/folke/lua-dev.nvim
local system_name
if platform.is_mac then
  system_name = "macOS"
elseif platform.is_linux then
  system_name = "Linux"
elseif platform.is_windows then
  system_name = "Windows"
else
  print "Unsupported system for sumneko"
end
local sumneko_root_path = vim.fn.expand "$HOME/src/github.com/sumneko/lua-language-server"
local sumneko_binary = string.format("%s/bin/%s/lua-language-server", sumneko_root_path, system_name)

local luadev = require("lua-dev").setup {
  lspconfig = {
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
    on_attach = on_attach,
    settings = {
      Lua = {
        diagnostics = { globals = { "vim", "packer_plugins" } },
        runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
        workspace = {
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          },
        },
      },
    },
  },
}
lspconfig.sumneko_lua.setup(luadev)

for server, config in pairs(servers) do
  lspconfig[server].setup(vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    capabilities = updated_capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }, config))
  local cfg = lspconfig[server]
  if not (cfg and cfg.cmd and vim.fn.executable(cfg.cmd[1]) == 1) then
    utils.error(server .. ": command not found" .. vim.inspect(cfg.cmd))
  end
end
