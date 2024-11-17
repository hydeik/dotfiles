--- [ddc.vim](https://github.com/Shougo/ddc.vim)

-- lua_add {{{
local group = vim.api.nvim_create_augroup("RcAutocmd:Ddc", { clear = true })

local commandline_post = function()
  if vim.b.prev_buffer_config then
    vim.fn["ddc#custom#set_buffer"](vim.b.prev_buffer_config)
    vim.b.prev_buffer_config = nil
  end
end

local commandline_pre = function(mode)
  vim.b.prev_buffer_config = vim.fn["ddc#custom#get_buffer"]()
  -- Overwrite sources
  if mode == ":" then
    vim.fn["ddc#custom#patch_buffer"]("sourceOptions", {
      _ = { keywordPattern = "[0-9a-zA-Z_:#-]*" },
    })

    vim.fn["ddc#custom#set_context_buffer"](function()
      local line = vim.fn.getcmdline()
      return vim.fn.stridx(line, "!") == 0
          and { cmdlineSources = { "shell-native", "cmdline", "cmdline-history", "around" } }
        or {}
    end)
  end

  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "DDCCmdlineLeave",
    callback = commandline_post,
    once = true,
    desc = "A hook on DDCCmdlineLeave",
  })

  vim.fn["ddc#enable_cmdline_completion"]()
end

-- keymaps
vim.keymap.set({ "n", "x" }, ":", function()
  commandline_pre ":"
  vim.api.nvim_feedkeys(":", "n", true)
end, { desc = "[ddc.vim] Ex commands" })

vim.keymap.set("n", "/", function()
  commandline_pre "/"
  vim.api.nvim_feedkeys("/", "n", true)
end, { desc = "[ddc.vim] search pattern" })

-- }}}

-- lua_source {{{
local pum = require "rc.plugins.pum"

local opts_expr = { expr = true, replace_keycodes = false }
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

vim.fn["ddc#custom#load_config"](vim.fs.joinpath(vim.env.DPP_HOOKS_DIR, "ddc", "main.ts"))

-- Keymaps in insert mode
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

vim.keymap.set("i", "<C-e>", function()
  if vim.fn["ddc#ui#inline#visible"]() ~= 0 then
    return vim.fn["ddc#map#insert_item"](0)
  elseif pum.visible() then
    return t [[<Cmd>call pum#map#cancel()<CR>]]
  else
    return t "<C-g>U<End>"
  end
end, opts_expr)

vim.keymap.set({ "i", "c" }, "<C-g>", function()
  return vim.fn["ddc#map#insert_item"](0)
end, opts_expr)

vim.keymap.set("i", "<C-l>", function()
  vim.fn["ddc#map#manual_complete"]()
end)

vim.keymap.set("i", "<Tab>", function()
  if vim.fn["ddc#ui#inline#visible"]() ~= 0 then
    return vim.fn["ddc#map#insert_item"](0)
  elseif pum.visible() then
    return t [[<Cmd>call pum#map#insert_relative(+1, "empty")<CR>]]
  else
    local col = vim.fn.col "."
    if col <= 1 then
      return t "<Tab>"
    else
      if string.match(vim.fn.getline("."):sub(-2, -2), "%s") ~= nil then
        return t "<Tab>"
      else
        vim.fn["ddc#map#manual_complete"]()
      end
    end
  end
end, opts_expr)

-- Keymaps in cmdline mode
vim.keymap.set("c", "<S-Tab>", function()
  pum.map.insert_relative(-1)
end)

vim.keymap.set("c", "<M-n>", function()
  pum.map.select_relative(1)
end)

vim.keymap.set("c", "<M-p>", function()
  pum.map.select_relative(-1)
end)

vim.keymap.set("c", "<C-e>", function()
  if vim.fn["ddc#ui#inline#visible"]() then
    return vim.fn["ddc#map#insert_item"](0)
  elseif pum.visible() then
    return t [[<Cmd>call pum#map#cancel()<CR>]]
  else
    return t [[<END>]]
  end
end, opts_expr)

vim.keymap.set("c", "<C-o>", function()
  pum.map.confirm()
end)

vim.keymap.set("c", "<C-y>", function()
  pum.map.confirm()
end)

vim.keymap.set("c", "<Tab>", function()
  if vim.fn["ddc#ui#inline#visible"]() ~= 0 then
    return vim.fn["ddc#map#insert_item"](0)
  elseif pum.visible() then
    return t [[<Cmd>call pum#map#insert_relative(+1)<CR>]]
  else
    vim.fn["ddc#map#manual_complete"]()
  end
end, opts_expr)

-- Keymaps in visual & operator pending mode
vim.keymap.set("x", "<Tab>", [["_R<Cmd>call ddc#map#manual_complete()<CR>]])
vim.keymap.set("s", "<Tab>", [[<C-o>"_di<Cmd>call ddc#map#manual_complete()<CR>]])

-- Enable terminal completion

vim.fn["ddc#enable_terminal_completion"]()

vim.fn["ddc#enable"] { context_filetype = "treesitter" }

-- }}}

-- lua_post_update {{{
vim.fn["ddc#set_static_import_path"]()

-- }}}
