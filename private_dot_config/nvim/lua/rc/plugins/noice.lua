-- Highly experimental plugin that completely replaces the UI for messages,
-- cmdline and the popupmenu.
local M = {
  "folke/noice.nvim",
  dependencies = {
    { "MunifTanjim/nui.nvim" },
    {
      "folke/which-key.nvim",
      opts = function(_, opts)
        local defaults = opts.defaults and opts.defaults or {}
        if require("rc.util").has_plugin "noice.nvim" then
          defaults["<Space>n"] = { name = "+noice" }
        end
        opts.defaults = defaults
      end,
    },
  },
  event = "VeryLazy",
  keys = {
    {
      "<S-Enter>",
      function()
        require("noice").redirect(vim.fn.getcmdline())
      end,
      mode = "c",
      desc = "Redirect Cmdline",
    },
    {
      "<Space>nl",
      function()
        require("noice").cmd "last"
      end,
      desc = "Noice Last Message",
    },
    {
      "<Space>nh",
      function()
        require("noice").cmd "history"
      end,
      desc = "Noice History",
    },
    {
      "<Space>na",
      function()
        require("noice").cmd "all"
      end,
      desc = "Noice All",
    },
    {
      "<Space>nd",
      function()
        require("noice").cmd "dismiss"
      end,
      desc = "Dismiss All",
    },
    {
      "<c-f>",
      function()
        if not require("noice.lsp").scroll(4) then
          return "<c-f>"
        end
      end,
      silent = true,
      expr = true,
      desc = "Scroll forward",
      mode = { "i", "n", "s" },
    },
    {
      "<c-b>",
      function()
        if not require("noice.lsp").scroll(-4) then
          return "<c-b>"
        end
      end,
      silent = true,
      expr = true,
      desc = "Scroll backward",
      mode = { "i", "n", "s" },
    },
  },
}

M.config = function(_, _)
  local group = vim.api.nvim_create_augroup("UserNoiceConfig", { clear = true })
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
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
      cmdline_output_to_split = false,
    },
    routes = {
      {
        filter = {
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
          find = "%d+L, %d+B",
        },
        view = "mini",
      },
    },
    commands = {
      all = {
        -- options for the message history that you get with `:Noice`
        view = "split",
        opts = { enter = true, format = "details" },
        filter = {},
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
end

return M
