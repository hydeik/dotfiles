local M = {}

function M.on_filetype()
  if string.find(vim.fn.execute("filetype"), "OFF") ~= nil then
    if vim.b.did_ftplugin == nil then
      vim.cmd [[runtime! after/ftplugin.vim]]
    end
    return
  end
  vim.cmd [[
    filetype plugin indent on
    PackerLoad nvim-treesitter
    filetype detect
  ]]
end

return M
