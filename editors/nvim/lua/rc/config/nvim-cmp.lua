local M = {}

function M.config()
  vim.cmd [[packadd cmp-nvim-lsp]]
  vim.cmd [[packadd cmp-buffer]]
  vim.cmd [[packadd cmp-calc]]
  vim.cmd [[packadd cmp-cmdline]]
  vim.cmd [[packadd cmp-emoji]]
  vim.cmd [[packadd cmp-nvim-lua]]
  vim.cmd [[packadd cmp-path]]
  vim.cmd [[packadd cmp-latex-symbols]]
  vim.cmd [[packadd cmp_luasnip]]

  -- Register sources
  for _, name in pairs {
    "buffer",
    "calc",
    "cmdline",
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
      ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
      ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping {
        i = cmp.mapping.confirm { behavior = cmp.SelectBehavior.Replace, select = true },
        c = cmp.mapping.confirm { select = false },
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
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        -- Taken from https://github.com/lukas-reineke/cmp-under-comparator
        function(entry1, entry2)
          local _, entry1_under = entry1.completion_item.label:find "^_+"
          local _, entry2_under = entry2.completion_item.label:find "^_+"
          entry1_under = entry1_under or 0
          entry2_under = entry2_under or 0
          if entry1_under > entry2_under then
            return false
          elseif entry1_under < entry2_under then
            return true
          end
        end,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
  }

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline("/", {
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end

return M
