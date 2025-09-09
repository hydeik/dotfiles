local deno_markers = { "deno.json", "deno.jsonc", "deps.ts" }
local node_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock", "package.json" }

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ts_ls = {
          enabled = false,
        },
        denols = {
          root_dir = function(bufnr, on_dir)
            local deno_dir = vim.fs.root(bufnr, deno_markers)
            if deno_dir then
              return on_dir(deno_dir)
            end

            local node_dir = vim.fs.root(bufnr, node_markers)
            if node_dir then
              return
            end

            -- local cwd = vim.fs.dirname(vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr)))
            -- return on_dir(cwd)
            return on_dir(vim.env.PWD)
          end,
          settings = {
            deno = {
              enable = true,
              unstable = true,
              lint = true,
              suggest = {
                completeFunctionCalls = true,
                autoImports = false,
                imports = {
                  hosts = {
                    ["https://deno.land"] = true,
                    ["https://denopkg.com"] = true,
                    ["https://crux.land"] = true,
                    ["https://x.nest.land"] = true,
                    ["https://jsr.io"] = true,
                  },
                },
              },
            },
          },
        },
        vtsls = {
          root_dir = function(bufnr, on_dir)
            local deno_dir = vim.fs.root(bufnr, deno_markers)
            local node_dir = vim.fs.root(bufnr, node_markers)
            if node_dir and deno_dir == nil then
              on_dir(node_dir)
            end
          end,
          settings = {
            typescript = {
              preferences = { preferTypeOnlyAutoImport = true },
            },
          },
        },
      },
    },
  },
  -- Filetype icons
  {
    "echasnovski/mini.icons",
    opts = {
      file = {
        [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
        [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
        [".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
        ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
        ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
      },
    },
  },
}
