return {
  "WilliamHsieh/overlook.nvim",
  keys = {
    {
      "<Space>p",
      desc = "+overlook",
    },
    {
      "<Space>pp",
      function()
        require("overlook.api").peek_cursor()
      end,
      desc = "Overlook peek cursor",
    },
    {
      "<Space>pd",
      function()
        require("overlook.api").peek_definition()
      end,
      desc = "Overlook peek definition",
    },
    {
      "<Space>pc",
      function()
        require("overlook.api").close_all()
      end,
      desc = "Overlook close all popups",
    },
    {
      "<Space>pv",
      function()
        require("overlook.api").open_in_vsplit()
      end,
      desc = "Overlook open in vsplit",
    },
    {
      "<Space>ps",
      function()
        require("overlook.api").open_in_split()
      end,
      desc = "Overlook open in split",
    },
    {
      "<Space>pt",
      function()
        require("overlook.api").open_in_tab()
      end,
      desc = "Overlook open in tab",
    },
    {
      "<Space>po",
      function()
        require("overlook.api").open_in_original_window()
      end,
      desc = "Overlook open in original window",
    },
    {
      "<Space>pu",
      function()
        require("overlook.api").restore_popup()
      end,
      desc = "Overlook restore popup",
    },
    {
      "<Space>pU",
      function()
        require("overlook.api").restore_all_popups()
      end,
      desc = "Overlook restore all popups",
    },
  },
  ---@type OverlookOptions
  opts = {},
}
