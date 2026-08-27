local M = {}

---@alias LazyKeysLspSpec LazyKeysSpec|{has?:string|string[], enabled?:fun():boolean}
---@alias LazyKeysLsp LazyKeys|{has?:string|string[], enabled?:fun():boolean}

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

---@param filter vim.lsp.get_clients.Filter
---@param spec LazyKeysLspSpec[]
M.set = function(filter, spec)
  local Keys = require "lazy.core.handler.keys"
  for _, keys in pairs(Keys.resolve(spec)) do
    ---@cast keys LazyKeysLsp
    local filters = {} ---@type vim.lsp.get_clients.Filter[]
    if keys.has then
      local methods = type(keys.has) == "string" and { keys.has } or keys.has --[[@as string[] ]]
      for _, method in ipairs(methods) do
        method = method:find "/" and method or ("textDocument/" .. method)
        filters[#filters + 1] = vim.tbl_extend("force", vim.deepcopy(filter), { method = method })
      end
    else
      filters[#filters + 1] = filter
    end

    for _, f in ipairs(filters) do
      local opts = Keys.opts(keys)
      ---@cast opts snacks.keymap.set.Opts
      opts.lsp = f
      opts.enabled = keys.enabled
      Snacks.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
    end
  end
end

return M
