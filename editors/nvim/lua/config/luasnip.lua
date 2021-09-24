local M = {}

function M.config()
  local luasnip = require "luasnip"
  luasnip.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
  }

  local nvim_dir = require("globals").nvim_dir
  require("luasnip.loaders.from_vscode").load {
    paths = {
      nvim_dir.config .. "/snippets",
      nvim_dir.site_packages .. "/pack/packer/start/friendly-snippets/snippets",
    },
  }

  -- key mappings
  local keymap = require "utils.keymap"
  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  local check_back_space = function()
    local col = vim.fn.col "." - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match "%s" then
      return true
    else
      return false
    end
  end

  _G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t "<C-n>"
    elseif luasnip and luasnip.expand_or_jumpable() then
      return t "<Plug>luasnip-expand-or-jump"
    elseif check_back_space() then
      return t "<Tab>"
    else
      return vim.fn["compe#complete"]()
    end
  end
  _G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t "<C-p>"
    elseif luasnip and luasnip.jumpable(-1) then
      return t "<Plug>luasnip-jump-prev"
    else
      return t "<S-Tab>"
    end
  end
  keymap.imap { "<Tab>", "v:lua.tab_complete()", expr = true, silent = true }
  keymap.smap { "<Tab>", "v:lua.tab_complete()", expr = true, silent = true }
  keymap.imap { "<S-Tab>", "v:lua.s_tab_complete()", expr = true, silent = true }
  keymap.smap { "<S-Tab>", "v:lua.s_tab_complete()", expr = true, silent = true }
  keymap.imap {
    "<C-e>",
    "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<End>'",
    expr = true,
    silent = true,
  }
  keymap.smap {
    "<C-e>",
    "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-e>'",
    expr = true,
    silent = true,
  }
end

return M
