-- [nvim_context_vt](https://github.com/haringsrob/nvim_context_vt)
--
-- Virtual text context for neovim treesitter
--
return {
  "haringsrob/nvim_context_vt",
  after = "nvim-treesitter",
  config = function()
    require("nvim_context_vt").setup {
      prefix = " ",
      disable_virtual_lines = false,
    }
  end,
}
