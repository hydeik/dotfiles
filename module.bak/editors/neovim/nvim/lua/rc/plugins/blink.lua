return {
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    enabled = false,
  },
  -- add blink.compat
  {
    "saghen/blink.compat",
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = "*",
    -- make optional so it's only enabled if any extras need it
    optinal = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },

  {
    -- Performant, batteries-included completion plugin for Neovim.
    "saghen/blink.cmp",
    -- use a release tag to download pre-built binaries
    version = "*",
    -- AND/OR build from source, requires nightly:
    -- https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    dependencies = {
      "moyiz/blink-emoji.nvim",
      "MahanRahmati/blink-nerdfont.nvim",
      "mikavilpas/blink-ripgrep.nvim",
      "bydlw98/blink-cmp-env",
    },

    event = "InsertEnter",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = {
        expand = function(snippet)
          return require("rc.utils.cmp").snippet_expand(snippet)
        end,
      },
      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = false,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
        kind_icons = require("rc.core.config").icons.kinds,
      },
      completion = {
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = true,
        },
      },

      sources = {
        -- adding any nvim-cmp sources here will enable them with blink.compat
        compat = {},
        -- `lsp`, `buffer`, `snippets`, `path` and `omni` are built-in
        -- so you don't need to define them in `sources.providers`
        default = { "lsp", "path", "snippets", "buffer", "ripgrep", "emoji", "nerd_font" },
        providers = {
          emoji = {
            name = "Emoji",
            module = "blink-emoji",
            score_offset = 15,
            opts = {
              -- Insert nerdfont icon (default) or complete its name
              insert = true,
            },
          },
          env = {
            name = "Env",
            module = "blink-cmp-env",
          },
          nerd_font = {
            name = "Nert Fonts",
            module = "blink-nerdfont",
            score_offset = 15,
            opts = {
              -- Insert nerdfont icon (default) or complete its name
              insert = true,
            },
          },
          ripgrep = {
            name = "Ripgrep",
            module = "blink-ripgrep",
          },
        },
      },

      cmdline = {
        enabled = true,
        keymap = {
          ["<Tab>"] = { "show", "accept" },
        },
        completion = {
          menu = { auto_show = true },
        },
      },

      keymap = {
        -- Define custom keymappings that mimics nvim-cmp like behaviors
        preset = "none",

        ["<C-e>"] = { "cancel", "hide", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },

        ["<C-n>"] = { "select_next", "fallback_to_mappings" },
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<Up>"] = {
          function(cmp)
            return cmp.select_prev { auto_insert = false }
          end,
          "fallback",
        },
        ["<Down>"] = {
          function(cmp)
            return cmp.select_next { auto_insert = false }
          end,
          "fallback",
        },

        ["<C-g>"] = {
          function()
            require("blink-cmp").show { providers = { "ripgrep" } }
          end,
        },

        ["<C-y>"] = { "select_and_accept" },

        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<CR>"] = { "select_and_accept", "fallback" },
        ["<Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_next()
            end
          end,
          require("rc.utils.cmp").map { "snippet_forward", "ai_accept" },
          function(cmp)
            if require("rc.utils.cmp").has_words_before() then
              return cmp.accept()
            end
          end,
          "fallback",
        },
        ["<S-Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_prev()
            end
          end,
          "snippet_backward",
          "fallback",
        },
      },
    },
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
      "sources.default",
    },
    ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
    config = function(_, opts)
      -- setup compat sources
      local enabled = opts.sources.default
      for _, source in ipairs(opts.sources.compat or {}) do
        opts.sources.providers[source] = vim.tbl_deep_extend(
          "force",
          { name = source, module = "blink.compat.source" },
          opts.sources.providers[source] or {}
        )
        if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
          table.insert(enabled, source)
        end
      end

      -- Unset custom prop to pass blink.cmp validation
      opts.sources.compat = nil

      -- check if we need to override symbol kinds
      for _, provider in pairs(opts.sources.providers or {}) do
        ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
        if provider.kind then
          local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
          local kind_idx = #CompletionItemKind + 1

          CompletionItemKind[kind_idx] = provider.kind
          ---@diagnostic disable-next-line: no-unknown
          CompletionItemKind[provider.kind] = kind_idx

          ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
          local transform_items = provider.transform_items
          ---@param ctx blink.cmp.Context
          ---@param items blink.cmp.CompletionItem[]
          provider.transform_items = function(ctx, items)
            items = transform_items and transform_items(ctx, items) or items
            for _, item in ipairs(items) do
              item.kind = kind_idx or item.kind
              item.kind_icon = require("rc.core.config").icons.kinds[item.kind_name] or item.kind_icon or nil
            end
            return items
          end

          -- Unset custom prop to pass blink.cmp validation
          provider.kind = nil
        end
      end

      require("blink.cmp").setup(opts)
    end,
  },
  -- Additional sources
  -- lazydev
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        -- add lazydev to the provider
        default = { "lazydev" },
        providers = {
          lazydev = {
            name = "lazydev",
            module = "lazydev.integrations.blink",
            score_offset = 100, -- show at higher priority than LSP
          },
        },
      },
    },
  },
  -- catppuccin squpport
  {
    "catppuccin",
    optional = true,
    opts = {
      integrations = { blink_cmp = true },
    },
  },
}
