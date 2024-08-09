--- [ddc.vim](https://github.com/Shougo/ddc.vim)

-- lua_add {{{
local group = vim.api.nvim_create_augroup("DdcCustomize", { clear = true })
local ddc_ = require "rc.plugins.ddc"

local commandline_post = function()
  if vim.b.prev_buffer_config then
    ddc_.custom.set_buffer(vim.b.prev_buffer_config)
    vim.b.prev_buffer_config = nil
  end
end

local commandline_pre = function(mode)
  vim.b.prev_buffer_config = ddc_.custom.get_buffer()
  -- Overwrite sources
  if vim.b.prev_buffer_config then
    if mode == ":" then
      ddc_.custom.patch_buffer("sourceOptions", {
        _ = { keywordPattern = "[0-9a-zA-Z_:#-]*" },
      })

      local line = vim.fn.getcmdline()
      local opts = vim.fn.stridx(line, "!") == 0
          and { cmdlineSources = { "shell-native", "cmdline", "cmdline-history", "around" } }
        or {}
      ddc_.custom.set_context_buffer("sourceOptions", opts)
    end
  end

  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "DDCCmdlineLeave",
    callback = commandline_post,
    once = true,
    desc = "A hook on DDCCmdlineLeave",
  })
end

-- keymaps
vim.keymap.set({ "n", "x" }, ":", function()
  commandline_pre ":"
  return ":"
end, { desc = "[ddc.vim] Ex commands" })

vim.keymap.set("n", "/", function()
  commandline_pre "/"
  return "/"
end, { desc = "[ddc.vim] search pattern" })

-- }}}

-- lua_source {{{
local ddc = require "rc.plugins.ddc"
local pum = require "rc.plugins.pum"
ddc.custom.load_config "$VIM_CONFIG_DIR/dpp/ddc.ts"

-- Keymaps for completion in Insert mode
vim.keymap.set("i", "<S-Tab>", function()
  pum.map.insert_relative(-1, "empty")
end)

vim.keymap.set("i", "<HOME>", function()
  pum.map.insert_relative(-9999, "ignore")
end)

vim.keymap.set("i", "<End>", function()
  pum.map.insert_relative(9999, "ignore")
end)

vim.keymap.set("i", "<C-n>", function()
  pum.map.select_relative(1)
end)

vim.keymap.set("i", "<C-p>", function()
  pum.map.select_relative(-1)
end)

vim.keymap.set("i", "<C-y>", function()
  pum.map.confirm_suffix()
end)

vim.keymap.set("i", "<C-o>", function()
  pum.map.confirm_word()
end)

vim.keymap.set("i", "<C-g>", function()
  pum.set_option { preview = not pum._options().preview }
end)

vim.keymap.set({ "i", "c" }, "<C-e>", function()
  if pum.visible() then
    pum.map.cancel()
  else
    return "<End>"
  end
end, { expr = true })

vim.keymap.set("i", "<C-l>", function()
  ddc.map.manual_complete()
end, { expr = true })

vim.keymap.set("i", "<Tab>", function()
  if pum.visible() then
    pum.insert_relative(1, "empty")
  else
    local col = vim.fn.col "."
    if col <= 1 then
      return "<Tab>"
    else
      if string.match(vim.fn.getline("."):sub(-2, -2), "%s") ~= nil then
        return "<Tab>"
      else
        ddc.map.manual_complete()
      end
    end
  end
end, { expr = true })

vim.keymap.set("c", "<S-Tab>", function()
  pum.map.insert_relative(-1)
end)

vim.keymap.set("c", "<M-n>", function()
  pum.map.select_relative(1)
end)

vim.keymap.set("c", "<M-p>", function()
  pum.map.select_relative(-1)
end)

vim.keymap.set("c", "<C-o>", function()
  pum.map.confirm()
end)

vim.keymap.set("c", "<C-y>", function()
  pum.map.confirm()
end)

vim.keymap.set("c", "<C-t>", function()
  ddc.map.insert_item(0)
end, { expr = true })

vim.keymap.set("c", "<Tab>", function()
  if vim.fn.wildmenumode() then
    return vim.fn.nr2char(vim.o.wildcharm)
  else
    if pum.visible() then
      pum.insert_relative(1)
    else
      ddc.map.manual_complete()
    end
  end
end, { expr = true })

vim.keymap.set("x", "<Tab>", [["_R<Cmd>call ddc#map#manual_complete()<CR>]])
vim.keymap.set("s", "<Tab>", [[<C-o>"_di<Cmd>call ddc#map#manual_complete()<CR>]])

-- Enable terminal completion
ddc.enable_terminal_completion()

ddc.enable { context_filetype = "treesitter" }

-- }}}

-- lua_post_update {{{
require("rc.plugins.ddc").set_static_import_path()
-- }}}
