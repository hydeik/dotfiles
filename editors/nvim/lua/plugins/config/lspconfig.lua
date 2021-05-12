local globals = require("core.globals")

-- Icons for signcolumn and pum
local sign_define = vim.fn.sign_define
sign_define(
  "LspDiagnosticsErrorSign", { text = "", texthl = "LspDiagnosticError" }
)
sign_define(
  "LspDiagnosticsWarningSign", { text = "", texthl = "LspDiagnosticWarning" }
)
sign_define(
  "LspDiagnosticsInformationSign",
  { text = "", texthl = "LspDiagnosticInformtion" }
)
sign_define(
  "LspDiagnosticsHintSign", { text = "", texthl = "LspDiagnosticHint" }
)

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
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text = true,
      signs = { priority = 20 },
      update_in_insert = false,
    }
  )

vim.lsp.handlers["textDocument/formatting"] =
  function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then return end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
      local view = vim.fn.winsaveview()
      vim.lsp.util.apply_text_edits(result, bufnr)
      vim.fn.winrestview(view)
      if bufnr == vim.api.nvim_get_current_buf() then
        vim.api.nvim_command("noautocmd :update")
      end
    end
  end

-- [[ Configure LSP servers ]]
local lspconfig = require("lspconfig")
local lspsaga = require("lspsaga")
lspsaga.init_lsp_saga()

local custom_attach = function(client, bufnr)
  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

  local nnoremap = vim.keymap.nnoremap
  local vnoremap = vim.keymap.vnoremap
  local xnoremap = vim.keymap.xnoremap

  if client.config.flags then client.config.flags.allow_incremental_sync = true end
  -- key mappings
  nnoremap {
    "<C-f>",
    "<cmd>lua require'lspsaga.action'.smart_scroll_with_saga(1)<CR>",
    buffer = true,
    silent = true,
    nowait = true,
  }
  nnoremap {
    "<C-b>",
    "<cmd>lua require'lspsaga.action'.smart_scroll_with_saga(-1)<CR>",
    buffer = true,
    silent = true,
    nowait = true,
  }
  nnoremap { "ma", "<cmd>Lspsaga code_action<CR>", buffer = true, silent = true }
  vnoremap {
    "ma",
    ":<C-u>Lspsaga range_code_action<CR>",
    buffer = true,
    silent = true,
  }
  nnoremap {
    "md",
    "<cmd>Lspsaga preview_definition<CR>",
    buffer = true,
    silent = true,
  }
  nnoremap { "mf", "<cmd>Lspsaga lsp_finder<CR>", buffer = true, silent = true }
  nnoremap { "mh", "<cmd>Lspsaga hover_doc<CR>", buffer = true, silent = true }
  nnoremap {
    "m?",
    "<cmd>Lspsaga signature_help<CR>",
    buffer = true,
    silent = true,
  }
  nnoremap { "n", "mR", "<cmd>Lspsaga rename<CR>", buffer = true, silent = true }
  nnoremap {
    "m]",
    "<cmd>Lspsaga diagnostic_jump_next<CR>",
    buffer = true,
    silent = true,
  }
  nnoremap {
    "m[",
    "<cmd>Lspsaga diagnostic_jump_prev<CR>",
    buffer = true,
    silent = true,
  }
  nnoremap {
    "me",
    "<cmd>Lspsaga show_line_diagnostics<CR>",
    buffer = true,
    silent = true,
  }

  nnoremap {
    "mD",
    "<cmd>lua vim.lsp.buf.declaration()<CR>",
    buffer = true,
    silent = true,
  }
  nnoremap {
    "mF",
    "<cmd>lua vim.lsp.buf.formatting()<CR>",
    buffer = true,
    silent = true,
  }
  nnoremap {
    "mi",
    "<cmd>lua vim.lsp.buf.implementation()<CR>",
    buffer = true,
    silent = true,
  }
  nnoremap {
    "mt",
    "<cmd>lua vim.lsp.buf.type_definition()<CR>",
    buffer = true,
    silent = true,
  }
  nnoremap {
    "mr",
    "<cmd>lua vim.lsp.buf.references()<CR>",
    buffer = true,
    silent = true,
  }
  nnoremap {
    "mo",
    "<cmd>lua vim.lsp.buf.document_symbol()<cr>",
    buffer = true,
    silent = true,
  }

  vim.cmd [[augroup user_plugin_lspconfig]]
  vim.cmd [[autocmd! * <buffer>]]
  vim.cmd [[augroup END]]

  -- This won't work with efm-langserver
  -- if client.resolved_capabilities.document_formatting then
  --   vim.cmd [[autocmd user_plugin_lspconfig BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
  -- end
  local ft_auto_format = {
    "css",
    "go",
    "graphql",
    "json",
    "lua",
    "python",
    "rst",
    "ruby",
    "rust",
    "scss",
    "sh",
    "typescript",
    "vue",
    "yaml",
  }

  if vim.tbl_contains(ft_auto_format, filetype) then
    vim.cmd [[autocmd user_plugin_lspconfig BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
  end

  if client.resolved_capabilities.document_range_formatting then
    nnoremap {
      "m=",
      "<cmd>lua vim.lsp.buf.range_formatting()<CR>",
      buffer = true,
      silent = true,
    }
    xnoremap {
      "m=",
      "<cmd>lua vim.lsp.buf.range_formatting()<CR>",
      buffer = true,
      silent = true,
    }
  end

  if client.resolved_capabilities.goto_definition then
    nnoremap {
      "<C-]>",
      "<cmd>lua vim.lsp.buf.definition()<CR>",
      buffer = true,
      silent = true,
    }
  end

  if client.resolved_capabilities.document_highlight then
    vim.cmd [[autocmd user_plugin_lspconfig CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
    vim.cmd [[autocmd user_plugin_lspconfig CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
  end
end

local snippet_capabilities = vim.lsp.protocol.make_client_capabilities()
snippet_capabilities.textDocument.completion.completionItem.snippetSupport =
  true

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
if vim.fn.executable("cmake-language-server") == 1 then
  lspconfig.cmake.setup { on_attach = custom_attach }
end

-- https://github.com/vscode-langservers/vscode-css-languageserver-bin
lspconfig.cssls.setup {
  on_attach = custom_attach,
  filetypes = { "css", "scss", "less", "sass" },
  root_dir = lspconfig.util.root_pattern("package.json", ".git"),
}

-- https://github.com/mattn/efm-langserver
lspconfig.efm.setup {
  on_attach = custom_attach,
  root_dir = function(fname)
    return lspconfig.util.find_git_ancestor(fname) or
             lspconfig.util.path.dirname(fname)
  end,
  filetypes = {
    "asciidoc",
    "css",
    "csv",
    "dockerfile",
    "html",
    "json",
    "make",
    "markdown",
    "rst",
    "yaml",
    "blade",
    "elixir",
    "javascript",
    "lua",
    "python",
    "php",
    "ruby",
    "scss",
    "sh",
    "typescript",
    "vim",
  },
  init_options = {
    documentFormatting = true,
    -- hover = true,
    -- documentSymbol = true,
    codeAction = true,
    completion = true,
  },
}

-- https://github.com/hansec/fortran-language-server
if vim.fn.executable("fortran-language-server") == 1 then
  lspconfig.fortls.setup { on_attach = custom_attach }
end

-- https://github.com/golang/tools/tree/master/gopls
lspconfig.gopls.setup {
  on_attach = custom_attach,
  cmd = { "gopls", "--remote=auto" },
  capabilities = snippet_capabilities,
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
lspconfig.rust_analyzer.setup {
  on_attach = custom_attach,
  capabilities = snippet_capabilities,
}

-- https://solargraph.org/
lspconfig.solargraph.setup { on_attach = custom_attach }

-- https://github.com/sumneko/lua-language-server
local system_name
if globals.is_mac then
  system_name = "macOS"
elseif globals.is_linux then
  system_name = "Linux"
elseif globals.is_windows then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end
local sumneko_root_path = vim.fn.expand(
  '$HOME/src/github.com/sumneko/lua-language-server'
)
local sumneko_binary = string.format(
  "%s/bin/%s/lua-language-server", sumneko_root_path, system_name
)
lspconfig.sumneko_lua.setup {
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  on_attach = custom_attach,
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim', "packer_plugins" } },
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ";") },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}

-- https://github.com/iamcco/vim-language-server
lspconfig.vimls.setup { on_attach = custom_attach }

-- https://github.com/redhat-developer/yaml-language-server
lspconfig.yamlls.setup { on_attach = custom_attach }
