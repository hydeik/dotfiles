local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "q", "<Cmd>call ddu#ui#filer#do_action('quit')<CR>", {buffer = bufnr})
vim.keymap.set(
  "n", "<CR>",
  [[ddu#ui#filer#is_directory() ? <Cmd>ddu#ui#do_action('itemAction', {'name': 'narrow'})<CR> : <Cmd>ddu#ui#do_action('itemAction', {'name': 'open'})<CR>]],
  {buffer = bufnr, expr = true}
  )

