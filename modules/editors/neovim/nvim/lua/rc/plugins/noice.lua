return {
  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  "folke/noice.nvim",
  lazy = true,
  event = "VeryLazy",
  keys = {
    { "<Space>sn", "", desc = "+noice" },
    {
      "<S-Enter>",
      function()
        require("noice").redirect(vim.fn.getcmdline())
      end,
      mode = "c",
      desc = "Redirect Cmdline",
    },
    {
      "<Space>snl",
      function()
        require("noice").cmd "last"
      end,
      desc = "Noice Last Message",
    },
    {
      "<Space>snh",
      function()
        require("noice").cmd "history"
      end,
      desc = "Noice History",
    },
    {
      "<Space>sna",
      function()
        require("noice").cmd "all"
      end,
      desc = "Noice All",
    },
    {
      "<Space>snd",
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
  opts = {
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
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "mini",
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
    },
  },
  config = function(_, opts)
    -- HACK: noice shows messages from before it was enabled,
    -- but this is not ideal when Lazy is installing plugins,
    -- so clear the messages in this case.
    if vim.o.filetype == "lazy" then
      vim.cmd [[messages clear]]
    end
    require("noice").setup(opts)
  end,
}
