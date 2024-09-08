--- [ddu-ui-filer](https://github.com/Shougo/ddu-ui-filer)
-- File listing UI for ddu.vim

-- lua_add {{{
vim.keymap.set("n", "<Space>fe", function()
  local path = require("rc.utils").get_root()
  path = path ~= "" and path or vim.uv.cwd() --[[@as string]]
  require("rc.plugins.ddu").start {
    name = string.format("filer-%d", vim.api.nvim_get_current_win()),
    ui = "filer",
    resume = true,
    sync = true,
    sources = { "file" },
    sourceOptions = {
      path = path,
    },
  }
end, { desc = "Ddu Filer (root dir)" })

vim.keymap.set("n", "<Space>fE", function()
  require("rc.plugins.ddu").start {
    name = string.format("filer-%d", vim.api.nvim_get_current_win()),
    ui = "filer",
    resume = true,
    sync = true,
    sources = { "file" },
    sourceOptions = {
      path = vim.t.ddu_ui_filer_path and vim.t.ddu_ui_filer_path or vim.uv.cwd(),
    },
  }
end, { desc = "Ddu Filer (cwd)" })
-- }}}

-- lua_source {{{
local group = vim.api.nvim_create_augroup("ConfigDduUiFiler", { clear = true })
vim.api.nvim_create_autocmd({ "TabEnter", "WinEnter", "CursorHold", "CursorHoldI" }, {
  group = group,
  pattern = "*",
  callback = function()
    require("rc.plugins.ddu").ui.do_action "checkItems"
  end,
  desc = "Check File Updates",
})
-- }}}

-- lua_ddu-filer {{{
local ddu = require "rc.plugins.ddu"
local do_action = ddu.ui.do_action
local multi_actions = ddu.ui.multi_actions

local toggle_hidden = function(name)
  local matchers = vim.tbl_get(ddu.custom.get_current(), "sourceOptions", name, "matchers")
  matchers = matchers ~= nil and matchers or {}
  local pos
  for i in 1, #matchers do
    if matchers[i] == "matcher_hidden" then
      pos = i
      break
    end
  end
  if pos then
    table.remove(matchers, pos)
  else
    table.insert(matchers, "matcher_hidden")
  end
  return matchers
end

vim.keymap.set("n", "<Space>", function()
  do_action "toggleSelectItem"
end, { buffer = true, desc = "[ddu-filer] Toggle Selected Item" })

vim.keymap.set("n", "*", function()
  do_action "toggleAllItems"
end, { buffer = true, desc = "[ddu-filer] Toggle All Items" })

vim.keymap.set("n", "a", function()
  do_action "chooseAction"
end, { buffer = true, desc = "[ddu-filer] Choose Action" })

vim.keymap.set("n", "A", function()
  do_action "inputAction"
end, { buffer = true, desc = "[ddu-filer] Input Action" })

vim.keymap.set("n", "q", function()
  do_action "quit"
end, { buffer = true, desc = "[ddu-filer] Quit" })

vim.keymap.set("n", "o", function()
  do_action("expandItem", {
    mode = "toggle",
    isGrouped = true,
    isInTree = false,
  })
end, { buffer = true, desc = "[ddu-filer] Expand (toggle)" })

vim.keymap.set("n", "O", function()
  do_action("expandItem", { maxLevel = -1 })
end, { buffer = true, desc = "[ddu-filer] Expand (recursive)" })

vim.keymap.set("n", "c", function()
  multi_actions {
    { "itemAction", { name = "copy" } },
    { "clearSelectAllItems" },
  }
end, { buffer = true, desc = "[ddu-filer] Copy" })

vim.keymap.set("n", "d", function()
  do_action("itemAction", { name = "trash" })
end, { buffer = true, desc = "[ddu-filer] Trash" })

vim.keymap.set("n", "D", function()
  do_action("itemAction", { name = "delete" })
end, { buffer = true, desc = "[ddu-filer] Delete" })

vim.keymap.set("n", "m", function()
  do_action("itemAction", { name = "move" })
end, { buffer = true, desc = "[ddu-filer] Move" })

vim.keymap.set("n", "r", function()
  do_action("itemAction", { name = "rename" })
end, { buffer = true, desc = "[ddu-filer] Rename" })

vim.keymap.set("n", "x", function()
  do_action("itemAction", { name = "executeSystem" })
end, { buffer = true, desc = "[ddu-filer] Execute System Command" })

vim.keymap.set("n", "p", function()
  do_action("itemAction", { name = "paste" })
end, { buffer = true, desc = "[ddu-filer] Paste" })

vim.keymap.set("n", "P", function()
  do_action "togglePreview"
end, { buffer = true, desc = "[ddu-filer] Preview (toggle)" })

vim.keymap.set("n", "K", function()
  do_action("itemAction", { name = "newDirectory" })
end, { buffer = true, desc = "[ddu-filer] New Directory" })

vim.keymap.set("n", "N", function()
  do_action("itemAction", { name = "newFile" })
end, { buffer = true, desc = "[ddu-filer] New File" })

vim.keymap.set("n", "L", function()
  do_action("itemAction", { name = "link" })
end, { buffer = true, desc = "[ddu-filer] Symlink" })

vim.keymap.set("n", "u", function()
  do_action("itemAction", { name = "undo" })
end, { buffer = true, desc = "[ddu-filer] Undo" })

vim.keymap.set("n", "~", function()
  do_action("itemAction", { name = "narrow", params = { path = vim.env.HOME } })
end, { buffer = true, desc = "[ddu-filer] Narrow ('~')" })

vim.keymap.set("n", "=", function()
  do_action("itemAction", { name = "narrow", params = { path = vim.uv.cwd() } })
end, { buffer = true, desc = "[ddu-filer] Narrow ('cwd')" })

vim.keymap.set("n", "h", function()
  do_action("itemAction", { name = "narrow", params = { path = ".." } })
end, { buffer = true, desc = "[ddu-filer] Narrow ('..')" })

vim.keymap.set("n", "H", function()
  ddu.start { name = "path_history" }
end, { buffer = true, desc = "[ddu-filer] Show History" })

vim.keymap.set("n", ".", function()
  multi_actions {
    {
      updateOptions = {
        sourceOptions = {
          file = { matchers = toggle_hidden "file" },
        },
      },
    },
    {
      redraw = { method = "refreshItems" },
    },
  }
end, { buffer = true, desc = "[ddu-filer] Show Hidden Files (toggle)" })

vim.keymap.set("n", "<C-l>", function()
  do_action("itemAction", { name = "redraw" })
end, { buffer = true, desc = "[ddu-filer] Redraw" })

vim.keymap.set("n", "<CR>", function()
  if vim.tbl_get(ddu.ui.get_item(), "isTree") then
    do_action("itemAction", { name = "narrow" })
  else
    do_action("itemAction", { name = "open" })
  end
end, { buffer = true, desc = "[ddu-filer] Narrow directory / Open file" })

vim.keymap.set("n", "l", function()
  if vim.tbl_get(ddu.ui.get_item(), "isTree") then
    do_action("itemAction", { name = "narrow" })
  else
    do_action("itemAction", { name = "open" })
  end
end, { buffer = true, expr = true, desc = "[ddu-filer] Narrow directory / Open file" })

-- }}}
