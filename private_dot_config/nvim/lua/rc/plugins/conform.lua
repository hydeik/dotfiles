return {
  {
    "stevearc/conform.nvim",
    dependencies = {
      "mason.nvim",
      opts = {
        ensure_installed = {
          "fixjson",
          "shfmt",
          "stylua",
        },
      },
    },
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
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
        "<leader>cF",
        function()
          require("conform").format { formatters = { "injected" }, timeout_ms = 3000 }
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    -- Everything in opts will be passed to setup()
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        cmake = { "cmake_format" },
        javascript = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        jsonc = { "fixjson" },
        lua = { "stylua" },
        sh = { "shfmt" },
      },
      -- Set up format-on-save
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      -- Customize formatters
      formatters = {
        injected = {
          options = { ignore_errors = true },
        },
        shfmt = {
          prepend_args = { "-ln", "bash", "-i", "2", "-bn", "-ci", "-sr", "-kp" },
        },
      },
    },
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
