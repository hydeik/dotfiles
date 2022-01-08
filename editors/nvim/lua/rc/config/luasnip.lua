local M = {}

function M.config()
  local luasnip = require "luasnip"
  luasnip.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
  }

  local path = require "rc.core.path"
  require("luasnip.loaders.from_vscode").load {
    paths = {
      -- REMARK: package.json files are required in the following directories
      -- path.join(path.config_home, "snippets"),
      path.join(path.pack_root, "packer", "start", "friendly-snippets"),
    },
  }

  -- key mappings
  -- local keymap = require "rc.core.keymap"
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
  -- keymap.imap { "<Tab>", "v:lua.tab_complete()", expr = true, silent = true }
  -- keymap.smap { "<Tab>", "v:lua.tab_complete()", expr = true, silent = true }
  -- keymap.imap { "<S-Tab>", "v:lua.s_tab_complete()", expr = true, silent = true }
  -- keymap.smap { "<S-Tab>", "v:lua.s_tab_complete()", expr = true, silent = true }

  vim.keymap.set({ "i", "s" }, "<Tab>", "v:lua.tab_complete()", { expr = true, silent = true })
  vim.keymap.set({ "i", "s" }, "<S-Tab>", "v:lua.s_tab_complete()", { expr = true, silent = true })

  vim.keymap.set("i", "<C-e>", function()
    return luasnip.choice_active() and "<Plug>luasnip-next-choice" or "<End>"
  end, { expr = true, silent = true })

  vim.keymap.set("s", "<C-e>", function()
    return luasnip.choice_active() and "<Plug>luasnip-next-choice" or "<C-e>"
  end, { expr = true, silent = true })
end

return M
