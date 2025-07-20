local buffer = require "blink.cmp.sources.buffer"
local M = {}

---@type LazyKeysLspSpec[]|nil
M._keys = nil

---@alias LazyKeysLspSpec LazyKeysSpec|{has?:string|string[], cond?:fun():boolean}
---@alias LazyKeysLsp LazyKeys|{has?:string|string[], cond?:fun():boolean}

---@return LazyKeysLspSpec[]
M.get_keys = function()
  if M._keys then
    return M._keys
  end

  -- Keymaps common to the all LSP server
  M._keys = {
    { "<Space>cl", "<cmd>LspInfo<CR>", desc = "Lsp Info" },
    { "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "textDocument/definition" },
    { "gr", vim.lsp.buf.references, desc = "Goto References", nowait = true, has = "textDocument/references" },
    { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation", has = "textDocument/implementation" },
    { "gy", vim.lsp.buf.type_definition, desc = "Goto Type Defintiion", has = "textDocument/typeDefinition" },
    { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration", has = "textDocument/declaration" },
    {
      "K",
      function()
        return vim.lsp.buf.hover()
      end,
      desc = "Hover",
    },
    {
      "gK",
      function()
        return vim.lsp.buf.signature_help()
      end,
      desc = "Signature Help",
      has = "textDocument/signatureHelp",
    },
    {
      "<C-k>",
      function()
        return vim.lsp.buf.signature_help()
      end,
      mode = { "i" },
      desc = "Signature Help",
      has = "textDocument/signatureHelp",
    },
    {
      "<Space>ca",
      vim.lsp.buf.code_action,
      mode = { "n", "v" },
      desc = "Code Action",
      has = "textDocument/codeAction",
    },
    { "<Space>cr", vim.lsp.buf.rename, desc = "Rename", has = "textDocument/rename" },
    {
      "<Space>cR",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
      has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
    },
    { "<Space>cc", vim.lsp.codelens.run, mode = { "n", "v" }, desc = "CodeLens", has = "textDocument/codeLens" },
    {
      "<Space>cC",
      vim.lsp.codelens.refresh,
      desc = "Refresh & Display CodeLens",
      mode = { "n" },
      has = "textDocument/codeLens",
    },
    { "<Space>cA", require("rc.utils.lsp").action.source, desc = "Source Action", has = "textDocument/codeAction" },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
      has = "textDocument/documentHighlight",
      cond = function()
        return Snacks.words.is_enabled()
      end,
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
      has = "textDocument/documentHighlight",
      cond = function()
        return Snacks.words.is_enabled()
      end,
    },
    {
      "<M-n>",
      function()
        Snacks.words.jump(vim.v.count1, true)
      end,
      desc = "Next Reference",
      has = "textDocument/documentHighlight",
      cond = function()
        return Snacks.words.is_enabled()
      end,
    },
    {
      "<M-p>",
      function()
        Snacks.words.jump(-vim.v.count1, true)
      end,
      desc = "Prev Reference",
      has = "textDocument/documentHighlight",
      cond = function()
        return Snacks.words.is_enabled()
      end,
    },
  }

  return M._keys
end

---@param bufnr number
---@return LazyKeysLsp[]
M.resolve = function(bufnr)
  local Keys = require "lazy.core.handler.keys"
  local lazy_utils = require "rc.utils.lazy"
  if not Keys.resolve() then
    return {}
  end
  local spec = vim.tbl_extend("force", {}, M.get_keys())
  local opts = lazy_utils.get_plugin_opts "nvim-lspconfig"
  local clients = vim.lsp.get_clients { bufnr = bufnr }
  for _, client in ipairs(clients) do
    local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
    vim.list_extend(spec, maps)
  end
  return Keys.resolve(spec)
end

---@param method string|string[]
---@return boolean
M.has_method = function(bufnr, method)
  if type(method) == "table" then
    for _, m in ipairs(method) do
      return M.has_method(bufnr, m)
    end
    return false
  end
  local clients = vim.lsp.get_clients { bufnr = bufnr }
  return vim.iter(clients):any(function(client)
    return client:supports_method(method)
  end)
end

M.on_attach = function(_, bufnr)
  local Keys = require "lazy.core.handler.keys"
  local keymaps = M.resolve(bufnr)
  for _, key in pairs(keymaps) do
    local has_method = not key.has or M.has_method(bufnr, key.has)
    local cond = not (key.cond == false or ((type(key.cond) == "function") and not key.cond()))
    if has_method and cond then
      ---@type LazyKeysLsp|vim.keymap.set.Opts
      local opts = Keys.opts(key)
      opts.cond = nil
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = bufnr
      ---@cast opts vim.keymap.set.Opts
      vim.keymap.set(key.mode or "n", key.lhs, key.rhs, opts)
    end
  end
end

return M
