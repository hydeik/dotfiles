return {
  -- Faster LuaLS setup for Neovim
  "folke/lazydev.nvim",
  ft = "lua",
  cmd = "LazyDev",
  opts = {
    library = {
      "lazy.nvim",
      -- Only load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      -- Only load the lazyvim library when the `LazyVim` global is found
      { path = "LazyVim", words = { "LazyVim" } },
      -- Load the wezterm types when the `wezterm` module is required
      { path = "snacks.nvim", words = { "Snacks" } },
      -- -- Load the wezterm types when the `wezterm` module is required
      -- -- Needs `justinsgithub/wezterm-types` to be installed
      -- { path = "wezterm-types", mods = { "wezterm" } },
    },
  },
}
