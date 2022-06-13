-- [nvim-pasta](https://github.com/hrsh7th/nvim-pasta)
--
-- The yank/paste enhancement plugin for neovim.
--
return {
  "hrsh7th/nvim-pasta",
  module = { "pasta" },
  setup = function()
    vim.keymap.set({ 'n', 'x' }, 'p', require('pasta.mappings').p)
    vim.keymap.set({ 'n', 'x' }, 'P', require('pasta.mappings').P)
  end,
  config = function()
    require('pasta').setup {
      converters = {
        require('pasta.converters').indentation,
      },
      paste_mode = true,
      next_key = vim.api.nvim_replace_termcodes('<C-p>', true, true, true),
      prev_key = vim.api.nvim_replace_termcodes('<C-n>', true, true, true),
    }
  end,
}
