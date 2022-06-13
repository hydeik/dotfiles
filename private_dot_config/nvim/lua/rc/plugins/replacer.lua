-- [replacer.nvim](https://github.com/gabrielpoca/replacer.nvim)
--
-- It makes a quickfix list editable in both content and file path.
--
return {
  "gabrielpoca/replacer.nvim",
  ft = { "qf" },
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      group = "MyAutoCmd",
      pattern = { "qf" },
      callback = function()
        vim.keymap.set("n", "R", "<cmd>lua require'replacer'.run()<CR>", { buffer = true, silent = true })
      end,
    })
  end,
}
