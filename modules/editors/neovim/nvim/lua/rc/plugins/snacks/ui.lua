return {
  {
    "snacks.nvim",
    keys = {
      {
        "<Space>n",
        function()
          if Snacks.config.picker and Snacks.config.picker.enabled then
            Snacks.picker.notifications()
          else
            Snacks.notifier.show_history()
          end
        end,
        desc = "Notification History",
      },
      {
        "<Space>un",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
    },
    opts = {
      -- Indent guides and scopes
      indent = { enabled = true },
      -- Better vim.ui.input
      input = { enabled = true },
      -- Pretty vim.notify
      notifier = { enabled = true },
      -- Smooth scroll
      scroll = { enabled = false },
      -- Pretty status column --> defined using heirline
      statuscolumn = { enabled = false },
      -- Toggle keymaps integrated with which-key icons / colors
      toggle = { enabled = true },
      -- Auto-show LSP references and quickly navigate between them
      words = { enabled = true },
    },
  },
}
