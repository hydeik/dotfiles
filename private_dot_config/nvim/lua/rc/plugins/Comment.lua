-- [Comment.nvim](https://github.com/numToStr/Comment.nvim)
--
-- Smart and powerful comment plugin for neovim.
-- Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more.
--
return {
  "numToStr/Comment.nvim",
  keys = { "gc", "gb", "gcc", "gbc" },
  requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
  config = function()
    require("Comment").setup {
      ---LHS of toggle mappings in NORMAL + VISUAL mode
      ---@type table
      toggler = {
        ---line-comment keymap
        line = "gcc",
        ---block-comment keymap
        block = "gbc",
      },

      ---LHS of operator-pending mappings in NORMAL + VISUAL mode
      ---@type table
      opleader = {
        ---line-comment keymap
        line = "gc",
        ---block-comment keymap
        block = "gb",
      },

      ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
      ---@type table
      mappings = {
        ---operator-pending mapping
        ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
        ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
        basic = true,
        ---extra mapping
        ---Includes `gco`, `gcO`, `gcA`
        extra = true,
        ---extended mapping
        ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
        extended = false,
      },
      ---Pre-hook, called before commenting the line
      ---@type function
      pre_hook = function(ctx)
        -- Only calculate commentstring for tsx filetypes
        if vim.bo.filetype == "typescriptreact" then
          local U = require "Comment.utils"

          -- Detemine whether to use linewise or blockwise commentstring
          local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"

          -- Determine the location where to calculate commentstring from
          local location = nil
          if ctx.ctype == U.ctype.block then
            location = require("ts_context_commentstring.utils").get_cursor_location()
          elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require("ts_context_commentstring.utils").get_visual_start_location()
          end

          return require("ts_context_commentstring.internal").calculate_commentstring {
            key = type,
            location = location,
          }
        end
      end,
    }
  end,
}
