if vim.loader then
  vim.loader.enable()
end

-- Environment variables
vim.env.VIM_CONFIG_DIR = vim.fn.stdpath "config" --[[@as string]]
vim.env.VIM_DATA_DIR = vim.fn.stdpath "data" --[[@as string]]
vim.env.VIM_CACHE_DIR = vim.fn.stdpath "cache" --[[@as string]]
vim.env.DPP_HOOKS_DIR = vim.fs.joinpath(vim.env.VIM_CONFIG_DIR, "dpp", "hooks")

-- Load settings & plugins
require "rc.dpp"
