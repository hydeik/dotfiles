local M = {}

-- [[ Custom Pickers ]]

function M.edit_nvim_config()
  require("telescope.builtin").find_files {
    find_command = M._find_command,
    prompt_title = "~ dotfiles ~",
    shorten_path = false,
    cwd = "~/.config/nvim",

    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65 },
  }
end

function M.edit_zsh_config()
  require("telescope.builtin").find_files {
    find_command = M._find_command,
    prompt_title = "~ dotfiles ~",
    shorten_path = false,
    cwd = "~/.config/zsh",

    file_ignore_patterns = { ".zcompdump", ".zcompcache", ".*.zwc" },
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.55 },
  }
end

function M.fd()
  require("telescope.builtin").find_files { find_command = M._find_command }
end

function M.fd_all()
  require("telescope.builtin").find_files { find_command = M._find_all_command }
end

function M.git_files()
  local opts = require("telescope.themes").get_dropdown {
    previewer = false,
    shorten_path = false,
  }
  require("telescope.builtin").git_files(opts)
end

function M.grep_prompt()
  require("telescope.builtin").grep_string {
    path_display = { "shorten" },
    search = vim.fn.input "Grep String > ",
  }
end

function M.grep_last_search()
  local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")
  local opts = { path_display = { "shorten" }, word_match = "-w", search = register }
  require("telescope.builtin").grep_string(opts)
end

function M.live_grep()
  require("telescope").extensions.fzf_writer.staged_grep {
    path_display = { "shorten" },
    previewer = false,
  }
end

function M.file_browser()
  local opts = {
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
  }
  require("telescope").extensions.file_browser.file_browser(opts)
end

function M.buffers()
  require("telescope.builtin").buffers {
    shorten_path = false,
    -- TODO: uncomment next line when
    -- https://github.com/nvim-telescope/telescope.nvim/issues/750
    -- is fixed
    -- initial_mode = "normal",
  }
end

function M.current_buffer_fuzzy_find()
  local opts = require("telescope.themes").get_dropdown {
    border = true,
    previewer = false,
    shorten_path = false,
  }
  require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

function M.oldfiles()
  require("telescope").extensions.frecency.frecency()
end

function M.help_tags()
  require("telescope.builtin").help_tags { show_version = true }
end

M.pickers = setmetatable({}, {
  __index = function(_, k)
    if M[k] then
      return M[k]
    else
      return require("telescope.builtin")[k]
    end
  end,
})

-- setup: called befor loading telescope.nvim
function M.setup()
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

  M._find_command = find_cmd
  M._find_all_command = find_all_cmd

  -- mappings
  local set_keymap = function(key, f, options, buffer)
    local mode = "n"
    local rhs = string.format(
      "<cmd>lua require('rc.config.telescope').pickers['%s'](%s)<CR>",
      f,
      options and vim.inspect(options, { newline = "" }) or ""
    )
    local map_opts = { noremap = true, silent = true }
    if buffer then
      vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_opts)
    else
      vim.api.nvim_set_keymap(mode, key, rhs, map_opts)
    end
  end

  local map_extension = function(key, e, f, options)
    local mode = "n"
    local rhs = string.format(
      "<cmd>lua require('telescope').extensions['%s']['%s'](%s)<CR>",
      e,
      f,
      options and vim.inspect(options, { newline = "" }) or ""
    )
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, key, rhs, opts)
  end

  -- Call telescope on command line mode
  vim.api.nvim_set_keymap("c", "<C-r><C-r>", "<Plug>(TelescopeFuzzyCommandSearch)", { noremap = true, nowait = true })

  -- File pickers
  set_keymap("<Space>en", "edit_nvim_config")
  set_keymap("<Space>ez", "edit_zsh_config")

  set_keymap("<Space>fd", "fd")
  set_keymap("<Space>fD", "fd_all")
  set_keymap("<Space>fe", "file_browser")
  set_keymap("<Space>fg", "live_grep")
  set_keymap("<Space>fG", "grep_prompt")
  set_keymap("<Space>fo", "oldfiles")
  set_keymap("<Space>f/", "grep_last_search")

  -- Vim pickers
  set_keymap("<Space>fb", "buffers")
  set_keymap("<Space>fh", "help_tags")
  set_keymap("<Space>ff", "current_buffer_fuzzy_find")

  -- LSP pickers
  set_keymap("<Space>la", "lsp_code_actions")
  set_keymap("<Space>ld", "lsp_definitions")
  set_keymap("<Space>lr", "lsp_references")
  set_keymap("<Space>ls", "lsp_documen_symbols")
  set_keymap("<Space>lS", "lsp_workspace_symbols")
  set_keymap("<Space>le", "lsp_document_diagnostics")
  set_keymap("<Space>lE", "lsp_workspace_diagnostics")
  -- Treesitter
  set_keymap("<Space>lt", "treesitter")

  -- Git pickers
  set_keymap("<Space>gf", "git_files")
  set_keymap("<Space>gb", "git_branches", { initial_mode = "normal" })
  set_keymap("<Space>gc", "git_bcommits", { initial_mode = "normal" })
  set_keymap("<Space>gC", "git_commits", { initial_mode = "normal" })
  set_keymap("<Space>gs", "git_status", { initial_mode = "normal" })
  set_keymap("<Space>gS", "git_stash", { initial_mode = "normal" })

  -- nvim-dap inl_defaultctegration
  map_extension("<Space>dc", "dap", "commands")
  map_extension("<Space>dC", "dap", "configurations")
  map_extension("<Space>dl", "dap", "list_breakpoints")
  map_extension("<Space>dv", "dap", "variables;")
end

-- config: called after telescope.nvim is loaded
function M.config()
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

  -- pcall(telescope.load_extension, "dap")
  -- pcall(telescope.load_extension, "file_browser")
  -- pcall(telescope.load_extension, "freceny")
  -- pcall(telescope.load_extension, "fzy_native")
  -- pcall(telescope.load_extension, "gh")
  -- pcall(telescope.load_extension, "hop")
  -- pcall(telescope.load_extension, "smart_history")
  -- pcall(telescope.load_extension, "ui-select")
end

return M
