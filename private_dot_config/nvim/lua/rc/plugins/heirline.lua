local M = {
  "rebelot/heirline.nvim",
  event = "VeryLazy",
}

M.config = function()
  local conditions = require "heirline.conditions"
  local utils = require "heirline.utils"

  -- Picking colors from highlight groups.
  local function setup_colors()
    return {
      -- bright_bg = utils.get_highlight("Folded").bg,
      -- bright_fg = utils.get_highlight("Folded").fg,
      bright_bg = utils.get_highlight("Cursor").fg,
      bright_fg = utils.get_highlight("Cursor").bg,
      red = utils.get_highlight("DiagnosticError").fg,
      dark_red = utils.get_highlight("DiffDelete").bg,
      green = utils.get_highlight("String").fg,
      blue = utils.get_highlight("Function").fg,
      gray = utils.get_highlight("NonText").fg,
      orange = utils.get_highlight("Constant").fg,
      purple = utils.get_highlight("Statement").fg,
      cyan = utils.get_highlight("Special").fg,
      diag_warn = utils.get_highlight("DiagnosticWarn").fg,
      diag_error = utils.get_highlight("DiagnosticError").fg,
      diag_hint = utils.get_highlight("DiagnosticHint").fg,
      diag_info = utils.get_highlight("DiagnosticInfo").fg,
      git_del = utils.get_highlight("diffRemoved").fg,
      git_add = utils.get_highlight("diffAdded").fg,
      git_change = utils.get_highlight("diffChanged").fg,
    }
  end

  require("heirline").load_colors(setup_colors())

  -- [ Components ]
  local Align = { provider = "%=" }
  local Space = { provider = " " }

  local ViMode = {
    init = function(self)
      self.mode = vim.api.nvim_get_mode()["mode"]
      -- execute this only once, this is required if you want the ViMode
      -- component to be updated on operator pending mode
      if not self.once then
        vim.api.nvim_create_autocmd({ "ModeChanged", "CmdlineLeave" }, {
          pattern = "*:*o",
          command = "redrawstatus",
        })
        self.once = true
      end
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
      mode_colors = {
        n = "blue",
        i = "green",
        v = "purple",
        V = "purple",
        ["\22"] = "purple",
        c = "orange",
        s = "cyan",
        S = "cyan",
        ["\19"] = "cyan",
        R = "red",
        r = "red",
        ["!"] = "orange",
        t = "green",
      },
    },
    provider = function(self)
      return "  %2(" .. self.mode_names[self.mode] .. "%) "
    end,
    -- provider = "▊",

    hl = function(self)
      local mode = self.mode:sub(1, 1) -- get only the first mode character
      return { fg = "bright_bg", bg = self.mode_colors[mode], bold = true }
    end,
    update = {
      "ModeChanged",
      "CmdlineLeave",
    },
  }

  local FileNameBlock = {
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(0)
    end,
  }

  local FileIcon = {
    init = function(self)
      local filename = self.filename
      local extension = vim.fn.fnamemodify(filename, ":e")
      self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
      return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
      return { fg = self.icon_color }
    end,
  }

  local FileName = {
    init = function(self)
      self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
      if self.lfilename == "" then
        self.lfilename = "[No Name]"
      end
      if not conditions.width_percent_below(#self.lfilename, 0.27) then
        self.lfilename = vim.fn.pathshorten(self.lfilename)
      end
    end,
    hl = "Directory",

    utils.make_flexible_component(2, {
      provider = function(self)
        return self.lfilename
      end,
    }, {
      provider = function(self)
        return vim.fn.pathshorten(self.lfilename)
      end,
    }),
  }

  local FileFlags = {
    {
      provider = function()
        if vim.bo.modified then
          return ""
        end
      end,
      hl = { fg = "green" },
    },
    {
      provider = function()
        if not vim.bo.modifiable or vim.bo.readonly then
          return ""
        end
      end,
      hl = "Constant",
    },
  }

  local FileNameModifer = {
    hl = function()
      if vim.bo.modified then
        return { fg = "cyan", bold = true, force = true }
      end
    end,
  }

  FileNameBlock = utils.insert(FileNameBlock, FileIcon, utils.insert(FileNameModifer, FileName), unpack(FileFlags))

  local FileType = {
    provider = function()
      return string.upper(vim.bo.filetype)
    end,
    hl = "Type",
  }

  local FileEncoding = {
    provider = function()
      local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc -- :h 'enc'
      return enc ~= "utf-8" and enc:upper()
    end,
  }

  local FileFormat = {
    provider = function()
      local fmt = vim.bo.fileformat
      return fmt ~= "unix" and fmt:upper()
    end,
  }

  local FileSize = {
    provider = function()
      -- stackoverflow, compute human readable file size
      local suffix = { "b", "k", "M", "G", "T", "P", "E" }
      local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
      fsize = (fsize < 0 and 0) or fsize
      if fsize <= 0 then
        return "0" .. suffix[1]
      end
      local i = math.floor((math.log(fsize) / math.log(1024)))
      return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i])
    end,
  }

  local FileLastModified = {
    provider = function()
      local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
      return (ftime > 0) and os.date("%c", ftime)
    end,
  }

  local Ruler = {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %v = virtual column number (screen column)
    -- %P = percentage through file of displayed window
    provider = "%7(%l/%3L%) %-2v %P",
  }

  local ScrollBar = {
    static = {
      sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
    },
    provider = function(self)
      local curr_line = vim.api.nvim_win_get_cursor(0)[1]
      local lines = vim.api.nvim_buf_line_count(0)
      local i = math.floor(curr_line / lines * (#self.sbar - 1)) + 1
      return string.rep(self.sbar[i], 2)
    end,
    hl = { fg = "orange", bg = "bright_bg" },
  }

  local LSPActive = {
    condition = conditions.lsp_attached,
    update = { "LspAttach", "LspDetach" },

    -- provider = " [LSP]",
    -- Or complicate things a bit and get the servers names
    provider = function(_)
      local names = {}
      for _, server in ipairs(vim.lsp.buf_get_clients(0)) do
        table.insert(names, server.name)
      end
      return " [" .. table.concat(names, "|") .. "]"
    end,
    hl = { fg = "green" },
    on_click = {
      name = "heirline_LSP",
      callback = function()
        vim.defer_fn(function()
          vim.cmd "LspInfo"
        end, 100)
      end,
    },
  }

  local Navic = {
    condition = require("nvim-navic").is_available,
    static = {
      -- create a type highlight map
      type_hl = {
        File = "Directory",
        Module = "@include",
        Namespace = "@namespace",
        Package = "@include",
        Class = "@structure",
        Method = "@method",
        Property = "@property",
        Field = "@field",
        Constructor = "@constructor",
        Enum = "@field",
        Interface = "@type",
        Function = "@function",
        Variable = "@variable",
        Constant = "@constant",
        String = "@string",
        Number = "@number",
        Boolean = "@boolean",
        Array = "@field",
        Object = "@type",
        Key = "@keyword",
        Null = "@comment",
        EnumMember = "@field",
        Struct = "@structure",
        Event = "@keyword",
        Operator = "@operator",
        TypeParameter = "@type",
      },
      -- bit operation dark magic, see below...
      enc = function(line, col, winnr)
        return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
      end,
      -- line: 16 bit (65535); col: 10 bit (1023); winnr: 6 bit (63)
      dec = function(c)
        local line = bit.rshift(c, 16)
        local col = bit.band(bit.rshift(c, 6), 1023)
        local winnr = bit.band(c, 63)
        return line, col, winnr
      end,
    },
    init = function(self)
      local data = require("nvim-navic").get_data() or {}
      local children = {}
      -- create a child for each level
      for i, d in ipairs(data) do
        -- encode line and column numbers into a single integer
        local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
        local child = {
          {
            provider = d.icon,
            hl = self.type_hl[d.type],
          },
          {
            -- escape `%`s (elixir) and buggy default separators
            provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ""),
            -- highlight icon only or location name as well
            -- hl = self.type_hl[d.type],

            on_click = {
              -- pass the encoded position through minwid
              minwid = pos,
              callback = function(_, minwid)
                -- decode
                local line, col, winnr = self.dec(minwid)
                vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
              end,
              name = "heirline_navic",
            },
          },
        }
        -- add a separator only if needed
        if #data > 1 and i < #data then
          table.insert(child, {
            provider = " > ",
            hl = { fg = "bright_fg" },
          })
        end
        table.insert(children, child)
      end
      -- instantiate the new child, overwriting the previous one
      self.child = self:new(children, 1)
    end,
    -- evaluate the children containing navic components
    provider = function(self)
      return self.child:eval()
    end,
    hl = { fg = "gray" },
    update = "CursorMoved",
  }

  local Diagnostics = {

    condition = conditions.has_diagnostics,
    update = { "DiagnosticChanged", "BufEnter" },
    on_click = {
      callback = function()
        require("trouble").toggle { mode = "document_diagnostics" }
      end,
      name = "heirline_diagnostics",
    },

    static = {
      error_icon = require("rc.core.ui.icons").diagnostics.Error_alt,
      warn_icon = require("rc.core.ui.icons").diagnostics.Warning_alt,
      info_icon = require("rc.core.ui.icons").diagnostics.Information_alt,
      hint_icon = require("rc.core.ui.icons").diagnostics.Hint_alt,
    },

    init = function(self)
      self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
      self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,

    {
      provider = function(self)
        return self.errors > 0 and (self.error_icon .. self.errors .. " ") or ""
      end,
      hl = "DiagnosticError",
    },
    {
      provider = function(self)
        return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ") or ""
      end,
      hl = "DiagnosticWarn",
    },
    {
      provider = function(self)
        return self.info > 0 and (self.info_icon .. self.info .. " ") or ""
      end,
      hl = "DiagnosticInfo",
    },
    {
      provider = function(self)
        return self.hints > 0 and (self.hint_icon .. self.hints) or ""
      end,
      hl = "DiagnosticHint",
    },
  }

  local Git = {
    condition = conditions.is_git_repo,

    init = function(self)
      self.status_dict = vim.b.gitsigns_status_dict
      self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,

    on_click = {
      callback = function(self, minwid, nclicks, button)
        vim.defer_fn(function()
          vim.cmd "Lazygit %:p:h"
        end, 100)
      end,
      name = "heirline_git",
      update = false,
    },

    hl = { fg = "orange" },

    {
      provider = function(self)
        return " " .. self.status_dict.head
      end,
      hl = { bold = true },
    },
    {
      condition = function(self)
        return self.has_changes
      end,
      provider = "(",
    },
    {
      provider = function(self)
        local count = self.status_dict.added or 0
        return count > 0 and ("+" .. count)
      end,
      hl = "diffAdded",
    },
    {
      provider = function(self)
        local count = self.status_dict.removed or 0
        return count > 0 and ("-" .. count)
      end,
      hl = "diffRemoved",
    },
    {
      provider = function(self)
        local count = self.status_dict.changed or 0
        return count > 0 and ("~" .. count)
      end,
      hl = "diffChanged",
    },
    {
      condition = function(self)
        return self.has_changes
      end,
      provider = ")",
    },
  }

  local Snippets = {
    condition = function()
      return vim.tbl_contains({ "s", "i" }, vim.fn.mode())
    end,
    provider = function()
      local forward = require("luasnip").expand_or_jumpable() and "" or ""
      local backward = require("luasnip").jumpable(-1) and " " or ""
      return backward .. forward
    end,
    hl = { fg = "red", bg = "bright_bg", bold = true },
  }

  ViMode = { ViMode, Snippets }

  -- local DAPMessages = {
  --   condition = function()
  --     local session = require("dap").session()
  --     if session then
  --       local filename = vim.api.nvim_buf_get_name(0)
  --       if session.config then
  --         local progname = session.config.program
  --         return filename == progname
  --       end
  --     end
  --     return false
  --   end,
  --   provider = function()
  --     return " " .. require("dap").status()
  --   end,
  --   hl = "Debug",
  --   --       ﰇ  
  -- }

  -- local UltTest = {
  --     condition = function()
  --         return vim.api.nvim_call_function("ultest#is_test_file", {}) ~= 0
  --     end,
  --     static = {
  --         passed_icon = vim.fn.sign_getdefined("test_pass")[1].text,
  --         failed_icon = vim.fn.sign_getdefined("test_fail")[1].text,
  --         passed_hl = { fg = utils.get_highlight("UltestPass").fg },
  --         failed_hl = { fg = utils.get_highlight("UltestFail").fg },
  --     },
  --     init = function(self)
  --         self.status = vim.api.nvim_call_function("ultest#status", {})
  --     end,
  --     {
  --         provider = function(self)
  --             return self.passed_icon .. self.status.passed .. " "
  --         end,
  --         hl = function(self)
  --             return self.passed_hl
  --         end,
  --     },
  --     {
  --         provider = function(self)
  --             return self.failed_icon .. self.status.failed .. " "
  --         end,
  --         hl = function(self)
  --             return self.failed_hl
  --         end,
  --     },
  --     {
  --         provider = function(self)
  --             return "of " .. self.status.tests - 1
  --         end,
  --     },
  -- }
  local WorkDirIcon = {
    init = function(self)
      self.icon = (vim.fn.haslocaldir(0) == 1 and " " or " ")
    end,
    provider = function(self)
      return self.icon
    end,
    hl = "Directory",
  }

  local WorkDirName = {
    init = function(self)
      local cwd = vim.fn.getcwd(0)
      self.cwd = vim.fn.fnamemodify(cwd, ":~")
    end,
    hl = { fg = "bright_fg", bold = true },

    flexible = 1,

    {
      -- evaluates to the full-lenth path
      provider = function(self)
        local trail = self.cwd:sub(-1) == "/" and "" or "/"
        return self.cwd .. trail .. " "
      end,
    },
    {
      -- evaluates to the shortened path
      provider = function(self)
        local cwd = vim.fn.pathshorten(self.cwd)
        local trail = self.cwd:sub(-1) == "/" and "" or "/"
        return cwd .. trail .. " "
      end,
    },
    {
      -- evaluates to "", hiding the component
      provider = "",
    },
  }

  local WorkDir = {
    on_click = {
      callback = function()
        vim.cmd "Neotree toggle"
      end,
      name = "heirline_workdir",
    },
    WorkDirIcon,
    WorkDirName,
  }

  -- local WorkDir = {
  --   provider = function(self)
  --     self.icon = (vim.fn.haslocaldir(0) == 1 and "l" or "g") .. " " .. " "
  --     local cwd = vim.fn.getcwd(0)
  --     self.cwd = vim.fn.fnamemodify(cwd, ":~")
  --     if not conditions.width_percent_below(#self.cwd, 0.27) then
  --       self.cwd = vim.fn.pathshorten(self.cwd)
  --     end
  --   end,
  --   hl = { fg = "blue", bold = true },
  --   on_click = {
  --     callback = function()
  --       vim.cmd "Neotree toggle"
  --     end,
  --     name = "heirline_workdir",
  --   },
  --
  --   utils.make_flexible_component(1, {
  --     provider = function(self)
  --       local trail = self.cwd:sub(-1) == "/" and "" or "/"
  --       return self.icon .. self.cwd .. trail .. " "
  --     end,
  --   }, {
  --     provider = function(self)
  --       local cwd = vim.fn.pathshorten(self.cwd)
  --       local trail = self.cwd:sub(-1) == "/" and "" or "/"
  --       return self.icon .. cwd .. trail .. " "
  --     end,
  --   }, {
  --     provider = "",
  --   }),
  -- }

  local HelpFilename = {
    condition = function()
      return vim.bo.filetype == "help"
    end,
    provider = function()
      local filename = vim.api.nvim_buf_get_name(0)
      return vim.fn.fnamemodify(filename, ":t")
    end,
    hl = "Directory",
  }

  local TerminalName = {
    -- icon = ' ', -- 
    {
      provider = function()
        local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
        return " " .. tname
      end,
      hl = { fg = "blue", bold = true },
    },
    { provider = " - " },
    {
      provider = function()
        return vim.b.term_title
      end,
    },
    {
      provider = function()
        local id = require("terminal"):current_term_index()
        return " " .. (id or "Exited")
      end,
      hl = { bold = true, fg = "blue" },
    },
  }

  local Spell = {
    condition = function()
      return vim.wo.spell
    end,
    provider = "SPELL ",
    hl = { bold = true, fg = "orange" },
  }

  -- ViMode = utils.surround({ "", "" }, "bright_bg", { ViMode })

  local DefaultStatusline = {
    ViMode,
    Space,
    Spell,
    WorkDir,
    -- FileNameBlock,
    { provider = "%<" },
    Space,
    Git,
    -- Align,
    -- utils.make_flexible_component(3, Navic, { provider = "" }),
    -- DAPMessages,
    Align,
    LSPActive,
    Space,
    Diagnostics,
    Align,
    -- UltTest,
    Space,
    FileType,
    utils.make_flexible_component(3, { Space, FileEncoding }, { provider = "" }),
    Space,
    Ruler,
    Space,
    ScrollBar,
    Space,
    -- ViMode,
  }

  local InactiveStatusline = {
    condition = function()
      return not conditions.is_active()
    end,
    { hl = { fg = "gray", force = true }, WorkDir },
    FileNameBlock,
    { provider = "%<" },
    Align,
  }

  local SpecialStatusline = {
    condition = function()
      return conditions.buffer_matches {
        buftype = { "nofile", "prompt", "help", "quickfix" },
        filetype = { "^git.*", "fugitive" },
      }
    end,
    FileType,
    { provider = "%q" },
    Space,
    HelpFilename,
    Align,
  }

  local GitStatusline = {
    condition = function()
      return conditions.buffer_matches {
        filetype = { "^git.*", "fugitive" },
      }
    end,
    FileType,
    Space,
    {
      provider = function()
        return vim.fn.FugitiveStatusline()
      end,
    },
    Space,
    Align,
  }

  local TerminalStatusline = {
    condition = function()
      return conditions.buffer_matches { buftype = { "terminal" } }
    end,
    hl = { bg = "dark_red" },
    { condition = conditions.is_active, ViMode, Space },
    FileType,
    Space,
    TerminalName,
    Align,
  }

  local StatusLines = {

    hl = function()
      if conditions.is_active() then
        return "StatusLine"
      else
        return "StatusLineNC"
      end
    end,

    fallthrough = false,

    GitStatusline,
    SpecialStatusline,
    TerminalStatusline,
    -- InactiveStatusline,
    DefaultStatusline,
  }

  local CloseButton = {
    condition = function(_)
      return not vim.bo.modified
    end,
    -- update = 'BufEnter',
    update = { "WinNew", "WinClosed", "BufEnter" },
    { provider = " " },
    {
      provider = "",
      hl = { fg = "gray" },
      on_click = {
        callback = function(_, winid)
          vim.api.nvim_win_close(winid, true)
        end,
        name = function(self)
          return "heirline_close_button_" .. self.winnr
        end,
        update = true,
      },
    },
  }

  -- [ Window bar ]
  local WinBar = {
    fallthrough = false,
    {
      condition = function()
        return conditions.buffer_matches {
          buftype = { "nofile", "prompt", "help", "quickfix" },
          filetype = { "^git.*", "fugitive", "neo%-tree" },
        }
      end,
      init = function()
        vim.opt_local.winbar = nil
      end,
    },
    {
      condition = function()
        return conditions.buffer_matches { buftype = { "terminal" } }
      end,
      utils.surround({ "", "" }, "dark_red", {
        FileType,
        Space,
        TerminalName,
        CloseButton,
      }),
    },
    {
      utils.surround({ "", "" }, "bright_bg", {
        condition = conditions.is_active,
        hl = function()
          if not conditions.is_active() then
            return { fg = "gray", force = true }
          end
        end,
        utils.make_flexible_component(3, Navic, { provider = "" }),
      }),
    },
  }

  -- TabLine

  local TablineBufnr = {
    provider = function(self)
      return tostring(self.bufnr) .. ". "
    end,
    hl = "Comment",
  }

  local TablineFileName = {
    provider = function(self)
      -- self.filename will be defined later, just keep looking at the example!
      local filename = self.filename
      filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
      return filename
    end,
    hl = function(self)
      return { bold = self.is_active or self.is_visible, italic = true }
    end,
  }

  local TablineFileFlags = {
    {
      condition = function(self)
        return vim.api.nvim_buf_get_option(self.bufnr, "modified")
      end,
      provider = "[+]",
      hl = { fg = "green" },
    },
    {
      condition = function(self)
        return not vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
          or vim.api.nvim_buf_get_option(self.bufnr, "readonly")
      end,
      provider = function(self)
        if vim.api.nvim_buf_get_option(self.bufnr, "buftype") == "terminal" then
          return "  "
        else
          return ""
        end
      end,
      hl = { fg = "orange" },
    },
  }

  local TablineFileNameBlock = {
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(self.bufnr)
    end,
    hl = function(self)
      if self.is_active then
        return "TabLineSel"
      elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
        return { fg = "gray" }
      else
        return "TabLine"
      end
    end,
    on_click = {
      callback = function(_, minwid, _, button)
        if button == "m" then -- close on mouse middle click
          vim.api.nvim_buf_delete(minwid, { force = false })
        else
          vim.api.nvim_win_set_buf(0, minwid)
        end
      end,
      minwid = function(self)
        return self.bufnr
      end,
      name = "heirline_tabline_buffer_callback",
    },
    TablineBufnr,
    FileIcon,
    TablineFileName,
    TablineFileFlags,
  }

  local TablineCloseButton = {
    condition = function(self)
      return not vim.api.nvim_buf_get_option(self.bufnr, "modified")
    end,
    { provider = " " },
    {
      provider = " ",
      hl = { fg = "gray" },
      on_click = {
        callback = function(_, minwid)
          vim.api.nvim_buf_delete(minwid, { force = false })
        end,
        minwid = function(self)
          return self.bufnr
        end,
        name = "heirline_tabline_close_buffer_callback",
      },
    },
  }

  local TablineCurrentIcon = {
    provider = function(self)
      return self.is_active and "▎" or " "
    end,
    hl = { fg = "cyan" },
  }

  local TablineBufferBlock = {
    hl = function(self)
      if self.is_active then
        return "TabLineSel"
      else
        return "TabLine"
      end
    end,
    TablineCurrentIcon,
    TablineFileNameBlock,
    TablineCloseButton,
  }

  -- and here we go
  local BufferLine = utils.make_buflist(
    TablineBufferBlock,
    { provider = "", hl = { fg = "gray" } }, -- left truncation, optional (defaults to "<")
    { provider = "", hl = { fg = "gray" } } -- right trunctation, also optional (defaults to ...... yep, ">")
    -- by the way, open a lot of buffers and try clicking them ;)
  )

  local Tabpage = {
    provider = function(self)
      return "%" .. self.tabnr .. "T " .. self.tabnr .. " %T"
    end,
    hl = function(self)
      if not self.is_active then
        return "TabLine"
      else
        return "TabLineSel"
      end
    end,
  }

  local TabpageClose = {
    provider = "%999X  %X",
    hl = "TabLine",
  }

  local TabPages = {
    -- only show this component if there's 2 or more tabpages
    condition = function()
      return #vim.api.nvim_list_tabpages() >= 2
    end,
    { provider = "%=" },
    utils.make_tablist(Tabpage),
    TabpageClose,
  }

  local TabLineOffset = {
    condition = function(self)
      local win = vim.api.nvim_tabpage_list_wins(0)[1]
      local bufnr = vim.api.nvim_win_get_buf(win)
      self.winid = win

      if vim.bo[bufnr].filetype == "NvimTree" then
        self.title = "NvimTree"
        return true
        -- elseif vim.bo[bufnr].filetype == "TagBar" then
        --     ...
      end
    end,

    provider = function(self)
      local title = self.title
      local width = vim.api.nvim_win_get_width(self.winid)
      local pad = math.ceil((width - #title) / 2)
      return string.rep(" ", pad) .. title .. string.rep(" ", pad)
    end,

    hl = function(self)
      if vim.api.nvim_get_current_win() == self.winid then
        return "TablineSel"
      else
        return "Tabline"
      end
    end,
  }

  local TabLine = { TabLineOffset, BufferLine, TabPages }

  -- Setup statusline/winbar/tabline
  require("heirline").setup(StatusLines, WinBar, TabLine)

  -- Autocmds
  vim.api.nvim_create_augroup("Heirline", { clear = true })
  -- disable winbar on specific buffers or filetypes
  vim.api.nvim_create_autocmd("User", {
    pattern = "HeirlineInitWinbar",
    callback = function(args)
      local buf = args.buf
      local buftype = vim.tbl_contains({ "prompt", "nofile", "help", "quickfix" }, vim.bo[buf].buftype)
      local filetype = vim.tbl_contains({ "gitcommit", "fugitive" }, vim.bo[buf].filetype)
      if buftype or filetype then
        vim.opt_local.winbar = nil
      end
    end,
    group = "Heirline",
  })

  -- Reset colors for statusline when changing the colorscheme.
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
      utils.on_colorscheme(setup_colors())
    end,
    group = "Heirline",
  })

  -- Do not show hidden buffers on the bufferline.
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
      if vim.tbl_contains({ "wipe", "delete" }, vim.bo.bufhidden) then
        vim.bo.buflisted = false
      end
    end,
    group = "Heirline",
  })
end

return M
