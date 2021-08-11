local M = {}

function M.config()
  local luasnip = require "luasnip"
  luasnip.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
  }

  require("luasnip.loaders.from_vscode").load {
    paths = { vim.fn.stdpath "config" .. "/snippets" },
  }

  -- key mappings
  vim.keymap.imap {
    "<C-k>",
    "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-k>'",
    expr = true,
    silent = true,
  }
  vim.keymap.smap {
    "<C-k>",
    "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-k>'",
    expr = true,
    silent = true,
  }
  vim.keymap.imap {
    "<C-j>",
    "luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<C-j>'",
    expr = true,
    silent = true,
  }
  vim.keymap.smap {
    "<C-j>",
    "luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<C-j>'",
    expr = true,
    silent = true,
  }
  vim.keymap.imap {
    "<C-e>",
    "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<End>'",
    expr = true,
    silent = true,
  }
  vim.keymap.smap {
    "<C-e>",
    "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-e>'",
    expr = true,
    silent = true,
  }
end

return M
