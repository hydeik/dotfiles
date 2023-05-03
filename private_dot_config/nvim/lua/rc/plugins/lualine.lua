local M = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
}

M.opts = function()
  local icons = require("rc.core.config").icons
  local navic = require "nvim-navic"

  local util = require "lualine.utils.utils"
  local lualine = require "lualine.themes.auto"

  local mode_highlight = function()
    local mode = vim.api.nvim_get_mode()["mode"]:sub(1, 1)
    local mode_colors = {
      n = lualine.normal.a.bg,
      i = lualine.insert.a.bg,
      v = lualine.visual.a.bg,
      V = lualine.visual.a.bg,
      ["\22"] = lualine.visual.a.bg,
      c = lualine.command.a.bg,
      s = lualine.visual.a.bg,
      S = lualine.visual.a.bg,
      ["\19"] = lualine.visual.a.bg,
      R = lualine.replace.a.bg,
      r = lualine.replace.a.bg,
      ["!"] = lualine.command.a.bg,
      t = lualine.command.a.bg,
    }
    return { fg = mode_colors[mode] }
  end

  local statusline = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  }

  local ins_left = function(component)
    table.insert(statusline.lualine_c, component)
  end
  local ins_right = function(component)
    table.insert(statusline.lualine_x, component)
  end

  ins_left {
    function()
      return "▊"
    end,
    color = mode_highlight,
    padding = { right = 1 },
  }
  ins_left { "branch" }
  ins_left { "filetype" }
  ins_left { "diff", symbols = icons.git }
  ins_left {
    "diagnostics",
    symbols = {
      error = icons.diagnostics.Error,
      warn = icons.diagnostics.Warn,
      info = icons.diagnostics.Info,
      hint = icons.diagnostics.Hint,
    },
  }
  ins_left {
    function()
      return "%="
    end,
  }
  ins_left {
    -- LSP server name
    function()
      local names = {}
      for _, client in ipairs(vim.lsp.buf_get_clients(0)) do
        table.insert(names, client.name)
      end
      return " [" .. table.concat(names, "|") .. "]"
    end,
    cond = function()
      return next(vim.lsp.buf_get_clients()) ~= nil
    end,
    color = { fg = util.extract_highlight_colors("Constant", "fg") },
  }

  ins_right {
    "filesize",
    color = { fg = util.extract_highlight_colors("String", "fg") },
  }
  ins_right {
    "fileformat",
    color = { fg = util.extract_highlight_colors("Statement", "fg") },
  }
  ins_right {
    "encoding",
    color = { fg = util.extract_highlight_colors("Statement", "fg") },
  }
  ins_right { "location" }
  ins_right { "progress" }
  ins_right {
    function()
      return "▊"
    end,
    color = mode_highlight,
    padding = { left = 1 },
  }

  return {
    options = {
      theme = "auto",
      globalstatus = true,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    sections = statusline,
    -- winbar -> use barbecue.nvim
    extensions = { "neo-tree" },
  }
end

return M
