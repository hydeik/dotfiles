-- lua_add {{{
local ddu = require "rc.plugins.ddu"

vim.keymap.set("n", "<Space>fb", function()
  ddu.start {
    name = "buffer",
    sources = { "buffer" },
  }
end, { desc = "Buffers" })

vim.keymap.set("n", "<Space>fd", function()
  local path = require("rc.utils").get_root()
  ddu.start {
    name = "files",
    sources = {
      { name = "file_fd", options = { path = path } },
    },
  }
end, { desc = "Files (fd)" })

vim.keymap.set("n", "<Space>fe", function()
  ddu.start {
    name = "files",
    sources = { "file" },
    ui = "filer",
    resume = true,
    sync = true,
  }
end, { desc = "File explore" })

-- Git
vim.keymap.set("n", "<Space>gb", function()
  local path = vim.uv.cwd()
  ddu.start {
    name = "git_branch",
    sources = {
      { name = "git_branch", options = { path = path } },
    },
    -- params = { remote = true },
  }
end, { desc = "Branches" })

vim.keymap.set("n", "<Space>gl", function()
  ddu.start {
    name = "git_log",
    resume = true,
    sources = { "git_log" },
  }
end, { desc = "Log" })

vim.keymap.set("n", "<Space>gs", function()
  ddu.start {
    name = "git_status",
    resume = true,
    sources = { "git_status" },
  }
end, { desc = "Status" })

vim.keymap.set("n", "<Space>gS", function()
  ddu.start {
    name = "git_stash",
    resume = true,
    sources = { "git_stash" },
  }
end, { desc = "Stash" })

-- Search
vim.keymap.set("n", "/", function()
  ddu.start {
    name = "search",
    sources = { "line" },
    resume = false,
    input = vim.fn.escape(vim.fn.input "Pattern: ", " "),
  }
end, { desc = "Search Pattern" })

vim.keymap.set("n", "*", function()
  ddu.start {
    name = "search",
    sources = { "line" },
    resume = false,
    input = vim.fn.input(vim.fn.expand "<cword>"),
  }
end, { desc = "Search <cword>" })

vim.keymap.set("n", "n", function()
  ddu.start {
    name = "search",
    resume = true,
  }
end, { desc = "Search resume" })

vim.keymap.set("n", "<Space>sg", function()
  ddu.start {
    name = "search",
    sources = {
      {
        name = "rg",
        params = {
          input = vim.fn.input("Pattern: ", vim.fn.expand "<cword>"),
        },
      },
    },
    resume = false,
    uiParams = {
      ff = { ignoreEmpty = true },
    },
  }
end, { desc = "Grep" })

vim.keymap.set("n", "<Space>sG", function()
  ddu.start {
    name = "search",
    sources = {
      {
        name = "rg",
        params = {
          input = vim.fn.input("Pattern: ", vim.fn.expand "<cword>"),
        },
        optios = {
          path = vim.fn.input("Directory: ", vim.uv.cwd(), "dir"),
        },
      },
    },
    resume = false,
    uiParams = {
      ff = { ignoreEmpty = true },
    },
  }
end, { desc = "Grep" })

-- Vim Help
vim.keymap.set("n", "<Space>sh", function()
  ddu.start {
    name = "help",
    sources = { "help" },
  }
end, { desc = "Help Pages" })

-- register
vim.keymap.set("n", "<Leader>r", function()
  ddu.start {
    name = "register",
    sources = {
      {
        name = "register",
        options = { defaultAction = vim.fn.col "." == 1 and "insert" or "append" },
      },
    },
  }
end, { desc = "Register" })

vim.keymap.set("x", "<Leader>r", function()
  if vim.api.nvim_get_mode()["mode"] == "V" then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes([["_R<ESC>]], true, true, true), "n", false)
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes([["_d]], true, true, true), "n", false)
  end
  vim.schedule(function()
    -- Ensure ddu#start is called after `feedkeys()`
    ddu.start {
      name = "register",
      sources = {
        {
          name = "register",
          options = { defaultAction = "insert" },
        },
      },
    }
  end)
end, { desc = "Register" })

-- }}}

-- lua_source {{{
-- require("rc.plugins.ddu").custom.load_config(vim.fs.joinpath(vim.env.DPP_CONFIG_DIR, "ddu.ts"))
local ddu_ = require "rc.plugins.ddu"
ddu_.custom.load_config(vim.fs.joinpath(vim.env.DPP_HOOKS_DIR, "ddu", "main.ts"))
ddu_.custom.load_config(vim.fs.joinpath(vim.env.DPP_HOOKS_DIR, "ddu", "ff.ts"))
ddu_.custom.load_config(vim.fs.joinpath(vim.env.DPP_HOOKS_DIR, "ddu", "filer.ts"))
-- }}}

-- lua_post_update {{{
require("rc.plugins.ddu").set_static_import()
-- }}}
