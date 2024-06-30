local conditions = require "heirline.conditions"
local utils = require "heirline.utils"

--- Blend two rgb colors using alpha
---@param color1 string | number first color
---@param color2 string | number second color
---@param alpha number (0, 1) float determining the weighted average
---@return string color hex string of the blended color
local blend = function(color1, color2, alpha)
  color1 = type(color1) == "number" and string.format("#%06x", color1) or color1
  color2 = type(color2) == "number" and string.format("#%06x", color2) or color2
  local r1, g1, b1 = color1:match "#(%x%x)(%x%x)(%x%x)"
  local r2, g2, b2 = color2:match "#(%x%x)(%x%x)(%x%x)"
  local r = tonumber(r1, 16) * alpha + tonumber(r2, 16) * (1 - alpha)
  local g = tonumber(g1, 16) * alpha + tonumber(g2, 16) * (1 - alpha)
  local b = tonumber(b1, 16) * alpha + tonumber(b2, 16) * (1 - alpha)
  return "#"
    .. string.format("%02x", math.min(255, math.max(r, 0)))
    .. string.format("%02x", math.min(255, math.max(g, 0)))
    .. string.format("%02x", math.min(255, math.max(b, 0)))
end

--- Generate dim color
---@param color string | number original color
---@param alpha number (0, 1) float determining the weighted average
local dim = function(color, alpha)
  return blend(color, "#000000", alpha)
end

local PATH_SEPARATOR = package.config:sub(1, 1)

local Separator = {
  provider = "  ",
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

local FileBaseName = {
  provider = function(self)
    local filename = vim.fs.basename(self.filename)
    if filename == "" then
      return " [No Name]"
    end
    return string.format(" %s", filename)
  end,
  hl = { fg = "fg_bright", bold = true },
}

local FileDirName = {
  static = {
    get_entries = function(dirname, path_separator)
      if dirname == "." then
        return {}
      end

      local entries = {}
      local dirname_ = dirname
      if dirname_:sub(1, 1) == "/" then
        table.insert(entries, "/")
      end

      local protocol_start_index = dirname_:find "://"
      if protocol_start_index ~= nil then
        local protocol = dirname_:sub(1, protocol_start_index + 2)
        table.insert(entries, protocol)
        -- remove protocol name from the dirname string
        dirname_ = dirname_:sub(protocol_start_index + 3)
      end

      vim.list_extend(entries, vim.split(dirname, path_separator, { trimempty = true }))

      return entries
    end,
  },
  init = function(self)
    local dirname = vim.fn.fnamemodify(self.filename, ":~:.:h")
    local dirs = self.get_entries(dirname, PATH_SEPARATOR)
    local children = {}

    for _, dir in ipairs(dirs) do
      local child = {
        provider = dir,
        hl = { fg = "cyan" },
      }
      table.insert(children, child)
      table.insert(children, Separator)
    end

    self[1] = self:new(children, 1)
  end,
}

local FileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  FileDirName,
  FileIcon,
  FileBaseName,
}

local Navic = {
  condition = function()
    return require("nvim-navic").is_available()
  end,
  static = {
    type_hl = {
      File = dim(utils.get_highlight("Directory").fg, 0.75),
      Module = dim(utils.get_highlight("@module").fg, 0.75),
      Namespace = dim(utils.get_highlight("@lsp.type.namespace").fg, 0.75),
      Package = dim(utils.get_highlight("@module").fg, 0.75),
      Class = dim(utils.get_highlight("@lsp.type.type").fg, 0.75),
      Method = dim(utils.get_highlight("@lsp.type.method").fg, 0.75),
      Property = dim(utils.get_highlight("@lsp.type.property").fg, 0.75),
      Field = dim(utils.get_highlight("@lsp.type.property").fg, 0.75),
      Constructor = dim(utils.get_highlight("@constructor").fg, 0.75),
      Enum = dim(utils.get_highlight("@lsp.type.type").fg, 0.75),
      Interface = dim(utils.get_highlight("@lsp.type.type").fg, 0.75),
      Function = dim(utils.get_highlight("@function").fg, 0.75),
      Variable = dim(utils.get_highlight("@variable").fg, 0.75),
      Constant = dim(utils.get_highlight("@constant").fg, 0.75),
      String = dim(utils.get_highlight("@lsp.type.string").fg, 0.75),
      Number = dim(utils.get_highlight("@lsp.type.number").fg, 0.75),
      Boolean = dim(utils.get_highlight("@boolean").fg, 0.75),
      Array = dim(utils.get_highlight("@lsp.type.property").fg, 0.75),
      Object = dim(utils.get_highlight("@lsp.type.type").fg, 0.75),
      Key = dim(utils.get_highlight("@keyword").fg, 0.75),
      Null = dim(utils.get_highlight("@comment").fg, 0.75),
      EnumMember = dim(utils.get_highlight("@lsp.type.enumMember").fg, 0.75),
      Struct = dim(utils.get_highlight("@lsp.type.type").fg, 0.75),
      Event = dim(utils.get_highlight("@lsp.type.type").fg, 0.75),
      Operator = dim(utils.get_highlight("@lsp.type.operator").fg, 0.75),
      TypeParameter = dim(utils.get_highlight("@lsp.type.type").fg, 0.75),
    },
    -- line: 16 bit (65536); col: 10 bit (1024); winnr: 6 bit (64)
    -- local encdec = function(a,b,c) return dec(enc(a,b,c)) end; vim.pretty_print(encdec(2^16 - 1, 2^10 - 1, 2^6 - 1))
    enc = function(line, col, winnr)
      return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
    end,
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
    for i, d in ipairs(data) do
      local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
      local child = {
        {
          provider = d.icon,
          hl = { fg = self.type_hl[d.type] },
        },
        {
          provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ""),
          -- hl = { fg = self.type_hl[d.type] },
          -- hl = self.type_hl[d.type],
          on_click = {
            callback = function(_, minwid)
              local line, col, winnr = self.dec(minwid)
              vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
            end,
            minwid = pos,
            name = "heirline_navic",
          },
        },
      }
      if i < #data then
        table.insert(child, {
          provider = "  ",
          hl = { fg = "fg_bright" },
        })
      end
      table.insert(children, child)
    end
    self[1] = self:new(children, 1)
  end,
  update = "CursorMoved",
  hl = { fg = "fg_dim" },
}

local WinBar = {
  fallthrough = false,
  {
    condition = conditions.is_not_active,
    {
      hl = { fg = "fg_dim", force = true },
      FileNameBlock,
    },
  },
  {
    FileNameBlock,
    Separator,
    Navic,
  },
}

return WinBar
