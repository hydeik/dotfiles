local M = {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-cheat.nvim",
    "LinArcX/telescope-env.nvim",
    {
      "nvim-telescope/telescope-frecency.nvim",
      dependencies = { "kkharji/sqlite.lua" },
    },
    "nvim-telescope/telescope-fzf-writer.nvim",
    "nvim-telescope/telescope-fzy-native.nvim",
    "nvim-telescope/telescope-smart-history.nvim",
    "nvim-telescope/telescope-symbols.nvim",
  },
  -- key mappings
  keys = function()
    local util = require "rc.util"
    ---@param name string
    ---@param opts table?
    local map = function(name, opts)
      return function()
        require("telescope.builtin")[name](opts)
      end
    end

    return {
      { "<Space>/", map("live_grep", { cwd = util.get_root() }), desc = "Grep (root dir)" },
      { "<Space>:", map "command_history", desc = "Command History" },
      -- find
      { "<Space>fb", map "buffers", desc = "Buffers" },
      {
        "<Space>fd",
        function()
          require("rc.plugins.telescope").project_files { cwd = util.get_root() }
        end,
        desc = "Files in Project",
      },
      { "<Space>ff", map("find_files", { cwd = util.get_root() }), desc = "Find Files (root dir)" },
      { "<Space>fF", map "find_files", desc = "Find Files (cwd)" },
      {
        "<Space>fr",
        function()
          local themes = require "telescope.themes"
          require("telescope").extensions.frecency.frecency(themes.get_ivy {})
        end,
        desc = "Frecency",
      },
      -- git
      { "<Space>gb", map "git_branches", desc = "Branches" },
      { "<Space>gc", map "git_commits", desc = "Commits" },
      { "<Space>gC", map "git_commits", desc = "Buffer Commits" },
      { "<Space>gs", map "git_status", desc = "Status" },
      { "<Space>gS", map "git_stash", desc = "Stash" },
      -- search
      { "<Space>sa", map "autocommands", desc = "Auto Commands" },
      { "<Space>sc", map "command_history", desc = "Command History" },
      { "<Space>sC", map "commands", desc = "Commands" },
      { "<Space>sd", map("diagnostics", { bufnr = 0 }), desc = "Document Diagnostics" },
      { "<Space>sD", map "diagnostics", desc = "Workspace Diagnostics" },
      { "<Space>sg", map("live_grep", { cwd = util.get_root() }), desc = "Grep (root dir)" },
      { "<Space>sG", map "live_grep", desc = "Grep (cwd)" },
      { "<Space>sh", map("help_tags", { shorten_version = true }), desc = "Help Pages" },
      { "<Space>sH", map "highlights", desc = "Search Highlight Groups" },
      { "<Space>sk", map "keymaps", desc = "Key Maps" },
      { "<Space>sM", map "man_pages", desc = "Man Pages" },
      { "<Space>sm", map "marks", desc = "Jump to Mark" },
      { "<Space>so", map "vim_options", desc = "Vim Options" },
      { "<Space>sR", map "resume", desc = "Resume" },
      { "<Space>sw", map("grep_string", { cwd = util.get_root() }), desc = "Word (root dir)" },
      { "<Space>sW", map "grep_string", desc = "Word (cwd)" },
      -- lsp
      {
        "<Space>ss",
        map("lsp_document_symbol", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol",
      },
      {
        "<Space>sS",
        map("lsp_dynamic_workspace_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol (workspace)",
      },
      -- ui
      { "<Space>uC", map("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
    }
  end,
}

M.project_files = function(opts)
  -- local path = require "rc.core.path"
  local cwd = opts.cwd or vim.uv.cwd()
  local builtin = nil
  if vim.uv.fs_stat(cwd .. "/.git") then
    opts.show_untracked = true
    builtin = "git_files"
  else
    builtin = "find_files"
  end
  require("telescope.builtin")[builtin](opts)
end

---@class UserTelescopeOptions
M.opts = function()
  local actions = require "telescope.actions"
  local action_layout = require "telescope.actions.layout"
  local sorters = require "telescope.sorters"
  local trouble = require "trouble.providers.telescope"

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
  local vimgrep_args = {
    unpack(require("telescope.config").values.vimgrep_arguments),
  }
  table.insert(vimgrep_args, "--no-ignore-vcs")
  for _, x in ipairs(ignore_globs) do
    table.insert(vimgrep_args, "--glob=!" .. x)
  end

  local find_args = nil
  if vim.fn.executable "fd" == 1 then
    find_args = { "fd", ".", "--type", "f" }
    for _, x in ipairs(ignore_globs) do
      table.insert(find_args, "--exclude")
      table.insert(find_args, x)
    end
  elseif vim.fn.executable "rg" == 1 then
    find_args = vimgrep_args
  else
    vimgrep_args = nil
  end

  return {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",

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
      vimgrep_arguments = vimgrep_args,

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
    pickers = {
      buffers = {
        shorten_path = false,
        initial_mode = "normal",
        sort_lastused = true,
        sort_mru = true,
        mappings = {
          i = {
            ["dd"] = actions.delete_buffer,
          },
        },
      },
      find_files = {
        follow = true,
        hidden = true,
        find_command = find_args,
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
end
---@param opts UserTelescopeOptions
M.config = function(_, opts)
  local telescope = require "telescope"
  telescope.setup(opts)
  telescope.load_extension "cheat"
  telescope.load_extension "env"
  telescope.load_extension "frecency"
  telescope.load_extension "fzf_writer"
  telescope.load_extension "fzy_native"
  telescope.load_extension "smart_history"
end

return M
