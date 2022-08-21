local config_dir = vim.fn.stdpath("config")
local modules_dir = config_dir .. "/lua/rc/modules"
local data_dir = string.format("%s/site", vim.fn.stdpath("data"))
local packer_compiled = data_dir .. "/lua/packer_compiled.lua"
local packer = nil

local ensured_plugins = {}

local Packer = {}
Packer.__index = Packer

--- Ensure that a plugin is installed and execute a callback.
--- @param repo_user string   Github user name for the plugin.
--- @param plugin_name string Repositry name for the plugin.
--- @param post_install_hook  function|nil  The hook function to be called after installation.
local ensure_plugin = function(repo_user, plugin_name, post_install_hook)
  local install_dir = string.format("%s/pack/packer/opt/%s", data_dir, plugin_name)
  local repo_url = string.format("https://github.com/%s/%s", repo_user, plugin_name)
  local state = vim.loop.fs_stat(install_dir)
  if not state then
    -- Download the plugin
    vim.fn.system { "git", "clone", "--depth", "1", repo_url, install_dir }
    if post_install_hook ~= nil then
      post_install_hook()
    end
  end

  table.insert(ensured_plugins, string.format("%s/%s", repo_user, plugin_name))
end

--- Load plugins defined in modules
function Packer:load_plugins()
  self._plugin_specs = {}

  local get_plugins_list = function()
    local list = {}
    local tmp = vim.split(vim.fn.globpath(modules_dir, '*/plugins.lua'), '\n')
    for _, f in ipairs(tmp) do
      list[#list + 1] = string.match(f, "lua/(.+).lua$")
    end
    return list
  end

  local plugins_file = get_plugins_list()
  for _, m in ipairs(plugins_file) do
    require(m)
  end
end

--- Load registered plugins
function Packer:load_packer()
  if not packer then
    vim.api.nvim_command("packadd packer.nvim")
    packer = require("packer")
    packer.init {
      compile_path = packer_compiled,
      disable_commands = true,
      max_jobs = 50,
      display = {
        open_fn = function()
          return require("packer.util").float { border = "single" }
        end,
      },
    }
  end
  packer.reset()

  local use = packer.use

  self:load_plugins()
  for _, repo in ipairs(ensured_plugins) do
    use { repo, opt = true }
  end

  for _, spec in ipairs(self._plugin_specs) do
    use(spec)
  end
end

-- Define commands for packer.
function Packer:define_commands()
  for _, cmd in ipairs { "Install", "Updata", "Sync" } do
    vim.api.nvim_create_user_command(string.format("Packer%s", cmd), function(opts)
      local fargs = opts.args ~= "" and opts.fargs or {}
      require("rc.core.pack")[vim.fn.tolower(cmd)](unpack(fargs))
    end, {
      complete = require("rc.core.pack").plugin_complete,
      nargs = "*",
      desc = string.format("[Packer] %s plugin(s).", cmd),
    })
  end

  vim.api.nvim_create_user_command("PackerClean", function()
    require("rc.core.pack").clean()
  end, {
    desc = "[Packer] Clean plugin(s).",
  })

  vim.api.nvim_create_user_command("PackerStatus", function()
    require("rc.core.pack").status()
  end, {
    desc = "[Packer] Output plugins' status.",
  })

  vim.api.nvim_create_user_command("PackerProfile", function()
    require("rc.core.pack").profile_output()
  end, {
    desc = "[Packer] Output plugins' profile.",
  })

  vim.api.nvim_create_user_command("PackerCompile", function(opts)
    require("rc.core.pack").compile(opts.args)
  end, {
    nargs = "*",
    desc = "[Packer] Compile plugins' configurations.",
  })

  vim.api.nvim_create_user_command("PackerLoad", function(opts)
    require("rc.core.pack").loader(unpack(opts.fargs), opts.bang)
  end, {
    complete = require("rc.core.pack").loader_complete,
    bang = true,
    nargs = "+",
    desc = "[Packer] Load plugin(s).",
  })
end

local M = setmetatable({}, {
  __index = function(_, key)
    if not packer then
      Packer:load_packer()
    end
    return packer[key]
  end
})

--- Auto compile plugin configs.
M.auto_compile = function()
  local filename = vim.fn.expand('%:p')
  if not filename:match(config_dir) then
    return
  end

  if filename:match('plugins.lua') then
    M.clean()
  end
  M.compile("profile=true")
  require('packer_compiled')
end

--- Bootstraping plugins.
M.bootstrap = function()
  -- Ensure impatient.nvim is installed.
  ensure_plugin("lewis6991", "impatient.nvim")
  vim.api.nvim_command("packadd impatient.nvim")
  local is_impatient_available, impatient = pcall(require, "impatient")
  if is_impatient_available then
    impatient.enable_profile()
  else
    vim.notify(impatient, vim.log.levels.WARN, { title = "Packer" })
  end

  -- Ensure packer.nvim is installed
  ensure_plugin("wbthomason", "packer.nvim", function()
    vim.loop.fs_mkdir(data_dir .. "/lua", 511, function()
      assert("make compile path dir faield")
    end)
    Packer:load_packer()
    packer.sync()
  end)
end

--- Register a plugin to a managed set of plugins.
--- @param plugin_spec table  Plugin specification for packer.nvim
M.register_plugin = function(plugin_spec)
  table.insert(Packer._plugin_specs, plugin_spec)
end

--- Load the cache file (packer_compiled.lua)
M.load_cache = function()
  if vim.fn.filereadable(packer_compiled) == 1 then
    -- NOTE: Make sure the `runtimepath` is properly configured to load the packer_compiled file.
    -- $XDG_DATA_HOME/site is in `runtimepath` by default.
    require("packer_compiled")
  else
    vim.notify("Run PackerCompile or PackerSync", vim.log.levels.INFO, { title = "Packer" })
  end

  -- Define packer commands
  Packer:define_commands()

  -- Hooks
  local PackerHooks = vim.api.nvim_create_augroup("PackerHooks", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    group = PackerHooks,
    pattern = "PackerCompileDone",
    callback = function()
      vim.notify("Compile Done!", vim.log.levels.INFO, { title = "Packer" })
    end,
    desc = "Notify when PackerCompile command is done.",
  })

  vim.api.nvim_create_autocmd("BufWritePost", {
    group = PackerHooks,
    pattern = "*.lua",
    callback = M.auto_compile,
    desc = "Run PackerCompile automatically when a config file is modified",
  })
end

return M
