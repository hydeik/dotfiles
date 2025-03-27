return {
  -- LSP server
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {},
      },
    },
  },
  -- Linter
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint-cli2" },
      },
    },
  },
  -- Formatter
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        ["markdown-toc"] = {
          -- apply markdwon-toc if the buffer contains `<!-- toc -->` line.
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find "<!%-%- toc %-%->" then
                return true
              end
            end
          end,
        },
        ["markdownlint-cli2"] = {
          -- Fix the markdown buffer if diagnostics provided by markdownlint are found.
          condition = function(_, ctx)
            local diagnostics = vim.tbl_filter(function(d)
              return d.source == "markdownlint"
            end, vim.diagnostic.get(ctx.buf))
            return #diagnostics > 0
          end,
        },
      },
      formatters_by_ft = {
        ["markdwon"] = { { "prettierd", "prettier" }, "markdownlint-cli2", "markdwon-toc" },
        ["markdwon.mdx"] = { { "prettierd", "prettier" }, "markdownlint-cli2", "markdwon-toc" },
      },
    },
  },

  -- Markdown preview
  {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = true,
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
      completions = {
        lsp = { enabled = true },
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      Snacks.toggle({
        name = "Render Markdown",
        get = function()
          return require("render-markdown.state").enabled
        end,
        set = function(enabled)
          local m = require "render-markdown"
          if enabled then
            m.enable()
          else
            m.disable()
          end
        end,
      }):map "<Space>um"
    end,
  },
}
