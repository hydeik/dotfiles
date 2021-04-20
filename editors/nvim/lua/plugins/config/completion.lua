local M = {}
function M.config()
  local compe = require("compe")
  compe.setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "always",
    source = {
      path = true,
      buffer = true,
      calc = true,
      emoji = true,
      vsnip = true,
      nvim_lsp = true,
      nvim_lua = true,
      spell = true,
      tags = true,
      snippets_nvim = false,
      treesitter = true,
    },
  }

  -- key mappings
  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end
  local check_backspace = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
      return true
    else
      return false
    end
  end
  _G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t("<C-n>")
    elseif vim.fn["vsnip#available"](1) == 1 then
      return t("<Plug>(vsnip-expand-or-jump)")
    elseif check_backspace() then
      return t("<Tab>")
    else
      return vim.fn["compe#complete"]()
    end
  end
  _G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t("<C-p>")
    elseif vim.fn["vsnip#jumpable"](-1) == 1 then
      return t("<Plug>(vsnip-jump-prev)")
    else
      return t("<S-Tab>")
    end
  end

  vim.keymap.inoremap {
    "<C-Space>",
    [[compe#complete()]],
    expr = true,
    silent = true,
  }
  vim.keymap.inoremap {
    "<C-e>",
    [[compe#close('<C-e>')]],
    expr = true,
    silent = true,
  }
  vim.keymap.inoremap {
    "<CR>",
    [[compe#confirm('<CR>')]],
    expr = true,
    silent = true,
  }
  vim.keymap.imap { "<Tab>", [[v:lua.tab_complete()]], expr = true }
  vim.keymap.smap { "<Tab>", [[v:lua.tab_complete()]], expr = true }
  vim.keymap.imap { "<S-Tab>", [[v:lua.s_tab_complete()]], expr = true }
  vim.keymap.smap { "<S-Tab>", [[v:lua.s_tab_complete()]], expr = true }
end

return M
