local M = {}

function M.config()
  local cache_dir = require("globals").nvim_dir.cache
  vim.g["eskk#directory"] = cache_dir .. "/eskk"

  vim.g["eskk#dictionary"] = {
    path = cache_dir .. "/skk-jisyo",
    sorted = 1,
    encoding = "utf-8",
  }

  if vim.fn.has "mac" then
    vim.g["eskk#large_dictionary"] = {
      path = "~/Library/Application Support/AquaSKK/SKK-JISYO.L",
      sorted = 1,
      encoding = "euc-jp",
    }
  elseif vim.fn.has "win32" or vim.fn.has "win64" then
    vim.g["eskk#large_dictionary"] = {
      path = "~/SKK-JISYO.L",
      sorted = 1,
      encoding = "euc-jp",
    }
  else
    vim.g["eskk#large_dictionary"] = {
      path = "/usr/local/share/skk/SKK-JISYO.L",
      sorted = 1,
      encoding = "euc-jp",
    }
  end

  vim.g["eskk#server"] = { host = "localhost", port = 1178 }

  -- Henkan, annotation
  vim.g["eskk#show_annotation"] = 1
  vim.g["eskk#keep_state"] = 0
  vim.g["eskk#debug"] = 0
  vim.g["eskk#show_annotation"] = 1
  vim.g["eskk#egg_like_newline"] = 1
  vim.g["eskk#egg_like_newline_completion"] = 1
  vim.g["eskk#tab_select_completion"] = 1
  vim.g["eskk#start_completion_length"] = 2

  -- Key mappings
  vim.api.nvim_set_keymap("i", "<C-j>", "<Plug>(eskk:toggle)", { silent = true })
  vim.api.nvim_set_keymap("c", "<C-j>", "<Plug>(eskk:toggle)", { silent = true })

  -- easy escape with 'jj'
  require("utils.autocmd").group("MyAutoCmd", {
    { "User", "eskk-initialize-post", "Eskk -remap jj <ESC>" },
  })
end

return M
