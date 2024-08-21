local M = {}

local ensure_plugin = function(username, repo)
  local install_dir = vim.fs.joinpath(M.dpp_base_dir, "repos", "github.com", username, repo)
  local url = string.format("https://github.com/%s/%s", username, repo)
  if not vim.uv.fs_stat(install_dir) then
    vim.fn.system { "git", "clone", url, install_dir }
  end
  vim.opt.runtimepath:prepend(install_dir)
end

local auto_install_plugins = function()
  local not_installed_plugins = vim
    .iter(M._dpp.get())
    :filter(function(_, p)
      if p.name == "dpp.vim" or p.name == "dpp-ext-lazy" then
        return false
      end
      if vim.uv.fs_stat(p.rtp) then
        return false
      end
      return true
    end)
    :totable()

  if not vim.tbl_isempty(not_installed_plugins) then
    vim.fn["denops#server#wait_async"](function()
      M._dpp.async_ext_action("installer", "install")
    end)
    vim.api.nvim_create_autocmd("User", {
      pattern = "Dpp:makeStatePost",
      group = M.rc_autocmds,
      callback = function()
        vim.notify("[dpp] Installed new plugin(s). You may need to restart nvim.", vim.log.levels.WARN)
      end,
      desc = "[dpp] Echo a message after auto-installing plugin(s)",
    })
  end
end

vim.api.nvim_create_autocmd("User", {
  group = M.rc_autocmds,
  pattern = "Dpp:makeStatePost",
  callback = function()
    vim.notify("[dpp] (re)generated the cache and state files", vim.log.levels.INFO)
  end,
  desc = "echo the massage when dpp make_state is finished",
})

local setup_dpp_ext = function()
  -- Ensure that the denops.vim and other dpp extensions are installed.
  local dpp_extensions = {
    { "Shougo", "dpp-ext-installer" },
    { "Shougo", "dpp-ext-local" },
    { "Shougo", "dpp-ext-packspec" },
    { "Shougo", "dpp-ext-toml" },
    { "Shougo", "dpp-protocol-git" },
    { "vim-denops", "denops.vim" },
  }
  vim.iter(dpp_extensions):each(function(arg)
    ensure_plugin(unpack(arg))
  end)
end

-- Generate the cache and state files for dpp.vim.
local make_state = function()
  M._dpp.make_state(M.dpp_base_dir, vim.fs.joinpath(vim.env.DPP_CONFIG_DIR, "dpp.ts"))
  vim.api.nvim_create_autocmd("User", {
    pattern = "Dpp:makeStatePost",
    group = M.rc_autocmds,
    callback = function()
      M._dpp.load_state(M.dpp_base_dir)
      auto_install_plugins()
    end,
    once = true,
    nested = true,
    desc = "[dpp] Save dpp.vim's state in the cache file.",
  })
end

-- Load dpp.vim
local load_dpp = function()
  if M._dpp.load_state(M.dpp_base_dir) then
    setup_dpp_ext()
    vim.fn["denops#server#wait_async"](function()
      make_state()
    end)
  else
    auto_install_plugins()
  end
  local pattern = {
    vim.fs.joinpath(M.dpp_config_dir, "**", "*.lua"),
    vim.fs.joinpath(M.dpp_config_dir, "**", "*.toml"),
    vim.fs.joinpath(M.dpp_config_dir, "**", "*.ts"),
    vim.fs.joinpath(M.dpp_config_dir, "**", "*.vim"),
    "vimrc",
    ".vimrc",
  }
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = M.rc_autocmds,
    pattern = pattern,
    callback = function()
      vim.notify("[dpp] Running check_files() ...", vim.log.levels.INFO)
      M._dpp.check_files()
    end,
    desc = "[dpp] Check if the cache and state files of dpp.vim is outdated",
  })
  vim.api.nvim_create_autocmd("User", {
    pattern = "Dpp:makeStatePost",
    group = M.rc_autocmds,
    callback = function()
      vim.notify("[dpp] (re)generated the cache and state files", vim.log.levels.INFO)
    end,
    desc = "[dpp] echo a message after make_state()",
  })
end

-- Define user commands for dpp.vim
local define_dpp_commands = function()
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
end

M.run = function()
  local config_dir = vim.fn.stdpath "config" --[[@as string]]
  local data_dir = vim.fn.stdpath "data" --[[@as string]]

  M.dpp_base_dir = vim.fs.joinpath(data_dir, "dpp")
  M.dpp_config_dir = vim.fs.joinpath(config_dir, "dpp")
  M.dpp_hooks_dir = vim.fs.joinpath(config_dir, "dpp", "hooks")
  -- The following envs are for the use in Toml and Typescript files.
  vim.env.DPP_BASE_DIR = M.dpp_base_dir
  vim.env.DPP_CONFIG_DIR = M.dpp_config_dir
  vim.env.DPP_HOOKS_DIR = M.dpp_hooks_dir

  M.rc_autocmds = vim.api.nvim_create_augroup("DppRcAutocmds", { clear = true })

  ensure_plugin("Shougo", "dpp.vim")
  ensure_plugin("Shougo", "dpp-ext-lazy")
  M._dpp = require "dpp"

  load_dpp()
  define_dpp_commands()
end

return M
