return {
  -- Nvim Treesitter configurations and abstraction layer
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    cmd = { "TSInstall", "TSInstallFromGrammar", "TSUpdate", "TSUninstall" },
    branch = "main",
    build = ":TSUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      -- one of 'all', 'language', or a list of languages
      ensure_installed = {
        "asm",
        "bash",
        "c",
        "css",
        "csv",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "just",
        "lua",
        "luadoc",
        "luap",
        "make",
        "markdown",
        "markdown_inline",
        "printf",
        "query",
        "regex",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
    },
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        -- remove duplicate entries
        opts.ensure_installed = require("rc.utils").list_unique(opts.ensure_installed)
      end

      -- auto install
      require("nvim-treesitter").install(opts.ensure_installed)

      -- highlights
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true }),
        callback = function(args)
          local buf = args.buf
          local filetype = args.match

          -- you need some mechanism to avoid running on buffers that do not
          -- correspond to a language (like oil.nvim buffers), this implementation
          -- checks if a parser exists for the current language
          local language = vim.treesitter.language.get_lang(filetype) or filetype
          if not vim.treesitter.language.add(language) then
            return
          end

          -- fold
          vim.opt.foldmethod = "expr"
          vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

          -- highlights
          vim.treesitter.start(buf, language)

          -- indent
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      -- Code folding with treesitter
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    keys = {
      -- swap
      {
        "<Leader>a",
        function()
          require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
        end,
        desc = "Swap the argument with the next one",
      },
      {
        "<Leader>A",
        function()
          require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.outer"
        end,
        desc = "Swap the argument with the previous one",
      },
      -- move
      {
        "]f",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
        end,
        mode = { "n", "x", "o" },
        desc = "Next function start",
      },
      {
        "]c",
        function()
          if vim.wo.diff then
            vim.cmd "normal! ]c"
          else
            require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
          end
        end,
        mode = { "n", "x", "o" },
        desc = "Next class start",
      },
      {
        "]a",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.inner", "textobjects")
        end,
        mode = { "n", "x", "o" },
        desc = "Next parameter start",
      },
      {
        "]s",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
        end,
        mode = { "n", "x", "o" },
        desc = "Next scope",
      },
      {
        "]z",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
        end,
        mode = { "n", "x", "o" },
        desc = "Next fold",
      },
      {
        "]F",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
        end,
        mode = { "n", "x", "o" },
        desc = "Next function end",
      },
      {
        "]C",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
        end,
        mode = { "n", "x", "o" },
        desc = "Next class end",
      },
      {
        "]A",
        function()
          require("nvim-treesitter-textobjects.move").goto_next_end("@parameter.inner", "textobjects")
        end,
        mode = { "n", "x", "o" },
        desc = "Next parameter end",
      },
      {
        "[f",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
        end,
        mode = { "n", "x", "o" },
        desc = "Previous function start",
      },
      {
        "[c",
        function()
          if vim.wo.diff then
            vim.cmd "normal! [c"
          else
            require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
          end
        end,
        mode = { "n", "x", "o" },
        desc = "Previous class start",
      },
      {
        "[a",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.inner", "textobjects")
        end,
        mode = { "n", "x", "o" },
        desc = "Previous parameter start",
      },
      {
        "[s",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start("@local.scope", "locals")
        end,
        mode = { "n", "x", "o" },
        desc = "Previous scope",
      },
      {
        "[z",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_start("@fold", "folds")
        end,
        mode = { "n", "x", "o" },
        desc = "Previous fold",
      },
      {
        "[F",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
        end,
        mode = { "n", "x", "o" },
        desc = "Previous function end",
      },
      {
        "[C",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
        end,
        mode = { "n", "x", "o" },
        desc = "Previous class end",
      },
      {
        "[A",
        function()
          require("nvim-treesitter-textobjects.move").goto_previous_end("@parameter.inner", "textobjects")
        end,
        mode = { "n", "x", "o" },
        desc = "Previous parameter end",
      },
    },
  },
}
