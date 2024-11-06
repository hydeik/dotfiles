--- [mini.icons](https://github.com/echasnovski/mini.icons)
-- Icon Provider. Part of 'mini.nvim' library.

-- lua_source {{{
require("mini.icons").setup {
  file = {
    [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
    ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
    -- Go
    [".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
    -- Typescript
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
  filetype = {
    -- Dotenv
    dotenv = { glyph = "", hl = "MiniIconsYellow" },
    -- Go
    gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
  },
}

-- }}}
