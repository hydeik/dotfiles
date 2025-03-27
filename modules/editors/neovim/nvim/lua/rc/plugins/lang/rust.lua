-- Set vim.g.vimrc_rust_diagnostics to "bacon-ls" to use bacon-ls instead of rust-analyzer
-- for showing diagnostics. The rest of LSP features will still be provided by rust-analyzer.
local diagnostics = vim.g.vimrc_rust_diagnostics or "rust_analyzer"

return {
  -- LSP for Cargo.toml
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
  -- Treesitter (add Rust & related)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "rust", "ron" } },
  },
  -- Rustaceanvim
  {
    "mrcjkb/rustaceanvim",
    version = false,
    ft = { "rust" },
    opts = {
      server = {
        on_attach = function(_, bufnr)
          -- add/override Rust specific keybindings
          vim.keymap.set("n", "<Space>cR", function()
            vim.cmd.RustLsp "codeAction"
          end, { desc = "Code Action (Rust)", buffer = bufnr })
          vim.keymap.set("n", "<Space>dr", function()
            vim.cmd.RustLsp "dubuggables"
          end, { desc = "Rust Debuggables", buffer = bufnr })
        end,
        default_settings = {
          ["rust_analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            checkOnSave = diagnostics == "rust-analyzer",
            diagnostics = {
              -- Enable diagnostics if using rust-analyzer
              enable = diagnostics == "rust-analyzer",
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
            files = {
              excludeDirs = {
                ".direnv",
                ".git",
                ".github",
                ".gitlab",
                "bin",
                "node_modules",
                "target",
                "venv",
                ".venv",
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
      if vim.fn.executable "rust-analyzer" then
        require("rc.utils").error(
          "**rust-analyzer** not found in PATH. Please install it.\nhttps://rust-analyzer.github.io/",
          { title = "rustaceanvim" }
        )
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bacon_ls = { enabled = diagnostics == "bacon-ls" },
        -- rustaceanvim lauches rust-analyzer, so do not call `lspconfig.rust_analyzer.setup`.
        rust_analyzer = { enabled = false },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    opts = {
      adapters = {
        ["rustaceanvim.neotest"] = {},
      },
    },
  },
}
