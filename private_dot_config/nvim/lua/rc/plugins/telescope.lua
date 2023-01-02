local M = {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-cheat.nvim",
    "LinArcX/telescope-env.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    {
      "nvim-telescope/telescope-frecency.nvim",
      dependencies = { "kkharji/sqlite.lua" },
    },
    "nvim-telescope/telescope-fzf-writer.nvim",
    "nvim-telescope/telescope-fzy-native.nvim",
    "nvim-telescope/telescope-smart-history.nvim",
    "nvim-telescope/telescope-symbols.nvim",
  },
}

M.init = function()
  -- find command
  local ignore_globs = {
    ".git",
    ".ropeproject",
    "__pycache__",
    ".venv",
    "venv",
    "node_modules",
    "images",
    "*.min.*",
    "img",
    -- "fonts",
  }
  local find_cmd, find_all_cmd
  if vim.fn.executable "fd" then
    find_cmd = { "fd", ".", "--hidden", "--follow", "--type", "f" }
    find_all_cmd = vim.deepcopy(find_cmd)
    table.insert(find_all_cmd, "--no-ignore")
    for _, x in ipairs(ignore_globs) do
      table.insert(find_cmd, "--exclude")
      table.insert(find_cmd, x)
    end
  elseif vim.fn.executable "rg" then
    find_cmd = { "rg", "--follow", "--hidden", "--files" }
    find_all_cmd = vim.deepcopy(find_cmd)
    table.insert(find_all_cmd, "--no-ignore")
    for _, x in ipairs(ignore_globs) do
      table.insert(find_cmd, "--glob=!" .. x)
    end
  end

  -- Key bindings
  -- (File pickers)
  vim.keymap.set("n", "<Space>fd", function()
    require("telescope.builtin").find_files {
      find_command = find_cmd,
    }
  end, { silent = true, desc = "Find files" })

  vim.keymap.set("n", "<Space>fD", function()
    require("telescope.builtin").find_files {
      find_command = find_all_cmd,
    }
  end, { silent = true, desc = "Find all files" })

  vim.keymap.set("n", "<Space>fe", function()
    local opts = {
      sorting_strategy = "ascending",
      scroll_strategy = "cycle",
    }
    require("telescope").extensions.file_browser.file_browser(opts)
  end, { silent = true, desc = "File browser" })

  vim.keymap.set("n", "<Space>fg", function()
    require("telescope.builtin").live_grep {
      -- shorten_path = true,
      previewer = false,
      fzf_separator = "|>",
    }
  end, { silent = true, desc = "Live grep" })

  vim.keymap.set("n", "<Space>fG", function()
    require("telescope.builtin").grep_string {
      path_display = { "shorten" },
      search = vim.fn.input "Grep String > ",
    }
  end, { silent = true, desc = "Grep string" })

  -- grep last search
  vim.keymap.set("n", "<Space>f/", function()
    local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")
    local opts = { path_display = { "shorten" }, word_match = "-w", search = register }
    require("telescope.builtin").grep_string(opts)
  end, { silent = true, desc = "Grep last search" })

  vim.keymap.set("n", "<Space>fo", function()
    require("telescope").extensions.frecency.frecency()
  end)

  -- Vim pickers
  vim.keymap.set("n", "<Space>fb", function()
    require("telescope.builtin").buffers {
      shorten_path = false,
      initial_mode = "normal",
    }
  end, { silent = true, desc = "Buffers" })

  vim.keymap.set("n", "<Space>fh", function()
    require("telescope.builtin").help_tags { shorten_version = true }
  end, { silent = true, desc = "Help tags" })
end

M.config = function()
  local telescope = require "telescope"
  local actions = require "telescope.actions"
  local action_layout = require "telescope.actions.layout"
  local sorters = require "telescope.sorters"
  local trouble = require "trouble.providers.telescope"

  telescope.setup {
    defaults = {
      prompt_prefix = "❯ ",
      selection_caret = "❯ ",

      layout_strategy = "flex",
      layout_config = {
        prompt_position = "bottom",
        preview_cutoff = 100,

        width = 0.90,
        height = 0.85,

        horizontal = {
          preview_width = function(_, cols, _)
            if cols > 200 then
              return math.floor(cols * 0.4)
            else
              return math.floor(cols * 0.6)
            end
          end,
        },
        vertical = { width = 0.9, height = 0.9, preview_width = 0.5 },
        flex = { horizontal = { preview_width = 0.9 } },
      },

      scroll_strategy = "cycle",
      color_devicons = true,

      file_sorter = sorters.get_fzy_sorter,

      mappings = {
        -- insert mode
        i = {
          ["<Tab>"] = actions.toggle_selection,
          ["<C-_>"] = actions.which_key,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
          ["<M-p>"] = action_layout.toggle_preview,
          ["<C-t>"] = trouble.open_with_trouble,
        },
        -- normal mode
        n = {
          ["q"] = actions.close,
          ["<Space>"] = actions.toggle_selection,
          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
          ["<M-p>"] = action_layout.toggle_preview,
          ["<C-t>"] = trouble.open_with_trouble,
        },
      },

      cache_picker = {
        num_pickers = 20,
      },
    },

    extensions = {
      file_browser = {},
      frecency = {
        ignore_patterns = { "*.git/*", "*/tmp/*", "*/build/*" },
        show_scores = true,
        show_unindexed = true,
        workspaces = {
          ["conf"] = vim.env.XDG_CONFIG_HOME,
          ["data"] = vim.env.XDG_DATA_HOME,
        },
      },

      fzf_writer = {
        minimum_grep_characters = 3,
        minimum_files_characters = 3,
        use_highlighter = false,
      },

      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    },
  }

  telescope.load_extension "cheat"
  telescope.load_extension "env"
  telescope.load_extension "file_browser"
  telescope.load_extension "frecency"
  telescope.load_extension "fzf_writer"
  telescope.load_extension "fzy_native"
  telescope.load_extension "smart_history"
end

return M
