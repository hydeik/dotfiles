local M = {}

M.nvim_web_devicons = {
  config = function()
    require("nvim-web-devicons").setup {
      default = true,
    }
  end,
}

M.indent_blankline_nvim = {
  config = function()
    require("indent_blankline").setup {
      char = "│",
      buftype_exclude = { "prompt", "terminal" },
      filetype_exclude = { "help", "packer" },
      use_treesitter = true,
      show_first_indent_level = false,
      show_current_context = true,
      show_end_of_line = true,
    }
  end,
}

M.satellite_nvim = {
  config = function()
    require("satellite").setup {
      current_only = true,
      exclude_filetypes = {
        "prompt",
        "TelescopePrompt",
      },
      handlers = {
        search = {
          enable = true,
        },
        diagnostic = {
          enable = true,
        },
        gitsigns = {
          enable = true,
        },
        marks = {
          enable = true,
          show_builtins = false, -- shows the builtin marks like [ ] < >
        },
      },
    }
  end,
}

M.nvim_colorizer = {
  config = function()
    require("colorizer").setup(nil, {
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      names = true, -- "Name" codes like Blue
      RRGGBBAA = true, -- #RRGGBBAA hex codes
      rgb_fn = true, -- CSS rgb() and rgba() functions
      hsl_fn = true, -- CSS hsl() and hsla() functions
      css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      -- Available modes: foreground, background
      mode = "background", -- Set the display mode.
    })
  end,
}

return M
