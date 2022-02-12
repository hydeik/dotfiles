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

  -- Icons & menu
  local cmp_kinds = require("rc.config.lsp.kind").icons
  local cmp_menu = {
    buffer = "[Buffer]",
    calc = "[Calc]",
    emoji = "[Emoji]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[Lua]",
    path = "[PATH]",
    latex_symbols = "[Latex]",
    luasnip = "[LuaSnip]",
  }

  -- utility functions

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
  end

  -- Configurations
  local cmp = require "cmp"
  local luasnip = require "luasnip"
  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
      ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ["<CR>"] = cmp.mapping {
        i = cmp.mapping.confirm { behavior = cmp.SelectBehavior.Replace, select = true },
        c = cmp.mapping.confirm { select = false },
      },
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    formatting = {
      format = function(entry, vim_item)
        -- Kind icons
        vim_item.kind = cmp_kinds[vim_item.kind]
        -- Source
        vim_item.menu = cmp_menu[entry.source.name]
        return vim_item
      end,
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
