local M = {}

M.committia_vim = {
  setup = function()
    vim.g.committia_min_window_width = 100
  end,
}

M.git_messenger_vim = {
  setup = function()
    vim.g.git_messenger_no_default_mappings = true
    vim.keymap.set("n", "<Space>gm", "<Plug>(git-messenger)", { silent = true })
  end,
}

M.gitlinker = {
  setup = function()
    vim.keymap.set("n", "<Space>gy", "<Cmd>lua require'gitlinker'.get_buf_range_url('n')<CR>", { silent = true })
    vim.keymap.set("v", "<Space>gy", "<Cmd>lua require'gitlinker'.get_buf_range_url('n')<CR>")
    vim.keymap.set("n", "<Space>gY", "<Cmd>lua require'gitlinker'.get_repo_url()<CR>", { silent = true })
    vim.keymap.set(
      "n",
      "<Space>gB",
      "<Cmd>lua require'gitlinker'.get_repo_url({action_callback = require'gitlinker.actions'.open_in_browser})<CR>",
      { silent = true }
    )
  end,
  config = function()
    require("gitlinker").setup {
      mappings = nil,
    }
  end,
}

M.gitsigns = {
  config = function()
    require("gitsigns").setup {
      -- signs = {
      --   add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
      --   change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
      --   delete = { hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr" },
      --   topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
      --   changedelete = { hl = "DiffChange", text = "~", numhl = "GitSignsChangeNr" },
      -- },
      numhl = true,
      word_diff = true,
    }
  end,
}

M.lazygit_nvim = {
  setup = function()
    vim.g.lazygit_floating_window_winblend = 0
    vim.g.lazygit_floating_window_scaling_factor = 0.9
    vim.g.lazygit_floating_window_corner_chars = { "╭", "╮", "╰", "╯" }
    vim.g.lazygit_use_neovim_remote = 0
    vim.keymap.set("n", "<Space>gl", "<Cmd>LazyGit<CR>", { silent = true, desc = "Launch LazyGit" })
  end,
}

return M
