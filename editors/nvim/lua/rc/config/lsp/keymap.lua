local M = {}

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

function M.setup(client, bufnr)
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

  if client.resolved_capabilities.document_formatting then
    wk.register(
      { ["F"] = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Formatting" } },
      { mode = "n", prefix = "m", buffer = bufnr }
    )
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
  end
end

return M
