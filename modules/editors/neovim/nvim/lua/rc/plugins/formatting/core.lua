return {
  {
    "stevearc/conform.nvim",
    lazy = true,
    cmd = "ConformInfo",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<Space>cf",
        function()
          require("conform").format { async = true, lsp_fallback = true }
        end,
        mode = "",
        desc = "Format buffer",
      },
      {
        "<Space>cF",
        function()
          require("conform").format { formatters = { "injected" }, timeout_ms = 3000 }
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    ---@type conform.setupOpts
    opts = {
      default_format_opts = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
      },
      ---@param bufnr number
      format_on_save = function(bufnr)
        -- Disable with a global (vim.g.autoformat) or buffer-local variable (vim.b[bufnr].autoformat)
        if not require("rc.utils.format").enabled(bufnr) then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
      formatters = {
        injected = {
          options = { ignore_errors = true },
        },
        shfmt = {
          prepend_args = { "-ln", "bash", "-i", "2", "-bn", "-ci", "-sr", "-kp" },
        },
        stylua = {
          require_cwd = true,
        },
      },
    },
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
