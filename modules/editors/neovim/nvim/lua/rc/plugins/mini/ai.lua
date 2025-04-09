return {
  -- Neovim Lua plugin to extend and create `a`/`i` textobjects.
  -- Part of 'mini.nvim' library.
  "echasnovski/mini.ai",
  lazy = true,
  event = "VeryLazy",
  opts = function()
    local ai = require "mini.ai"
    return {
      custom_textobjects = {
        o = ai.gen_spec.treesitter({ -- code block
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }, {}),
        f = ai.gen_spec.treesitter { a = "@function.outer", i = "@function.inner" }, -- function
        c = ai.gen_spec.treesitter { a = "@class.outer", i = "@class.inner" }, -- class
        t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
        d = { "%f[%d]%d+" }, -- digits
        e = { -- Word with case
          { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
          "^().*()$",
        },
        g = function(ai_type) -- whole buffer
          local start_line = 1
          local end_line = vim.fn.line "$"
          if ai_type == "i" then
            -- Skip first and last blank lines for `i` textobject
            local first_nonblank = vim.fn.nextnonblank(start_line)
            local last_nonblank = vim.fn.prevnonblank(end_line)
            -- Do nothing for buffer with all blanks
            if first_nonblank == 0 or last_nonblank == 0 then
              return { from = { line = start_line, col = 1 } }
            end
            start_line, end_line = first_nonblank, last_nonblank
          end

          local to_col = math.max(vim.fn.getline(end_line):len(), 1)
          return {
            from = { line = start_line, col = 1 },
            to = { line = end_line, col = to_col },
          }
        end,
        u = ai.gen_spec.function_call(), -- u for "Usage"
        U = ai.gen_spec.function_call { name_pattern = "[%w_]" }, -- without dot in function name
      },
      -- Number of lines within which textobject is searched
      n_lines = 500,
    }
  end,
  config = function(_, opts)
    require("mini.ai").setup(opts)

    -- register keymaps to which-key
    require("rc.utils.lazy").on_load("which-key.nvim", function()
      vim.schedule(function()
        -- register all text objects with which-key
        local objects = {
          { " ", desc = "whitespace" },
          { '"', desc = '" string' },
          { "'", desc = "' string" },
          { "(", desc = "() block" },
          { ")", desc = "() block with ws" },
          { "<", desc = "<> block" },
          { ">", desc = "<> block with ws" },
          { "?", desc = "user prompt" },
          { "U", desc = "use/call without dot" },
          { "[", desc = "[] block" },
          { "]", desc = "[] block with ws" },
          { "_", desc = "underscore" },
          { "`", desc = "` string" },
          { "a", desc = "argument" },
          { "b", desc = ")]} block" },
          { "c", desc = "class" },
          { "d", desc = "digit(s)" },
          { "e", desc = "CamelCase / snake_case" },
          { "f", desc = "function" },
          { "g", desc = "entire file" },
          { "o", desc = "block, conditional, loop" },
          { "q", desc = "quote `\"'" },
          { "t", desc = "tag" },
          { "u", desc = "use/call" },
          { "{", desc = "{} block" },
          { "}", desc = "{} with ws" },
        }

        local ret = { mode = { "o", "x" } }

        local mappings = vim.tbl_extend("force", {}, {
          -- Main textobject prefixes
          around = "a",
          inside = "i",
          -- Next/last variants
          around_next = "an",
          inside_next = "in",
          around_last = "al",
          inside_last = "il",
        }, opts.mappings or {})
        -- Move cursor to corresponding edge of `a` textobject
        mappings.goto_left = nil
        mappings.goto_right = nil

        for name, prefix in pairs(mappings) do
          name = name:gsub("^around_", ""):gsub("^inside_", "")
          ret[#ret + 1] = { prefix, group = name }
          for _, obj in ipairs(objects) do
            local desc = obj.desc
            if prefix:sub(1, 1) == "i" then
              desc = desc:gsub(" with ws", "")
            end
            ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
          end
        end
        require("which-key").add(ret, { notify = false })
      end)
    end)
  end,
}
