local wk = require "which-key"
wk.setup {
  plugins = { spelling = { enabled = true }, presets = { operators = false } },
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
    gb = "Comments (block)",
    gc = "Comments (line)",
    ma = "Code Action (range)",
    sa = "Sandwich Add",
    sd = "Sandwich Delete",
    sr = "Sandwich Replace",
    ["<Leader>a"] = "EasyAlign",
  },
  window = { border = "shadow" },
}

-- <Space> mappings
wk.register {
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
    g = { "Live Grep (fzf_writer)" },
    G = { "Grep Files" },
    o = { "Old Files (frecency)" },
    ["/"] = { "Grep Last Search" },
    b = { "Buffers" },
    h = { "Help Tags" },
    f = { "Fuzzy Find (current buffer)" },
  },
  ["<Space>g"] = {
    name = "+git",
    b = { "Git Branch" },
    c = { "Git Commits (buffer)" },
    C = { "Git Commits" },
    f = { "Git files" },
    l = { "LazyGit" },
    m = { "Git Messenger" },
    s = { "Git Status" },
    S = { "Git Stash" },
  },
  ["<Space>l"] = {
    name = "+lsp",
    a = { "CodeActions" },
    d = { "Definitions" },
    e = { "Document Diagnostics" },
    E = { "Workspace Diagnostics" },
    r = { "References" },
    s = { "Document Symbols" },
    S = { "Workspace Symbols" },
    t = { "Treesitter" },
  },
  ["<Space>t"] = {
    name = "+toggle UI",
    c = { "toggle hilight of the current column" },
    l = { "toggle hilight of the current line" },
    n = { "toggle line numbers" },
    h = { "toggle control characters" },
    p = { "toggle paste mode" },
    s = { "toggle spell checking" },
    w = { "toggle wrap" },
  },
}
-- <Leader> mapping
wk.register {
  ["<Leader>"] = {
    ["1"] = { "go to buffer 1" },
    ["2"] = { "go to buffer 2" },
    ["3"] = { "go to buffer 3" },
    ["4"] = { "go to buffer 4" },
    ["5"] = { "go to buffer 5" },
    ["6"] = { "go to buffer 6" },
    ["7"] = { "go to buffer 7" },
    ["8"] = { "go to buffer 8" },
    ["9"] = { "go to buffer 9" },
    a = { "EasyAlign" },
    d = { "Generate document (vim-doge)" },
    J = { "JPlus" },
    q = { "quit" },
    Q = { "quit all (:qall)" },
    s = { "Swap arguments (next)" },
    S = { "Swap arguments (previous)" },
    x = { "Delete trailing whitespace" },
    w = { "write" },
    W = { "write all (:wall)" },
  },
}
wk.register({
  ["<Leader>"] = {
    a = { "EasyAlign" },
    J = { "JPlus" },
    q = { "quit" },
    Q = { "quit all (:qall)" },
    x = { "Delete trailing whitespace" },
    w = { "write" },
    W = { "write all (:wall)" },
  },
}, {
  mode = "v",
})

-- s-mappings [Window manager / sandwich / search]
wk.register {
  s = {
    -- window manager
    t = { "Open new tab" },
    c = { "Close current window (:close)" },
    o = { "Close other window (:only)" },
    ["-"] = { "split" },
    ["|"] = { "vsplit" },
    ["="] = { "equal size window" },
    -- vim-sandwich
    a = { "sandwich add" },
    d = { "sandwich delete" },
    r = { "sandwich replace" },
    -- hop.nvim
    s = { "jump to a suite of two characters (hop.nvim)" },
    l = { "jump to a line with avy (hop.nvim)" },
    ["/"] = { "jump to a mathced pattern (hop.nvim)" },
  },
}

wk.register({
  s = {
    -- vim-sandwich
    a = { "sandwich add" },
    d = { "sandwich delete" },
    r = { "sandwich replace" },
    -- hop.nvim
    s = { "jump to a suite of two characters (hop.nvim)" },
    l = { "jump to a line with avy (hop.nvim)" },
    ["/"] = { "jump to a mathced pattern (hop.nvim)" },
  },
}, {
  mode = "o",
})

wk.register({
  s = {
    -- vim-sandwich
    a = { "sandwich add" },
    d = { "sandwich delete" },
    r = { "sandwich replace" },
    -- hop.nvim
    s = { "jump to a suite of two characters (hop.nvim)" },
    l = { "jump to a line with avy (hop.nvim)" },
    ["/"] = { "jump to a mathced pattern (hop.nvim)" },
  },
}, {
  mode = "x",
})

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
    u = { "a unit (treesitter)" },
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
    u = { "inner unit (treesitter)" },
    ["%"] = { "inner match-up" },
  },
}

wk.register(textobjs, { mode = "o" })
wk.register(textobjs, { mode = "x" })
