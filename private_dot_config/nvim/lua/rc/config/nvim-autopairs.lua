local M = {}

function M.config()
  require("nvim-autopairs").setup {
    disabled_filetype = { "TelescopePrompt" },
    map_cr = false,
  }
end

return M
