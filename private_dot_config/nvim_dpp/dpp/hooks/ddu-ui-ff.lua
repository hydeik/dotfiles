-- lua_ddu-ff {{{

local do_action = vim.fn["ddu#ui#do_action"]
local multi_actions = vim.fn["ddu#ui#multi_actions"]
local opts = { buffer = true, silent = true }

vim.keymap.set({ "n", "x" }, "<CR>", function()
  do_action "itemAction"
end, opts)

vim.keymap.set("n", "<Space>", function()
  do_action "toggleSelectItem"
end, opts)

vim.keymap.set("n", "*", function()
  do_action "toggleAllItems"
end, opts)

vim.keymap.set("n", "i", function()
  do_action "openFilterWindow"
end, opts)

vim.keymap.set("n", "<C-l>", function()
  do_action("redraw", { method = "refreshItems" })
end, opts)

vim.keymap.set("n", "p", function()
  do_action "previewPath"
end, opts)

vim.keymap.set("n", "P", function()
  do_action "togglePreview"
end, opts)

vim.keymap.set("n", "q", function()
  do_action "quit"
end, opts)

vim.keymap.set("n", "<C-g>", function()
  do_action "quit"
end, opts)

vim.keymap.set("n", "a", function()
  do_action "chooseAction"
end, opts)

vim.keymap.set("n", "A", function()
  do_action "inputAction"
end, opts)

vim.keymap.set("n", "o", function()
  do_action "expandItem"
end, opts)

vim.keymap.set("n", "O", function()
  do_action "collapseItem"
end, opts)

vim.keymap.set("n", "d", function()
  do_action("itemAction", { name = vim.b.ddu_ui_name == "filer" and "trash" or "delete" })
end, opts)

vim.keymap.set("n", "e", function()
  local is_dir = vim.tbl_get(vim.fn["ddu#ui#get_item"](), "action", "isDirectory")
  is_dir = is_dir ~= nil and is_dir or false
  do_action("itemAction", { name = is_dir and "narrow" or "edit" })
end, opts)

vim.keymap.set("n", "N", function()
  do_action("itemAction", { name = vim.b.ddu_ui_name == "file" and "newFile" or "new" })
end, opts)

vim.keymap.set("n", "<C-q>", function()
  do_action("itemAction", { name = "quickfix" })
end, opts)

vim.keymap.set("n", "yy", function()
  do_action("itemAction", { name = "yank" })
end, opts)

vim.keymap.set("n", "gr", function()
  do_action("itemAction", { name = "grep" })
end, opts)

vim.keymap.set("n", "n", function()
  do_action("itemAction", { name = "narrow" })
end, opts)

vim.keymap.set("n", "K", function()
  do_action "kensaku"
end, opts)

vim.keymap.set("n", "<C-v>", function()
  do_action "toggleAutoAction"
end, opts)

-- Scroll the preview window
vim.keymap.set("n", "<C-n>", function()
  do_action("previewExecute", { command = [[execute "normal! \<C-e>"]] })
end, opts)

vim.keymap.set("n", "<C-p>", function()
  do_action("previewExecute", { command = [[execute "normal! \<C-y>"]] })
end, opts)

-- Cursor move
vim.keymap.set("n", "<C-n>", function()
  multi_actions({ "cursorNext", "itemAction" }, "files")
end, { silent = true })

vim.keymap.set("n", "<C-p>", function()
  multi_actions({ "cursorPrevious", "itemAction" }, "files")
end, { silent = true })

vim.keymap.set("n", "<C-j>", function()
  do_action "cursorNext"
end, opts)

vim.keymap.set("n", "<C-k>", function()
  do_action "cursorPrevious"
end, opts)

-- }}}

-- lua_source {{{

local group_id = vim.api.nvim_create_augroup("ConfigureDduUiFf", { clear = true })

vim.api.nvim_create_autocmd("User", {
  group = group_id,
  pattern = "Ddu:ui:ff:openFilterWindow",
  callback = function()
    vim.fn["ddu#ui#ff#save_cmaps"] { "<C-f>", "<C-b>" }
    vim.keymap.set("c", "<C-f>", function()
      vim.fn["ddu#ui#do_action"]("cursorNext", { loop = true })
    end)
    vim.keymap.set("c", "<C-f>", function()
      vim.fn["ddu#ui#do_action"]("cursorPrevious", { loop = true })
    end)
  end,
  desc = "[ddu-ui-ff] A hook before openFilterWindow",
})

vim.api.nvim_create_autocmd("User", {
  group = group_id,
  pattern = "Ddu:ui:ff:closeFilterWindow",
  callback = function()
    vim.fn["ddu#ui#ff#restore_cmaps"]()
  end,
  desc = "[ddu-ui-ff] A hook before closeFilterWindow",
})

-- set window sizes
local resize_ddu_ui_window = function()
  local width_ratio = 0.90
  local height_ratio = 0.80

  local filter_height = 3
  local space = 3

  local height = math.floor(vim.o.lines * height_ratio)

  local full_width = math.floor(vim.o.columns * width_ratio)
  local preview_width = full_width > 200 and math.floor(full_width * 0.4) or math.floor(full_width * 0.6)
  local width = full_width - preview_width

  local row = math.floor(vim.o.lines * (1 - height_ratio) / 2)
  local col = math.floor(vim.o.columns * (1 - width_ratio) / 2)

  vim.fn["cmdline#set_option"] {
    width = width - math.floor(space / 2),
    col = col,
    row = row,
    border = "single",
    title = "Filter",
    title_pos = "center",
  }

  vim.fn["ddu#custom#patch_global"] {
    uiParams = {
      ff = {
        winHeight = height - filter_height,
        winRow = row + filter_height,
        winWidth = width - math.floor(space / 2),
        winCol = col,
        previewHeight = height,
        previewRow = row,
        previewWidth = preview_width,
        previewCol = col + width + math.floor(space / 2),
      },
    },
  }
end

resize_ddu_ui_window()

vim.api.nvim_create_autocmd("VimResized", {
  group = group_id,
  pattern = "*",
  callback = function()
    resize_ddu_ui_window()
  end,
  nested = true,
  desc = "[ddu-ui-ff] Recalculate window sizes for the UI",
})

-- }}}
