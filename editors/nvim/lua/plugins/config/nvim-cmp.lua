local M = {}

function M.config()
  vim.cmd [[packadd cmp-nvim-lsp]]
  vim.cmd [[packadd cmp-buffer]]
  vim.cmd [[packadd cmp-calc]]
  vim.cmd [[packadd cmp-emoji]]
  vim.cmd [[packadd cmp-nvim-lua]]
  vim.cmd [[packadd cmp-path]]
  vim.cmd [[packadd cmp-latex-symbols]]
  vim.cmd [[packadd cmp_luasnip]]

  -- Register sources
  for _, name in pairs {
    "buffer",
    "calc",
    "emoji",
    "nvim_lua",
    "path",
    "latex_symbols",
    "luasnip",
  } do
    require("cmp").register_source(name, require("cmp_" .. name).new())
  end
  require("cmp_nvim_lsp").setup {}

  local function cmp_formatting(_, vim_item)
    local kind_presets = {
      Text = " [text]",
      Method = "Ƒ [method]",
      Function = " [function]",
      Constructor = " [constructor]",
      Field = "ﰠ [field]",
      Variable = "",
      Class = " [class]",
      Interface = " [interface]",
      Module = " [module]",
      Property = " [property]",
      Unit = " [unit]",
      Value = " [value]",
      Enum = " [enum]",
      Keyword = " [key]",
      Snippet = "﬌ [snippet]",
      Color = " [color]",
      File = " [file]",
      Reference = " [reference]",
      Folder = " [folder]",
      EnumMember = " [enum member]",
      Constant = " [constant]",
      Struct = " [struct]",
      Event = " [event]",
      Operator = " [operator]",
      TypeParameter = " [type]",
    }
    vim_item.kind = kind_presets[vim_item.kind]
    return vim_item
  end
  -- Configurations
  local cmp = require "cmp"
  cmp.setup {
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
    },
    formatting = {
      format = cmp_formatting,
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "calc" },
      { name = "nvim_lua" },
      { name = "emoji" },
      { name = "path" },
      { name = "latex_symbols" },
      { name = "luasnip" },
    },
  }
end

return M
