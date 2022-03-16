local bufnr = vim.api.nvim_get_current_buf()
local opts = { buffer = bufnr, silent = true }
vim.keymap.set("i", "<CR>", "<Esc><Cmd>close<CR>", opts)
vim.keymap.set("i", "jj", "<Esc><Cmd>close<CR>", opts)
vim.keymap.set("n", "<CR>", "<Cmd>close<CR>", opts)
