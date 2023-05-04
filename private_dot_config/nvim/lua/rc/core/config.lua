local M = {}

-- colorscheme can be a string like `catppuccin` or a function that will load the colorscheme
---@type string|fun()
M.colorscheme = "kanagawa"

-- icons used by other plugins
---@type table
M.icons = {
  cmp = {
    Copilot = "",
    Copilot_alt = "",
    nvim_lsp = "",
    nvim_lua = "",
    path = "",
    buffer = " ",
    calc = "",
    emoji = "ﲃ",
    spell = "暈",
    latex_symbols = "",
    luasnip = "",
    treesitter = "",
  },
  dap = {
    Stopped = { "", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint = " ",
    BreakpointCondition = "",
    BreakpointRejected = { "", "DiagnosticError" },
    LogPoint = "",
  },
  diagnostics = {
    Error = " ", -- U+EA87
    Warn = " ", -- U+EA6C
    Hint = " ", -- U+EA6B
    Info = " ", -- U+EA74
    Ok = " ", -- U+EAB2
  },
  git = {
    added = " ", -- U+EADC
    modified = " ", -- U+EADE
    removed = " ", -- U+EADF
  },
  status = {
    line_number = "",
    column_number = "",
    folder = "",
    root_folder = "",
    git = "",
    branch = "",
    vimode = "",
    lsp = "",
    dap = "",
    treesitter = "",
  },
  kinds = {
    Array = " ", -- U+EA8A
    Boolean = " ", -- U+EA8F
    Class = " ", -- U+EB5B
    Color = " ", -- U+EB5C
    Constant = " ", -- U+EB5D
    Constructor = " ", -- U+EA8C
    Enum = " ", -- U+EA95
    EnumMember = " ", -- U+EA95
    Event = " ", -- U+EA86
    Field = " ", -- U+EB5F
    File = " ", -- U+EA7B
    Folder = " ", -- U+EA83
    Function = " ", -- U+EA8C
    Interface = " ", -- U+EB61
    Key = " ", -- U+EA93
    Keyword = " ", -- U+EB62
    Method = " ", -- U+EA8C
    Module = " ", -- U+EB29
    Namespace = " ", -- U+EA8B
    Null = "ﳠ ", -- U+FCE0 (obsolete)
    Number = " ", -- U+EA90
    Object = " ", -- U+EA8B
    Operator = " ", -- U+EB64
    Package = " ", -- U+EA92
    Property = " ", -- U+EB65
    Reference = " ", -- U+EB36
    Snippet = " ", -- U+EB66
    String = " ", -- U+EB8D
    Struct = " ", -- U+EA91
    Text = " ", -- U+EA93
    TypeParameter = " ", -- U+EA92
    Unit = " ", -- U+EA96
    Value = " ", -- U+EA93
    Variable = " ", -- U+EA88
  },
}

return M
