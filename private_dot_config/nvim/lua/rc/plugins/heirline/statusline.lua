local conditions = require "heirline.conditions"
local utils = require "heirline.utils"

local Align = { provider = "%=" }
local Space = { provider = " " }

-- Vi mode component
local ViMode = {
  init = function(self)
    self.mode = vim.api.nvim_get_mode()["mode"]
  end,
  static = {
    mode_names = {
      n = "N",
      no = "N?",
      nov = "N?",
      noV = "N?",
      ["no\22"] = "N?",
      niI = "Ni",
      niR = "Nr",
      niV = "Nv",
      nt = "Nt",
      v = "V",
      vs = "Vs",
      V = "V_",
      Vs = "Vs",
      ["\22"] = "^V",
      ["\22s"] = "^V",
      s = "S",
      S = "S_",
      ["\19"] = "^S",
      i = "I",
      ic = "Ic",
      ix = "Ix",
      R = "R",
      Rc = "Rc",
      Rx = "Rx",
      Rv = "Rv",
      Rvc = "Rv",
      Rvx = "Rv",
      c = "C",
      cv = "Ex",
      r = "...",
      rm = "M",
      ["r?"] = "?",
      ["!"] = "!",
      t = "T",
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
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon = require("nvim-web-devicons").get_icon(filename, extension, { default = true })
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

-- Git component
local Git = {
  condition = conditions.is_git_repo,
  static = {
    branch_icon = require("rc.core.config").icons.git.branch,
    add_icon = require("rc.core.config").icons.git.added,
    remove_icon = require("rc.core.config").icons.git.removed,
    change_icon = require("rc.core.config").icons.git.modified,
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
    error_icon = require("rc.core.config").icons.diagnostics.Error,
    warn_icon = require("rc.core.config").icons.diagnostics.Warn,
    info_icon = require("rc.core.config").icons.diagnostics.Info,
    hint_icon = require("rc.core.config").icons.diagnostics.Hint,
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
    provider = require("rc.core.config").icons.status.lsp .. " ",
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
    local icons = require("rc.core.config").icons.status
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

local StatusLine = {
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

return StatusLine
