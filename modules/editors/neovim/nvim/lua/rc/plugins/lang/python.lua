return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "ninja", "requirements", "rst" } },
  },
  {
    "nvim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          settings = {
            cmd_env = { RUFF_TRACE = "messages" },
            init_options = {
              settings = { logLevel = "error" },
            },
            keys = {
              {
                "<Space>co",
                require("rc.utils.lsp").action["source.organizeImports"],
                desc = "Organize Imports",
              },
            },
          },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "mypy" },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          -- runner = "pytest",
          -- python = ".venv/bin/python",
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "mfussenegger/nvim-dap-python",
        -- stylua: ignore
        keys = {
          { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
          { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
        },
      config = function()
        require("dap-python").setup "uv"
      end,
    },
  },
}
