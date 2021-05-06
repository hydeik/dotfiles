local M = {}

function M.config()
  local wk = require("which-key")
  wk.setup {
    plugins = { presets = { operators = false } },
    operators = {
      d = "Delete",
      c = "Change",
      y = "Yank (copy)",
      ["g~"] = "Toggle case",
      ["gu"] = "Lowercase",
      ["gU"] = "Uppercase",
      [">"] = "Indent right",
      ["<lt>"] = "Indent left",
      ["zf"] = "Create fold",
      ["!"] = "Filter though external program",
      ["v"] = "Visual Character Mode",
      ["_"] = "Replace",
      gc = "Comments",
      ma = "Code Action (range)",
      sa = "Sandwich Add",
      sd = "Sandwich Delete",
      sr = "Sandwich Replace",
      ["<Leader>a"] = "EasyAlign",
    },
    window = { border = "shadow" },
  }

  wk.register(
    {
      ["<Space>d"] = {
        name = "+dap",
        c = { "Commends" },
        C = { "Configurations" },
        l = { "List Breakpoints" },
        v = { "Variables" },
      },
      ["<Space>e"] = {
        name = "+edit",
        n = "Edit Nvim Config",
        z = "Edit Zsh Config",
      },
      ["<Space>f"] = {
        name = "+files",
        d = { "Find File" },
        D = { "Find File (All)" },
        e = { "File Browser" },
        g = { "Live Grep" },
        G = { "Grep Files" },
        o = { "Old Files (frecency)" },
        t = { "Git Files" },
        ["/"] = { "Grep Last Search" },
        b = { "Buffers" },
        h = { "Help Tags" },
        f = { "Fuzzy Find (current buffer)" },
      },
      ["<Space>g"] = {
        name = "+git",
        b = { "Git Branch" },
        c = { "Git BCommit" },
        C = { "Git Commit" },
        l = { "LazyGit" },
        s = { "Git Status" },
      },
      ["<Space>l"] = {
        name = "+lsp",
        a = { "CodeActions" },
        r = { "References" },
        s = { "Document Symbols" },
        S = { "Workspace Symbols" },
      },
    }
  )

  -- LSP
  wk.register(
    {
      m = {
        a = { "Code Action" },
        d = { "Preview Definition" },
        D = { "Declaration" },
        e = { "Show Line Diagnostics" },
        F = { "Formatting" },
        i = { "Implementaion" },
        t = { "Type Definitions" },
        r = { "Rename" },
        o = { "Document Symbols" },
        ["?"] = { "Signature Help" },
        ["]"] = { "Next Diagnostic" },
        ["["] = { "Previous Diagnostic" },
      },
      { buffer = 0 },
    }
  )

  -- Text objects
  local textobjs = {
    a = {
      b = { "a sandwich-between block" },
      s = { "a sandwich-query block" },
      f = { "a function block (treesitter)" },
      C = { "a class block (treesitter)" },
      c = { "a conditional block (treesitter)" },
      e = { "a code block (treesitter)" },
      l = { "a loop (treesitter)" },
      S = { "a statement block (treesitter)" },
      d = { "a comment block (treesitter)" },
      m = { "a call block(treesitter)" },
      ["%"] = { "a block match-up" },
    },
    i = {
      b = { "inner sandwich-between" },
      s = { "inner sandwich-query" },
      f = { "inner function (treesitter)" },
      C = { "inner class (treesitter)" },
      c = { "inner conditional (treesitter)" },
      e = { "inner block (treesitter)" },
      l = { "inner loop (treesitter)" },
      S = { "inner statement (treesitter)" },
      d = { "inner comment (treesitter)" },
      m = { "inner call (treesitter)" },
      ["%"] = { "inner match-up" },
    },
  }

  wk.register(textobjs, { mode = "o" })
  wk.register(textobjs, { mode = "x" })
end

return M
