-- local colors = require "theme.colors"
local lsp = require "feline.providers.lsp"
local vi_mode_utils = require "feline.providers.vi_mode"

-- Intialize the components table
local components = {
  -- components for active windows (left, mid, right)
  active = { {}, {}, {} },
  -- components for inactive windows (left, right)
  inactive = { {}, {} },
}

-- A table that determines which buffers should always have the inactive
-- statusline, even when they are active.
local force_inactive = {
  filetypes = {
    "NvimTree",
    "dbui",
    "packer",
    "startify",
    "fugitive",
    "fugitiveblame",
  },
  buftypes = { "terminal" },
  bufnames = {},
}

local colors = {
  bg = "#282c34",
  fg = "#abb2bf",
  yellow = "#e0af68",
  cyan = "#56b6c2",
  darkblue = "#081633",
  green = "#98c379",
  orange = "#d19a66",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#61afef",
  red = "#e86671",
}

local vi_mode_colors = {
  NORMAL = colors.green,
  INSERT = colors.red,
  VISUAL = colors.magenta,
  OP = colors.green,
  BLOCK = colors.blue,
  REPLACE = colors.violet,
  ["V-REPLACE"] = colors.violet,
  ENTER = colors.cyan,
  MORE = colors.cyan,
  SELECT = colors.orange,
  COMMAND = colors.green,
  SHELL = colors.green,
  TERM = colors.green,
  NONE = colors.yellow,
}

local function vimode_hl()
  return {
    name = vi_mode_utils.get_mode_highlight_name(),
    fg = vi_mode_utils.get_mode_color(),
  }
end

-- Coomponents for active windows
-- [ Left ]
table.insert(components.active[1], {
  provider = "▊",
  hl = vimode_hl,
  right_sep = " ",
})

table.insert(components.active[1], {
  provider = "file_info",
  hl = { fg = colors.blue, style = "bold" },
})

table.insert(components.active[1], {
  provider = "git_branch",
  icon = " ",
  hl = { fg = colors.violet, style = "bold" },
})

table.insert(components.active[1], {
  provider = "git_diff_added",
  hl = { fg = colors.green },
})

table.insert(components.active[1], {
  provider = "git_diff_changed",
  hl = { fg = colors.orange },
})

table.insert(components.active[1], {
  provider = "git_diff_removed",
  hl = { fg = colors.red },
})

-- [ Middle ]
table.insert(components.active[2], {
  provider = "lsp_client_names",
  left_sep = " ",
  icon = " ",
  hl = { fg = colors.yellow },
})

table.insert(components.active[2], {
  provider = "diagnostic_errors",
  left_sep = " ",
  enabled = function()
    lsp.diagnostics_exist "error"
  end,
  hl = { fg = colors.red },
})

table.insert(components.active[2], {
  provider = "diagnostic_warnings",
  left_sep = " ",
  hl = { fg = colors.yellow },
})

table.insert(components.active[2], {
  provider = "diagnostic_hints",
  left_sep = " ",
  hl = { fg = colors.blue },
})

table.insert(components.active[2], {
  provider = "diagnostic_info",
  left_sep = " ",
  hl = { fg = colors.cyan },
})

-- [ Right ]
table.insert(components.active[3], {
  provider = "file_size",
  left_sep = " ",
  hl = { fg = colors.blue },
})

table.insert(components.active[3], {
  -- Show fileformat with an icon
  provider = function()
    local ff = vim.bo.fileformat
    local icon
    if ff == "mac" then
      icon = " "
    elseif ff == "unix" then
      icon = " "
    elseif ff == "dos" then
      icon = " "
    end
    return icon
  end,
  left_sep = " ",
})

table.insert(components.active[3], {
  provider = "file_encoding",
  left_sep = " ",
})

table.insert(components.active[3], {
  provider = function(_, _)
    return " %l/%L  %-2v"
  end,
  left_sep = " ",
})

table.insert(components.active[3], {
  provider = "▊",
  hl = vimode_hl,
  left_sep = " ",
})

-- Status line for inactive buffers
table.insert(components.inactive[1], {
  provider = "▊",
  right_sep = " ",
})
table.insert(components.inactive[1], {
  provider = "file_info",
  right_sep = " ",
})

require("feline").setup {
  colors = colors,
  components = components,
  force_inactive = force_inactive,
  vi_mode_colors = vi_mode_colors,
}
