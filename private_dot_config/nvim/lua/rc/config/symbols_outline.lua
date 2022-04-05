local M = {}

function M.setup()
vim.g.symbols_outline = {
  highlight_hovered_item = true,
  show_guides = true,
}
vim.keymap.set("n", "ms", "<Cmd>SymbolsOutline<CR>", { silent = true })
end

return M
