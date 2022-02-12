local M = {}

-- local function from_file(fname)
--   return function()
--     local file = io.open(fname)
--     local data = "FAILED TO LOAD "..fname
--     if file then
--       data = file:read "*a"
--       file:close()
--     end
--     return data
--   end
-- end

function M.custom_advance(offset)
  local snip_plug = require "snippets"
  local _, expanded = snip_plug.lookup_snippet_at_cursor()
  if expanded then
    snip_plug.expand_or_advance(offset)
  else
    if offset == 1 then
      vim.cmd [[execute <Left>]]
    else
      vim.cmd [[execute <Right>]]
    end
  end
end

function M.config()
  local snip_plug = require "snippets"
  local force_comment = require("snippets.utils").force_comment
  local snips = {}

  -- TODO (H. Ikeno):  add more snippets
  snips._global = {
    todo = "TODO (H. Ikeno): ",
    date = [[${=os.date("%Y-%m-%d")}]],
    uname = function()
      return vim.loop.os_uname().sysname
    end,
    copyright = force_comment [[Copyright (C) ${=os.date("%Y")} Hidekazu Ikeno}]],
    BSD2 = require("conf.snippets.licenses").get_snippets "BSD2",
    BSD3 = require("conf.snippets.licenses").get_snippets "BSD3",
    GPL3 = require("conf.snippets.licenses").get_snippets "GPL3",
    MIT = require("conf.snippets.licenses").get_snippets "MIT",
  }

  snips.lua = require("conf.snippets.lua").get_snippets()
  snips.python = require("conf.snippets.python").get_snippets()
  snips.rust = require("conf.snippets.rust").get_snippets()
  snips.sh = require("conf.snippets.sh").get_snippets()

  snip_plug.snippets = snips

  -- UX
  snip_plug.set_ux(require "snippets.inserters.floaty")

  -- Key mappings
  local opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap("i", "<C-f>", "<cmd>lua require'conf.snippets'.custom_advance(1)<CR>", opts)
  vim.api.nvim_set_keymap("i", "<C-b>", "<cmd>lua require'conf.snippets'.custom_advance(-1)<CR>", opts)
  vim.api.nvim_set_keymap("i", "<C-s>", "<cmd>lua require'snippets'.expand_or_advance(1)<CR>", opts)
  vim.api.nvim_set_keymap("i", "<C-S-s>", "<cmd>lua require'snippets'.expand_or_advance(-1)<CR>", opts)
end

return M
