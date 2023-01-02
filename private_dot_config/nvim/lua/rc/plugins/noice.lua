-- Highly experimental plugin that completely replaces the UI for messages,
-- cmdline and the popupmenu.
local M = {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  event = "VeryLazy",
}

M.config = function()
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
  }

  -- key mappings
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

  vim.keymap.set("n", "<c-f>", function()
    if not require("noice.lsp").scroll(4) then
      return "<c-f>"
    end
  end, { silent = true, expr = true })

  vim.keymap.set("n", "<c-b>", function()
    if not require("noice.lsp").scroll(-4) then
      return "<c-b>"
    end
  end, { silent = true, expr = true })

  local group = vim.api.nvim_create_augroup("NoiceEvent", { clear = true })
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
