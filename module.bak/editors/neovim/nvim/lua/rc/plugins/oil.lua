return {
  -- Neovim file explorer: edit your filesystem like a buffer
  "stevearc/oil.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<Space>fo",
      function()
        local dir = require("rc.utils").find_root()
        require("oil").open_float(dir)
      end,
      desc = "Open oil (root dir)",
    },
    {
      "<Space>fO",
      function()
        local dir = vim.uv.cwd()
        require("oil").open_float(dir)
      end,
      desc = "Open oil (cwd)",
    },
  },
  opts = {
    delete_to_trash = true,
    view_options = {
      show_hidden = true,
    },
  },
  config = function(_, opts)
    require("oil").setup(opts)
    vim.api.nvim_create_autocmd("User", {
      pattern = "OilActionsPost",
      callback = function(event)
        if event.data.actions.type == "move" then
          Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
        end
      end,
    })
  end,
}
