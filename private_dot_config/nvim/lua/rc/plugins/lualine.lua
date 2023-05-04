local M = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
}

M.opts = function()
  local icons = require("rc.core.config").icons

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
  ins_left {
    "branch",
    icon = {
      icons.status.git,
      color = { fg = util.extract_highlight_colors("Constant", "fg") },
    },
  }
  ins_left {
    function()
      return vim.fn.fnamemodify(vim.loop.cwd(), ":t")
    end,
    icon = {
      icons.status.folder,
      color = { fg = util.extract_highlight_colors("Directory", "fg"), gui = "bold" },
    },
  }
  ins_left { "diff", symbols = icons.git }
  ins_left {
    function()
      return "%="
    end,
  }
  ins_left {
    -- LSP server name
    function()
      local names = {}
      for _, client in ipairs(vim.lsp.get_active_clients { bufnr = 0 }) do
        table.insert(names, client.name)
      end
      return icons.status.lsp .. " " .. table.concat(names, ",")
    end,
    cond = function()
      return next(vim.lsp.get_active_clients()) ~= nil
    end,
    color = { fg = util.extract_highlight_colors("Constant", "fg") },
  }
  ins_left {
    "diagnostics",
    symbols = {
      error = icons.diagnostics.Error,
      warn = icons.diagnostics.Warn,
      info = icons.diagnostics.Info,
      hint = icons.diagnostics.Hint,
    },
  }

  ins_right {
    function()
      return require("noice").api.status.command.get()
    end,
    cond = function()
      return package.loaded["noice"] and require("noice").api.status.command.has()
    end,
    color = { fg = util.extract_highlight_colors("Statement", "fg") },
  }
  ins_right {
    function()
      return require("noice").api.status.mode.get()
    end,
    cond = function()
      return package.loaded["noice"] and require("noice").api.status.mode.has()
    end,
    color = { fg = util.extract_highlight_colors("Constant", "fg") },
  }
  ins_right {
    function()
      return require("dap").status()
    end,
    icon = icons.status.dap,
    cond = function()
      return package.loaded["dap"] and require("dap").status() ~= ""
    end,
    color = { fg = util.extract_highlight_colors("Debug", "fg") },
  }
  ins_right {
    function()
      return require("nvim-treesitter.parsers").has_parser() and "TS" or ""
    end,
    icon = {
      icons.status.treesitter,
      color = { fg = util.extract_highlight_colors("String", "fg") },
    },
    color = { fg = util.extract_highlight_colors("StatusLineNC", "fg") },
    padding = { left = 0, right = 0 },
  }
  ins_right {
    "filetype",
    color = { fg = util.extract_highlight_colors("StatusLineNC", "fg") },
  }
  ins_right {
    "encoding",
    -- color = { fg = util.extract_highlight_colors("Statement", "fg") },
    color = { fg = util.extract_highlight_colors("StatusLineNC", "fg") },
  }
  ins_right {
    "fileformat",
    -- color = { fg = util.extract_highlight_colors("Statement", "fg") },
    color = { fg = util.extract_highlight_colors("StatusLineNC", "fg") },
  }
  ins_right { "location", icon = icons.status.line_number }
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
      component_separators = "",
      section_separators = "",
    },
    sections = statusline,
    -- winbar -> use barbecue.nvim
    extensions = { "neo-tree" },
  }
end

return M
