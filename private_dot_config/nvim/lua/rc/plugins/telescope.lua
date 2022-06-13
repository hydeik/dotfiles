-- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
--
-- Find, Filter, Preview, Pick. All lua, all the time.
--
return {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  module = { "telescope" },
  requires = {
    -- Telescope's extensions
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "kyazdani42/nvim-web-devicons" },
    {
      "nvim-telescope/telescope-cheat.nvim",
      after = "telescope.nvim",
      config = function()
        require("telescope").load_extension("cheat")
      end,
    },
    {
      "nvim-telescope/telescope-dap.nvim",
      after = { "telescope.nvim", "nvim-dap" },
      config = function()
        require("telescope").load_extension("dap")
      end,
    },
    {
      "LinArcX/telescope-env.nvim",
      after = "telescope.nvim",
      config = function()
        require("telescope").load_extension("env")
      end,
    },
    {
      "nvim-telescope/telescope-file-browser.nvim",
      after = "telescope.nvim",
      config = function()
        require("telescope").load_extension("file_browser")
      end,
    },
    {
      "nvim-telescope/telescope-frecency.nvim",
      requires = { "sqlite.lua" },
      after = "telescope.nvim",
      config = function()
        require("telescope").load_extension("frecency")
      end,
    },
    {
      "nvim-telescope/telescope-fzf-writer.nvim",
      after = "telescope.nvim",
      config = function()
        require("telescope").load_extension("fzf_writer")
      end,
    },
    {
      "nvim-telescope/telescope-fzy-native.nvim",
      after = "telescope.nvim",
      config = function()
        require("telescope").load_extension("fzy_native")
      end,
    },
    { "nvim-telescope/telescope-hop.nvim" },
    {
      "nvim-telescope/telescope-packer.nvim",
      after = "telescope.nvim",
      config = function()
        require("telescope").load_extension("packer")
      end,
    },
    {
      "nvim-telescope/telescope-smart-history.nvim",
      requires = { "sqlite.lua" },
      after = "telescope.nvim",
      config = function()
        require("telescope").load_extension("smart_history")
      end,
    },
    {
      "nvim-telescope/telescope-symbols.nvim",
      after = "telescope.nvim",
    },
    {
      "nvim-telescope/telescope-ui-select.nvim",
      after = "telescope.nvim",
      config = function()
        require("telescope").load_extension("ui-select")
      end,
    },
  },
  setup = function()
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
    end)

    vim.keymap.set("n", "<Space>fD", function()
      require("telescope.builtin").find_files {
        find_command = find_all_cmd,
      }
    end)

    vim.keymap.set("n", "<Space>fe", function()
      local opts = {
        sorting_strategy = "ascending",
        scroll_strategy = "cycle",
      }
      require("telescope").extensions.file_browser.file_browser(opts)
    end)

    vim.keymap.set("n", "<Space>fg", function()
      require("telescope.builtin").live_grep {
        -- shorten_path = true,
        previewer = false,
        fzf_separator = "|>",
      }
    end)

    vim.keymap.set("n", "<Space>fG", function()
      require("telescope.builtin").grep_string {
        path_display = { "shorten" },
        search = vim.fn.input "Grep String > ",
      }
    end)

    -- grep last search
    vim.keymap.set("n", "<Space>f/", function()
      local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")
      local opts = { path_display = { "shorten" }, word_match = "-w", search = register }
      require("telescope.builtin").grep_string(opts)
    end)

    vim.keymap.set("n", "<Space>fo", function()
      require("telescope").extensions.frecency.frecency()
    end)

    -- Vim pickers
    vim.keymap.set("n", "<Space>fb", function()
      require("telescope.builtin").buffers {
        shorten_path = false,
        initial_mode = "normal",
      }
    end)

    vim.keymap.set("n", "<Space>fh", function()
      require("telescope.builtin").help_tags { shorten_version = true }
    end)
  end,
  config = function()
    vim.cmd [[packadd telescope-frecency.nvim]]

    local telescope = require "telescope"
    local actions = require "telescope.actions"
    local action_layout = require "telescope.actions.layout"
    local sorters = require "telescope.sorters"

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
  end,
}
