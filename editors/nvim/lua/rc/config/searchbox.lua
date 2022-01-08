local M = {}

function M.setup()
  vim.keymap.set("n", "<Leader>/", "<Cmd>lua require'searchbox'.incsearch()<CR>")
  vim.keymap.set("n", "<Leader>?", "<Cmd>lua require'searchbox'.incsearch{ reverse = true }<CR>")
end

function M.config()
  require("searchbox").setup {
    popup = {
      relative = "win",
      position = {
        row = "5%",
        col = "95%",
      },
      size = 30,
      border = {
        style = "rounded",
        highlight = "FloatBorder",
        text = {
          top = " Search ",
          top_align = "left",
        },
      },
      win_options = {
        winhighlight = "Normal:Normal",
      },
    },
    -- hooks = {
    --   before_mount = function() end,
    --   after_mount = function() end,
    -- },
  }
end

return M
