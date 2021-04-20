local M = {}
function M.setup()
  vim.keymap.nnoremap { "<Space>v", "<cmd>Vista!!<CR>", silent = true }

  vim.g.vista_default_executive = "ctags"
  vim.g.vista_executive_for = {
    c = "nvim_lsp",
    cpp = "nvim_lsp",
    css = "nvim_lsp",
    dockerfile = "nvim_lsp",
    fortran = "nvim_lsp",
    go = "nvim_lsp",
    lua = "nvim_lsp",
    javascript = "nvim_lsp",
    python = "nvim_lsp",
    ruby = "nvim_lsp",
    rust = "nvim_lsp",
    sh = "nvim_lsp",
    tex = "nvim_lsp",
    typescript = "nvim_lsp",
  }
end

return M
