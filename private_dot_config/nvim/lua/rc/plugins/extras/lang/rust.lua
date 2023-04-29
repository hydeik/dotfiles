return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "simrat39/rust-tools.nvim",
    },
    opts = {
      servers = {
        rust_analyzer = {
          settings = {
            imports = {
              granularity = {
                group = "module",
              },
              prefix = "by_self",
            },
          },
        },
      },
      setup = {
        rust_analyzer = function(_, server_opts)
          local path = require "rc.core.path"
          local plat = require "rc.core.platform"
          local dylib_extension = "so"
          if plat.is_mac then
            dylib_extension = "dylib"
          elseif plat.is_windowns then
            dylib_extension = "dll"
          end
          local extenstion_path = path.join(path.datahome, "mason", "packages", "codelldb", "extension")
          local codelldb_path = path.join(extenstion_path, "adaptor", "codelldb")
          local liblldb_path = path.join(extenstion_path, "lldb", "lib", "liblldb." .. dylib_extension)
          require("rust-tools").setup {
            tools = {
              inray_hints = {
                auto = false,
              },
            },
            server = server_opts,
            dap = {
              adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
            },
          }
        end,
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "codelldb" })
      end
    end,
  },
}
