-- A Vim plugin to provide some operators to convert a word case.
return {
  "mopp/vim-operator-convert-case",
  dependencies = {
    { "kana/vim-operator-user" },
    { "tpope/vim-repeat" },
  },
  cmd = { "ConvertCaseToggleUpperLower", "ConvertCaseLoop", "ConvertCase" },
  keys = {
    { "<Plug>(operator-convert-case-", mode = "n" },
    { "<Plug>(operator-convert-case-", mode = "x" },
  },
  init = function()
    vim.keymap.set("n", "~", "<Plug>(operator-convert-case-loop)")
    vim.keymap.set("x", "~", "<Plug>(operator-convert-case-loop)gv")
  end,
}
