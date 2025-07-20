return {
  -- Enhanced increment/decrement plugin for Neovim.
  "monaqa/dial.nvim",
  keys = {
    {
      "<C-a>",
      function()
        require("dial.map").manipulate("increment", "normal")
      end,
      desc = "Dial increment",
    },
    {
      "<C-x>",
      function()
        require("dial.map").manipulate("decrement", "normal")
      end,
      desc = "Dial decrement",
    },
    {
      "g<C-a>",
      function()
        require("dial.map").manipulate("increment", "gnormal")
      end,
      desc = "Dial increment",
    },
    {
      "g<C-x>",
      function()
        require("dial.map").manipulate("decrement", "gnormal")
      end,
      desc = "Dial decrement",
    },
    {
      "<C-a>",
      function()
        require("dial.map").manipulate("increment", "visual")
      end,
      mode = "v",
      desc = "Dial increment",
    },
    {
      "<C-x>",
      function()
        require("dial.map").manipulate("decrement", "visual")
      end,
      mode = "v",
      desc = "Dial decrement",
    },
    {
      "g<C-a>",
      function()
        require("dial.map").manipulate("increment", "gvisual")
      end,
      mode = "v",
      desc = "Dial increment",
    },
    {
      "g<C-x>",
      function()
        require("dial.map").manipulate("decrement", "gvisual")
      end,
      mode = "v",
      desc = "Dial decrement",
    },
  },
  opts = function()
    local augend = require "dial.augend"

    return {
      groups = {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.integer.alias.binary,
          augend.decimal_fraction.new { signed = true },
          augend.date.new {
            pattern = "%Y/%m/%d",
            default_kind = "day",
            clamp = true,
            end_sensitive = true,
          },
          augend.date.new {
            pattern = "%Y-%m-%d",
            default_kind = "day",
            clamp = true,
            end_sensitive = true,
          },
          augend.date.new {
            pattern = "%Y年%-m月%-d日",
            default_kind = "day",
            clamp = true,
            end_sensitive = true,
          },
          augend.date.new {
            pattern = "%-m月%-d日",
            default_kind = "day",
            clamp = true,
            end_sensitive = true,
          },
          augend.date.new {
            pattern = "%-m月%-d日(%J)",
            default_kind = "day",
            clamp = true,
            end_sensitive = true,
          },
          augend.date.new {
            pattern = "%-m月%-d日（%J）",
            default_kind = "day",
            clamp = true,
            end_sensitive = true,
          },
          augend.date.new {
            pattern = "%m/%d",
            default_kind = "day",
            only_valid = true,
            word = true,
            clamp = true,
            end_sensitive = true,
          },
          augend.date.new {
            pattern = "%Y/%m/%d (%J)",
            default_kind = "day",
            clamp = true,
            end_sensitive = true,
          },
          augend.date.new {
            pattern = "%Y/%m/%d（%J）",
            default_kind = "day",
            clamp = true,
            end_sensitive = true,
          },
          augend.date.new {
            pattern = "%a %b %-d %Y",
            default_kind = "day",
            clamp = true,
            end_sensitive = true,
          },
          augend.date.new {
            pattern = "%H:%M",
            default_kind = "min",
            only_valid = true,
            word = true,
          },
          augend.constant.new {
            elements = { "true", "false" },
            word = true,
            cyclic = true,
          },
          augend.constant.new {
            elements = { "True", "False" },
            word = true,
            cyclic = true,
          },
          augend.constant.new {
            elements = { "&&", "||" },
            word = false,
            cyclic = true,
          },
          augend.constant.alias.ja_weekday,
          augend.constant.alias.ja_weekday_full,
          augend.hexcolor.new { case = "lower" },
          augend.semver.alias.semver,
        },
      },
      on_ft = {
        javascript = {
          augend.constant.new { elements = { "let", "const" } },
        },
        typescript = {
          augend.constant.new { elements = { "let", "const" } },
        },
        markdown = {
          augend.constant.new {
            elements = { "[ ]", "[x]" },
            word = false,
            cyclic = true,
          },
          augend.misc.alias.markdown_header,
        },
        lua = {
          augend.constant.new {
            elements = { "and", "or" },
            word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
            cyclic = true, -- "or" is incremented into "and".
          },
        },
        python = {
          augend.constant.new {
            elements = { "and", "or" },
          },
        },
      },
    }
  end,
  config = function(_, opts)
    opts.groups = opts.groups and opts.group or {}
    opts.on_ft = opts.on_ft and opts.on_ft or {}
    for name, group in pairs(opts.on_ft) do
      vim.list_extend(opts.on_ft[name], opts.groups.default and opts.groups.default or {})
    end
    require("dial.config").augends:register_group(opts.groups)
    require("dial.config").augends:on_filetype(opts.on_ft)
  end,
}
