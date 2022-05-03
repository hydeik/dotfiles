local M = {}

function M.config()
  require("todo-comments").setup {
    keywords = {
      TODO = { alt = { "WIP" } },
    },
  }
end

return M
