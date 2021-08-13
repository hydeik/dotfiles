local globals = require "core.globals"

-- Icons for signcolumn and pum
local sign_define = vim.fn.sign_define
sign_define("LspDiagnosticsErrorSign", { text = "", texthl = "LspDiagnosticError" })
sign_define("LspDiagnosticsWarningSign", { text = "", texthl = "LspDiagnosticWarning" })
sign_define("LspDiagnosticsInformationSign", { text = "", texthl = "LspDiagnosticInformtion" })
sign_define("LspDiagnosticsHintSign", { text = "", texthl = "LspDiagnosticHint" })

vim.lsp.protocol.CompletionItemKind = {
  " [text]",
  "Ƒ [method]",
  " [function]",
  " [constructor]",
  "ﰠ [field]",
  " [variable]",
  " [class]",
  " [interface]",
  " [module]",
  " [property]",
  " [unit]",
  " [value]",
  " [enum]",
  " [key]",
  "﬌ [snippet]",
  " [color]",
  " [file]",
  " [reference]",
  " [folder]",
  " [enum member]",
  " [constant]",
  " [struct]",
  "⌘ [event]",
  " [operator]",
  "♛ [type]",
}

-- Handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = true,
  signs = { priority = 20 },
  update_in_insert = false,
})

vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
  if err ~= nil or result == nil then
    return
  end
  if not vim.api.nvim_buf_get_option(bufnr, "modified") then
    local view = vim.fn.winsaveview()
    vim.lsp.util.apply_text_edits(result, bufnr)
    vim.fn.winrestview(view)
    if bufnr == vim.api.nvim_get_current_buf() then
      vim.api.nvim_command "noautocmd :update"
    end
  end
end

-- [[ Configure LSP servers ]]
local lspconfig = require "lspconfig"
local lspsaga = require "lspsaga"
lspsaga.init_lsp_saga()

require("trouble").setup {}

local custom_attach = function(client, bufnr)
  local wk = require "which-key"

  wk.register({
    ["<C-f>"] = {
      "<cmd>lua require'lspsaga.action'.smart_scroll_with_saga(1)<CR>",
      "Smart Scroll with Saga (Forward)",
    },
    ["<C-b>"] = {
      "<cmd>lua require'lspsaga.action'.smart_scroll_with_saga(-1)<CR>",
      "Smart Scroll with Saga (Backward)",
    },
  }, {
    buffer = bufnr,
    nowait = true,
  })

  wk.register({
    name = "+lsp (buffer)",
    a = { "<cmd>Lspsaga code_action<CR>", "Code Action" },
    d = { "<cmd>Lspsaga preview_definition<CR>", "Preview Definition" },
    e = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Show Line Diagnostics" },
    f = { "<cmd>Lspsaga lsp_finder<CR>", "Find symbols" },
    h = { "<cmd>Lspsaga hover_doc<CR>", "Hover Doc" },
    R = { "<cmd>Lspsaga rename<CR>", "Rename" },
    ["?"] = { "<cmd>Lspsaga signature_help<CR>", "Signature Help" },
    ["["] = {
      "<cmd>Lspsaga diagnostic_jump_prev<CR>",
      "Jump to Previous Diagnostic",
    },
    ["]"] = {
      "<cmd>Lspsaga diagnostic_jump_next<CR>",
      "Jump to Next Diagnostic",
    },
    D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
    -- F = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Formatting" },
    i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition" },
    r = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "References" },
    o = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Document Symbols" },
  }, {
    prefix = "m",
    buffer = bufnr,
  })

  wk.register({
    name = "+lsp (buffer)",
    a = { "<cmd>Lspsaga range_code_action<CR>", "Range Code Action" },
  }, {
    mode = "v",
    prefix = "m",
    buffer = bufnr,
  })

  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end
  -- key mappings

  vim.cmd [[augroup user_plugin_lspconfig]]
  vim.cmd [[autocmd! * <buffer>]]
  vim.cmd [[augroup END]]

  if client.resolved_capabilities.document_formatting then
    wk.register(
      { ["F"] = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Formatting" } },
      { mode = "n", prefix = "m", buffer = bufnr }
    )
    vim.cmd [[autocmd user_plugin_lspconfig BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
    -- vim.cmd [[autocmd user_plugin_lspconfig BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
  end

  if client.resolved_capabilities.document_range_formatting then
    wk.register({
      ["="] = {
        "<cmd>lua vim.lsp.buf.range_formatting()<CR>",
        "Range Formatting",
      },
    }, {
      mode = "n",
      prefix = "m",
      buffer = bufnr,
    })
    wk.register({
      ["="] = {
        "<cmd>lua vim.lsp.buf.range_formatting()<CR>",
        "Range Formatting",
      },
    }, {
      mode = "x",
      prefix = "m",
      buffer = bufnr,
    })
  end

  if client.resolved_capabilities.goto_definition then
    wk.register({
      ["<C-]>"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
    }, {
      mode = "n",
      buffer = bufnr,
    })
  end

  if client.resolved_capabilities.document_highlight then
    vim.cmd [[autocmd user_plugin_lspconfig CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
    vim.cmd [[autocmd user_plugin_lspconfig CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
  end
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown" }
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true
updated_capabilities.textDocument.completion.completionItem.preselectSupport = true
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
updated_capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
updated_capabilities.textDocument.completion.completionItem.deprecatedSupport = true
updated_capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
updated_capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
updated_capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

-- https://github.com/bash-lsp/bash-language-server
lspconfig.bashls.setup { on_attach = custom_attach }

-- https://clangd.llvm.org/installation.html
lspconfig.bashls.setup {
  on_attach = custom_attach,
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
}

-- https://github.com/regen100/cmake-language-server
if vim.fn.executable "cmake-language-server" == 1 then
  lspconfig.cmake.setup { on_attach = custom_attach }
end

-- https://github.com/vscode-langservers/vscode-css-languageserver-bin
lspconfig.cssls.setup {
  on_attach = custom_attach,
  filetypes = { "css", "scss", "less", "sass" },
  root_dir = lspconfig.util.root_pattern("package.json", ".git"),
}

-- https://github.com/hansec/fortran-language-server
if vim.fn.executable "fortran-language-server" == 1 then
  lspconfig.fortls.setup { on_attach = custom_attach }
end

-- https://github.com/golang/tools/tree/master/gopls
lspconfig.gopls.setup {
  on_attach = custom_attach,
  cmd = { "gopls", "--remote=auto" },
  capabilities = updated_capabilities,
  init_options = { usePlaceholders = true, completeUnimported = true },
}

-- https://github.com/vscode-langservers/vscode-html-languageserver-bin
lspconfig.html.setup { on_attach = custom_attach }

-- https://github.com/vscode-langservers/vscode-json-languageserver
lspconfig.jsonls.setup { on_attach = custom_attach }

-- https://github.com/microsoft/pyright
lspconfig.pyright.setup {
  on_attach = custom_attach,
  settings = { python = { formatting = { provider = "black" } } },
}

-- https://github.com/rust-analyzer/rust-analyzer
-- https://github.com/simrat39/rust-tools.nvim

require("rust-tools").setup {
  server = { on_attach = custom_attach, capabilities = updated_capabilities },
}

-- lspconfig.rust_analyzer.setup {
--   on_attach = custom_attach,
--   capabilities = snippet_capabilities,
-- }

-- https://solargraph.org/
lspconfig.solargraph.setup { on_attach = custom_attach }

-- https://github.com/sumneko/lua-language-server
local system_name
if globals.is_mac then
  system_name = "macOS"
elseif globals.is_linux then
  system_name = "Linux"
elseif globals.is_iindows then
  system_name = "Windows"
else
  print "Unsupported system for sumneko"
end
local sumneko_root_path = vim.fn.expand "$HOME/src/github.com/sumneko/lua-language-server"
local sumneko_binary = string.format("%s/bin/%s/lua-language-server", sumneko_root_path, system_name)
lspconfig.sumneko_lua.setup {
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  on_attach = custom_attach,
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
}

-- https://github.com/iamcco/vim-language-server
lspconfig.vimls.setup { on_attach = custom_attach }

-- https://github.com/redhat-developer/yaml-language-server
lspconfig.yamlls.setup { on_attach = custom_attach }

-- Using null-ls for formatting buffers
-- https://github.com/jose-elias-alvarez/null-ls.nvim
local null_ls = require "null-ls"
local b = null_ls.builtins
local sources = {
  b.formatting.black,
  b.formatting.cmake_format,
  b.formatting.prettier.with {
    filetypes = { "html", "json", "yaml", "markdown" },
  },
  b.formatting.shfmt.with {
    args = { "-ln", "bash", "-i", "2", "-bn", "-ci", "-sr", "-kp" },
  },
  b.formatting.stylua,
  b.diagnostics.shellcheck,
  b.code_actions.gitsigns,
}

null_ls.config { sources = sources }

lspconfig["null-ls"].setup { on_attach = custom_attach }
