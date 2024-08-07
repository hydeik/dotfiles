local dpp_base_dir = vim.fs.joinpath(vim.env.VIM_DATA_DIR, "dpp")
local dpp_config_dir = vim.fs.joinpath(vim.env.VIM_CONFIG_DIR, "dpp")

local ensure_plugin = function(username, repo)
  local install_dir = vim.fs.joinpath(dpp_base_dir, "repos", "github.com", username, repo)
  local url = string.format("https://github.com/%s/%s", username, repo)
  if not vim.uv.fs_stat(install_dir) then
    vim.fn.system { "git", "clone", url, install_dir }
  end
  vim.opt.runtimepath:prepend(install_dir)
end

-- Bootstrap
ensure_plugin("Shougo", "dpp.vim")
ensure_plugin("Shougo", "dpp-ext-lazy")

-- augroup
local dpp_group = vim.api.nvim_create_augroup("MyDppConfig", { clear = true })

-- dpp configurations
local dpp = require "dpp"
if dpp.load_state(dpp_base_dir) then
  -- Ensure that the denops.vim and other dpp extensions are installed.
  local plugins = {
    { "Shougo", "dpp-ext-installer" },
    { "Shougo", "dpp-ext-local" },
    { "Shougo", "dpp-ext-packspec" },
    { "Shougo", "dpp-ext-toml" },
    { "Shougo", "dpp-protocol-git" },
    { "vim-denops", "denops.vim" },
  }
  vim.iter(plugins):each(function(arg)
    ensure_plugin(unpack(arg))
  end)

  -- NOTE: Manual load is needed for neovim because "--noplugin" is used to optimize.
  vim.cmd.runtime { args = { "plugin/denops.vim" }, bang = true }

  -- Create cache file
  vim.api.nvim_create_autocmd("User", {
    group = dpp_group,
    pattern = "DenopsReady",
    callback = function()
      vim.notify("[Dpp] Failed to load the `state_file`", vim.log.levels.WARN)
      dpp.make_state(dpp_base_dir, vim.fs.joinpath(dpp_config_dir, "dpp.ts"))
    end,
    desc = "Save dpp.vim's state in the cache file.",
  })
else
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = dpp_group,
    pattern = { "*.lua", "*.vim", "*.toml", "*.ts", "vimrc", ".vimrc" },
    callback = function()
      dpp.check_files()
    end,
    desc = "Check if the cache and state files of dpp.vim is outdated",
  })
  -- Check new plugins
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = dpp_group,
    pattern = { "*.toml" },
    callback = function()
      if vim.fn.empty(dpp.sync_ext_action("installer", "getNotInstalled")) == 0 then
        dpp.sync_ext_action("installer", "install")
      end
    end,
    desc = "Install not-installed plugins",
  })
end

vim.api.nvim_create_autocmd("User", {
  group = dpp_group,
  pattern = "Dpp:makeStatePost",
  callback = function()
    vim.notify("[Dpp] (re)generated the cache and state files", vim.log.levels.INFO)
  end,
  desc = "echo the massage when dpp make_state is finished",
})

-- User commands for dpp.vim
vim.api.nvim_create_user_command("DppInstall", function(_)
  require("dpp").async_ext_action("installer", "install")
end, {})

vim.api.nvim_create_user_command("DppUpdate", function(opts)
  local args = opts.fargs
  require("dpp").async_ext_action("installer", "update", { names = args })
end, { nargs = "*" })

vim.api.nvim_create_user_command("DppClearState", function()
  require("dpp").clear_state()
  vim.loader.reset()
  vim.cmd.quit { bang = true }
end, {})
