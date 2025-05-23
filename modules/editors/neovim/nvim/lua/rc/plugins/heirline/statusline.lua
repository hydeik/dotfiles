local conditions = require "heirline.conditions"
local utils = require "heirline.utils"
local custom_icons = require("rc.core.config").icons

local Align = { provider = "%=" }
local Space = { provider = " " }

-- Vi mode component
local ViMode = {
  init = function(self)
    self.mode = vim.api.nvim_get_mode()["mode"]
  end,
  static = {
    mode_names = {
      n = "NORMAL",
      no = "NORMAL (no)",
      nov = "NORMAL (nov)",
      noV = "NORMAL (noV)",
      ["no\22"] = "NORMAL",
      niI = "NORMAL i",
      niR = "NORMAL r",
      niV = "NORMAL v",
      nt = "NTERMINAL",
      ntT = "NTERMINAL (ntT)",
      v = "VISUAL",
      vs = "V-CHAR (Ctrl-O)",
      V = "V-LINE",
      Vs = "V-LINE",
      ["\22"] = "V-BLOCK",
      ["\22s"] = "V-BLOCK (Ctrl-O)",
      s = "SELECT",
      S = "S-LINE",
      ["\19"] = "S-BLOCK",
      i = "INSERT",
      ic = "INSERT (ic)",
      ix = "INSERT (ix)",
      R = "REPLACE",
      Rc = "REPLACE (Rc)",
      Rx = "REPLACE (Rx)",
      Rv = "V-REPLACE",
      Rvc = "V-REPLACE (Rvc)",
      Rvx = "V-REPLACE (Rvx)",
      c = "COMMAND",
      cv = "VIM EX",
      r = "PROMPT",
      rm = "MORE",
      ["r?"] = "CONFIRM",
      ["!"] = "SHELL",
      t = "TERMINAL",
    },
    mode_colors_map = {
      n = "blue",
      i = "green",
      v = "magenta",
      V = "magenta",
      ["\22"] = "magenta",
      c = "red",
      s = "magenta",
      S = "magenta",
      ["\19"] = "magenta",
      R = "orange",
      r = "orange",
      ["!"] = "fg",
      t = "red",
    },
    mode_color = function(self)
      local mode = conditions.is_active() and self.mode:sub(1, 1) or "n"
      return self.mode_colors_map[mode]
    end,
  },
  {
    provider = "",
    hl = function(self)
      return { fg = self:mode_color() }
    end,
  },
  {
    provider = function(_)
      return " "
    end,
    hl = function(self)
      return { fg = "bg", bg = self:mode_color() }
    end,
  },
  {
    provider = function(self)
      return " %2(" .. self.mode_names[self.mode] .. "%) "
    end,
    hl = function(self)
      return { fg = self:mode_color(), bg = "bg_bright" }
    end,
  },
  {
    provider = "",
    hl = { fg = "bg_bright" },
  },
  update = {
    "ModeChanged",
    pattern = "*:*",
    callback = vim.schedule_wrap(function()
      vim.cmd.redrawstatus()
    end),
  },
}

-- File name component
local FileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}

local FileIcon = {
  init = function(self)
    self.icon, _, _ = require("mini.icons").get("file", self.filename)
  end,
  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,
  hl = { fg = "bg", bg = "red" },
}

local FileName = {
  provider = function(self)
    local filename = vim.fs.basename(self.filename)
    if filename == "" then
      return " [No Name] "
    end
    return string.format(" %s ", filename)
  end,
  hl = { fg = "red", bg = "bg_bright" },
}

local FileFlags = {
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = " ",
    hl = { fg = "green", bg = "bg_bright" },
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = " ",
    hl = { fg = "orange", bg = "bg_bright" },
  },
}

local FileNameModifer = {
  hl = function()
    if vim.bo.modified then
      -- use `force` because we need to override the child's hl foreground
      return { fg = "red", bg = "bg_bright", bold = true, force = true }
    end
  end,
}

-- let's add the children to our FileNameBlock component
FileNameBlock = utils.insert(
  FileNameBlock,
  {
    provider = "",
    hl = { fg = "red" },
  },
  FileIcon,
  utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
  FileFlags,
  {
    provider = "",
    hl = { fg = "bg_bright" },
  },
  -- this means that the statusline is cut here when there's not enough space
  { provider = "%<" } -- this means that the statusline is cut here when there's not enough space
)

-- Special file names
local TerminalName = {
  -- icon = ' ', -- 
  {
    provider = "",
    hl = { fg = "magenta_bright" },
  },
  {
    provider = function()
      local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
      return " " .. tname .. " "
    end,
    hl = { fg = "bg", bg = "magenta_bright", bold = true },
  },
  {
    provider = function()
      return string.format(" %s ", vim.b.term_title)
    end,
    hl = { fg = "fg_bright", bg = "bg_bright" },
  },
  {
    provider = function()
      -- local id = require("terminal"):current_term_index()
      -- return " " .. (id or "Exited")
      local win, _ = Snacks.terminal.get(nil, { created = false })
      return " " .. (win.id or "Exited")
    end,
    hl = { fg = "magenta_bright", bg = "bg_bright", bold = true },
  },
  {
    provider = "",
    hl = { fg = "bg_bright" },
  },
}

local OilFileName = {
  {
    provider = "",
    hl = { fg = "red" },
  },
  {
    provider = "󰏇 ",
    hl = { fg = "bg", bg = "red" },
  },
  {
    provider = function()
      local name, _ = vim.api.nvim_buf_get_name(0):gsub("oil://", "")
      return " " .. name
    end,
    hl = { fg = "red", bg = "bg_bright", bold = true },
  },
  {
    provider = "",
    hl = { fg = "bg_bright" },
  },
}

-- Git component
local Git = {
  condition = conditions.is_git_repo,
  static = {
    branch_icon = custom_icons.git.branch,
    add_icon = custom_icons.git.added,
    remove_icon = custom_icons.git.removed,
    change_icon = custom_icons.git.modified,
  },

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,

  hl = { fg = "fg_dim" },

  { -- git branch name
    provider = function(self)
      return self.branch_icon .. self.status_dict.head .. " "
    end,
    hl = { bold = true },
  },
  -- You could handle delimiters, icons and counts similar to Diagnostics
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and (self.add_icon .. count)
    end,
    hl = { fg = "git_add" },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and (self.remove_icon .. count)
    end,
    hl = { fg = "git_delete" },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and (self.change_icon .. count)
    end,
    hl = { fg = "git_change" },
  },
}

-- Diagnostics component
local Diagnostics = {
  condition = require("heirline.conditions").has_diagnostics,

  static = {
    error_icon = custom_icons.diagnostics.Error,
    warn_icon = custom_icons.diagnostics.Warn,
    info_icon = custom_icons.diagnostics.Info,
    hint_icon = custom_icons.diagnostics.Hint,
  },

  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,

  update = { "DiagnosticChanged", "BufEnter" },

  {
    provider = function(self)
      -- 0 is just another output, we can decide to print it or not!
      return self.errors > 0 and (self.error_icon .. self.errors .. " ")
    end,
    hl = { fg = "diag_error" },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
    end,
    hl = { fg = "diag_warn" },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. " ")
    end,
    hl = { fg = "diag_info" },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = { fg = "diag_hint" },
  },
}

-- LSP component
local LSPActive = {
  condition = conditions.lsp_attached,
  update = { "LspAttach", "LspDetach" },
  {
    provider = "",
    hl = { fg = "lsp" },
  },
  {
    provider = custom_icons.status.lsp .. " ",
    hl = { fg = "bg", bg = "lsp" },
  },
  {
    provider = function(self)
      local names = vim
        .iter(vim.lsp.get_clients { bufnr = self.bufnr })
        :map(function(server)
          return server.name
        end)
        :totable()
      return " " .. table.concat(names, " ")
    end,
    hl = { fg = "lsp", bg = "bg_bright" },
  },
  {
    provider = "",
    hl = { fg = "bg_bright" },
  },
}

-- CWD component
local WorkDirIcon = {
  provider = function()
    local icons = custom_icons.status
    local icon = vim.fn.haslocaldir(0) == 1 and icons.folder or icons.root_folder
    return icon .. " "
  end,
  hl = { fg = "bg", bg = "cwd" },
}

local WorkDirBasename = {
  provider = function()
    return string.format(" %s", vim.fs.basename(vim.uv.cwd()))
  end,
  hl = { fg = "cwd", bg = "bg_bright" },
}

local Cwd = {
  { provider = "", hl = { fg = "cwd" } },
  WorkDirIcon,
  WorkDirBasename,
  { provider = "", hl = { fg = "bg_bright" } },
}

-- Ruler component
local Ruler = {
  {
    provider = "",
    hl = { fg = "ruler", bg = "bg" },
  },
  {
    provider = " ",
    hl = { fg = "bg", bg = "ruler" },
  },
  {
    provider = " %l/%c",
    hl = { fg = "ruler", bg = "bg_bright" },
  },
  {
    provider = "",
    hl = { fg = "bg_bright", bg = "bg" },
  },
}

local TerminalStatusline = {
  condition = function()
    return conditions.buffer_matches {
      buftype = { "terminal" },
    }
  end,
  {
    condition = conditions.is_active,
    ViMode,
    Space,
  },
  TerminalName,
  Align,
}

local TelescopeStatusLine = {
  condition = function()
    return conditions.buffer_matches {
      filetype = { "TelescopePrompt" },
    }
  end,
  -- left
  ViMode,
  Space,
  {
    {
      provider = "",
      hl = { fg = "red", bg = "bg" },
    },
    {
      provider = " ",
      hl = { fg = "bg", bg = "red" },
    },
    {
      provider = " Telescope ",
      hl = { fg = "red", bg = "bg_bright" },
    },
    {
      provider = "",
      hl = { fg = "bg_bright", bg = "bg" },
    },
  },
  Align,
  -- middle
  Align,
  -- right
  Cwd,
  Space,
  Ruler,
}

local OilStatusLine = {
  condition = function()
    return conditions.buffer_matches {
      filetype = { "oil" },
    }
  end,
  -- left
  ViMode,
  Space,
  OilFileName,
  Align,

  -- middle
  Align,

  -- right
  Cwd,
  Space,
  Ruler,
}

local DefaultStatusLine = {
  -- global setting
  hl = { fg = "fg", bg = "bg" },
  -- left
  ViMode,
  Space,
  FileNameBlock,
  Space,
  Git,
  Align,

  -- middle
  Align,

  -- right
  {
    -- file encoding
    provider = function()
      local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
      return enc ~= "utf-8" and enc:upper()
    end,
  },
  Space,
  Diagnostics,
  Space,
  LSPActive,
  Space,
  Cwd,
  Space,
  Ruler,
}

local StatusLine = {
  fallthrough = false,
  TerminalStatusline,
  OilStatusLine,
  TelescopeStatusLine,
  DefaultStatusLine,
}

return StatusLine
