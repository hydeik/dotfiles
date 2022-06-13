-- [vim-operator-convert-case](https://github.com/mopp/vim-operator-convert-case)
--
-- a Vim plugin to provide some operators to convert a word case.
--
return {
    "mopp/vim-operator-convert-case",
    requires = {
      { "kana/vim-operator-user" },
      { "tpope/vim-repeat" },
    },
    cmd = { "ConvertCaseToggleUpperLower", "ConvertCaseLoop", "ConvertCase" },
    keys = {
      { "n", "<Plug>(operator-convert-case-" },
      { "x", "<Plug>(operator-convert-case-" },
    },
    setup = function()
      vim.keymap.set("n", "~", "<Plug>(operator-convert-case-loop)")
      vim.keymap.set("x", "~", "<Plug>(operator-convert-case-loop)gv")
    end
  }
