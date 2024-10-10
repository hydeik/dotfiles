--- [noice.nvim](https://github.com/folke/noice.nvim)
-- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.

-- lua_add {{{
if not vim.tbl_isempty(require("dpp").get "which-key.nvim") then
  require("which-key").add {
    { "<Space>n", group = "+noice" },
  }
end

vim.keymap.set("c", "<S-Enter>", function()
  require("noice").redirect(vim.fn.getcmdline())
end, { desc = "Redirect Cmdline" })

vim.keymap.set("n", "<Space>nl", function()
  require("noice").cmd "last"
end, { desc = "Noice Last Message" })

vim.keymap.set("n", "<Space>nh", function()
  require("noice").cmd "history"
end, { desc = "Noice History" })
vim.keymap.set("n", "<Space>na", function()
  require("noice").cmd "all"
end, { desc = "Noice All" })

vim.keymap.set("n", "<Space>nd", function()
  require("noice").cmd "dismiss"
end, { desc = "Dismiss All" })
-- }}}

-- lua_source {{{
local group = vim.api.nvim_create_augroup("RcAutocmd:Noice", { clear = true })
local focused = true
vim.api.nvim_create_autocmd("FocusGained", {
  group = group,
  callback = function()
    focused = true
  end,
})
vim.api.nvim_create_autocmd("FocusLost", {
  group = group,
  callback = function()
    focused = false
  end,
})

require("noice").setup {
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  routes = {
    {
      filter = {
        ["not"] = {
          event = "lsp",
          kind = "progress",
        },
        cond = function()
          return not focused
        end,
      },
      view = "notify_send",
      opts = { stop = false },
    },
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" },
          { find = "; after #%d+" },
          { find = "; before #%d+" },
        },
      },
      view = "mini",
    },
    {
      filter = {
        event = "notify",
        find = "No information available",
      },
      opts = { skip = true },
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
  },
  views = {
    cmdline_popup = {
      position = {
        row = 5,
        col = "50%",
      },
      size = {
        height = "auto",
        width = "80%",
      },
    },
    popupmenu = {
      relative = "editor",
      position = {
        row = 8,
        col = "50%",
      },
      size = {
        height = 10,
        width = "80%",
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = "Normal", FloatBoader = "DiagnosticInfo" },
      },
    },
  },
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  group = group,
  callback = function(event)
    vim.schedule(function()
      require("noice.text.markdown").keys(event.buf)
    end)
  end,
})
--- }}}
