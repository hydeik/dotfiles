local globals = require ".globals"

-- vim.cmd [[packadd lua-dev.nvim]]
-- vim.cmd [[packadd null-ls.nvim]]
-- vim.cmd [[packadd rust-tools.nvim]]
-- vim.cmd [[packadd trouble.nvim]]

-- Change diagnostic symbols in the sign column (gutter)
local signs = { Error = "", Warning = "", Info = "", Hint = "" }
for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Completion kinds (icons for pum)
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

-- Borders for floating windows
local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

-- Handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = true,
  signs = { priority = 20 },
  update_in_insert = false,
})

-- [[ Configure LSP servers ]]
local lspconfig = require "lspconfig"

-- require("trouble").setup {}

local custom_attach = function(client, bufnr)
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

  local wk = require "which-key"
  wk.register({
    name = "+lsp (buffer)",
    a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
    e = {
      function()
        vim.lsp.diagnostic.show_line_diagnostics { border = border }
      end,
      "Show Line Diagnostics",
    },
    h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Doc" },
    R = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
    ["?"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
    ["["] = {
      function()
        vim.lsp.diagnostic.goto_prev { popup_opts = { border = border } }
      end,
      "Jump to Previous Diagnostic",
    },
    ["]"] = {
      function()
        vim.lsp.diagnostic.goto_next { popup_opts = { border = border } }
      end,
      "Jump to Next Diagnostic",
    },
    D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
    -- F = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Formatting" },
    i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition" },
    r = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "References" },
    o = { "<cmd>lua vim.lsp.buf.document_symbol()<CR>", "Document Symbols" },
  }, {
    prefix = "m",
    buffer = bufnr,
  })

  wk.register({
    name = "+lsp (buffer)",
    a = { "<cmd>lua vim.lsp.buf.range_code_action()<CR>", "Range Code Action" },
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
    -- vim.cmd [[autocmd user_plugin_lspconfig BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
    vim.cmd [[autocmd user_plugin_lspconfig BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
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
  wk.register({
  wk.register({
  wk.register({
  wk.register({
    name = "+lsp (buffer)",
    a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
    e = {
      function()
        vim.lsp.diagnostic.show_line_diagnostics { border = border }
      end,
      "Show Line Diagnostics",
    },
    h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Doc" },
    R = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
    ["?"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
    ["["] = {
      function()
        vim.lsp.diagnostic.goto_prev { popup_opts = { border = border } }
      end,
      "Jump to Previous Diagnostic",
    },
    ["]"] = {
      function()
        vim.lsp.diagnostic.goto_next { popup_opts = { border = border } }
      end,
      "Jump to Next Diagnostic",
    },
    D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
    -- F = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Formatting" },
    i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition" },
    r = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "References" },
    o = { "<cmd>lua vim.lsp.buf.document_symbol()<CR>", "Document Symbols" },
  }, {
    prefix = "m",
    buffer = bufnr,
  })

  wk.register({
    name = "+lsp (buffer)",
    a = { "<cmd>lua vim.lsp.buf.range_code_action()<CR>", "Range Code Action" },
  }, {
    mode = "v",
    prefix = "m",
    buffer = bufnr,
  })
    name = "+lsp (buffer)",
    a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
    e = {
      function()
        vim.lsp.diagnostic.show_line_diagnostics { border = border }
      end,
      "Show Line Diagnostics",
    },
    h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Doc" },
    R = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
    ["?"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
    ["["] = {
      function()
        vim.lsp.diagnostic.goto_prev { popup_opts = { border = border } }
      end,
      "Jump to Previous Diagnostic",
    },
    ["]"] = {
      function()
        vim.lsp.diagnostic.goto_next { popup_opts = { border = border } }
      end,
      "Jump to Next Diagnostic",
    },
    D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
    -- F = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Formatting" },
    i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition" },
    r = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "References" },
    o = { "<cmd>lua vim.lsp.buf.document_symbol()<CR>", "Document Symbols" },
  }, {
    prefix = "m",
    buffer = bufnr,
  })

  wk.register({
    name = "+lsp (buffer)",
    a = { "<cmd>lua vim.lsp.buf.range_code_action()<CR>", "Range Code Action" },
  }, {
    mode = "v",
    prefix = "m",
    buffer = bufnr,
  })
    name = "+lsp (buffer)",
    a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
    e = {
      function()
        vim.lsp.diagnostic.show_line_diagnostics { border = border }
      end,
      "Show Line Diagnostics",
    },
    h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Doc" },
    R = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
    ["?"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
    ["["] = {
      function()
        vim.lsp.diagnostic.goto_prev { popup_opts = { border = border } }
      end,
      "Jump to Previous Diagnostic",
    },
    ["]"] = {
      function()
        vim.lsp.diagnostic.goto_next { popup_opts = { border = border } }
      end,
      "Jump to Next Diagnostic",
    },
    D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
    -- F = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Formatting" },
    i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition" },
    r = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "References" },
    o = { "<cmd>lua vim.lsp.buf.document_symbol()<CR>", "Document Symbols" },
  }, {
    prefix = "m",
    buffer = bufnr,
  })

  wk.register({
    name = "+lsp (buffer)",
    a = { "<cmd>lua vim.lsp.buf.range_code_action()<CR>", "Range Code Action" },
  }, {
    mode = "v",
    prefix = "m",
    buffer = bufnr,
  })
    name = "+lsp (buffer)",
    a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
    e = {
      function()
        vim.lsp.diagnostic.show_line_diagnostics { border = border }
      end,
      "Show Line Diagnostics",
    },
    h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Doc" },
    R = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
    ["?"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
    ["["] = {
      function()
        vim.lsp.diagnostic.goto_prev { popup_opts = { border = border } }
      end,
      "Jump to Previous Diagnostic",
    },
    ["]"] = {
      function()
        vim.lsp.diagnostic.goto_next { popup_opts = { border = border } }
      end,
      "Jump to Next Diagnostic",
    },
    D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
    -- F = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Formatting" },
    i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition" },
    r = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "References" },
    o = { "<cmd>lua vim.lsp.buf.document_symbol()<CR>", "Document Symbols" },
  }, {
    prefix = "m",
    buffer = bufnr,
  })

  wk.register({
    name = "+lsp (buffer)",
    a = { "<cmd>lua vim.lsp.buf.range_code_action()<CR>", "Range Code Action" },
  }, {
    mode = "v",
    prefix = "m",
    buffer = bufnr,
  })
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
-- https://github.com/folke/lua-dev.nvim
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

local luadev = require("lua-dev").setup {
  lspconfig = {
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
  },
}
lspconfig.sumneko_lua.setup(luadev)

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
