return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ts_ls = {
          enabled = false,
        },
        vtsls = {},
        denols = {
          -- root_dir = function(path, bufnr)
          --   return find_root(vim.fs.dirname(path), bufnr)
          -- end,
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
