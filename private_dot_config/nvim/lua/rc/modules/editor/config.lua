local M = {}

M.comment_nvim = {
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
  end
}

M.vim_niceblock = {
  setup = function()
    vim.g.niceblock_no_default_key_mappings = 1
    vim.keymap.set("v", "I", "<Plug>(niceblock-I)")
    vim.keymap.set("v", "gI", "<Plug>(niceblock-gI)")
    vim.keymap.set("v", "A", "<Plug>(niceblock-A)")
  end,
}

M.vim_easy_align = {
  setup = function()
    vim.keymap.set({ "n", "v" }, "<Leader>a", "<Plug>(EasyAlign)", { silent = true })
  end,
  config = function()
    -- extending alignment rules
    vim.g.easy_align_delimiters = {
      [">"] = {
        pattern = [[>>\|=>\|>]],
      },
      ["/"] = {
        pattern = [[//\+\|/\*\|\*/]],
        ignore_groups = { "String" },
      },
      ["#"] = {
        pattern = [[#\+]],
        ignore_groups = { "String" },
        delimiter_align = "l",
      },
      ["]"] = {
        pattern = [=[[[\]]]=],
        left_margin = 0,
        right_margin = 0,
        stick_to_left = 0,
      },
      [")"] = {
        pattern = "[()]",
        left_margin = 0,
        right_margin = 0,
        stick_to_left = 0,
      },
      ["d"] = {
        pattern = [[ \(\S\+\s*[;=]\)\@=]],
        left_margin = 0,
        right_margin = 0,
      },
    }
  end
}

M.vim_operator_convert_case = {
  setup = function()
    vim.keymap.set("n", "~", "<Plug>(operator-convert-case-loop)")
    vim.keymap.set("x", "~", "<Plug>(operator-convert-case-loop)gv")
  end
}

M.vim_sandwich = {
  setup = function()
    vim.g.sandwich_no_default_key_mappings = 1
    vim.g.operator_sandwich_no_default_key_mappings = 1
    vim.g.textobj_sandwich_no_default_key_mappings = 1

    -- Key mappings
    -- add
    vim.keymap.set({ "n", "x", "o" }, "sa", "<Plug>(sandwich-add)", { silent = true })
    -- delete
    vim.keymap.set({ "n", "x" }, "sd", "<Plug>(sandwich-delete)")
    vim.keymap.set("n", "sdb", "<Plug>(sandwich-delete-auto)")
    -- replace
    vim.keymap.set({ "n", "x" }, "sr", "<Plug>(sandwich-replace)")
    vim.keymap.set("n", "srb", "<Plug>(sandwich-replace-auto)")
    -- textobj auto
    vim.keymap.set({ "o", "x" }, "ab", "<Plug>(textobj-sandwich-auto-a)")
    vim.keymap.set({ "o", "x" }, "ib", "<Plug>(textobj-sandwich-auto-i)")
    -- textobj query
    vim.keymap.set({ "o", "x" }, "as", "<Plug>(textobj-sandwich-query-a)")
    vim.keymap.set({ "o", "x" }, "is", "<Plug>(textobj-sandwich-query-i)")
  end,
  config = function()
    vim.g["textobj#sandwich#stimeoutlen"] = 100
    vim.api.nvim_exec(
      [=[
      let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
      let g:sandwich#recipes += [{'buns': ['「', '」']}, {'buns': ['【', '】']}]
      let g:sandwich#recipes += [{'buns': ['（', '）']}, {'buns': ['『', '』']}]
      let g:sandwich#recipes += [{'buns': ['\(',  '\)'], 'filetype': ['vim'], 'nesting': 1}]
      let g:sandwich#recipes += [{'buns': ['\%(', '\)'], 'filetype': ['vim'], 'nesting': 1}]
    ]=],
      false
    )
  end,
}

return M
