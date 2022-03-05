local path = require "rc.core.path"
local packer = nil

local Packer = {}
Packer.__index = Packer

function Packer:load_packer()
  if not packer then
    vim.cmd [[packadd packer.nvim]]
    packer = require "packer"
    packer.init {
      package_root = path.pack_root,
      compile_path = path.packer_compiled,
      disable_commands = true,
      max_jobs = 50,
      display = {
        open_fn = function()
          return require("packer.util").float { border = "single" }
        end,
      },
      -- prifile = {
      --   enable = true,
      --   threshold = 1,
      -- },
    }
  end
  packer.reset()

  -- local layers = {
  --   "packages",
  -- }
  -- for _, layer in ipairs(layers) do
  --   require("rc.plugins." .. layer).load_plugins(packer.use, packer.use_rocks)
  -- end
  require("rc.plugins.packages").load_plugins(packer.use, packer.use_rocks)
end

--- Ensure that a plugin is installed and execute a callback.
---@param user string -- Github user name
---@param name string -- Repositry name
---@param opt boolean -- true if the plugin is 'opt'
---@return boolean
local function ensure(user, name, opt)
  local dir = opt and "opt" or "start"
  local install_path = path.join(path.pack_root, "packer", dir, name)
  local url = ("https://github.com/%s/%s"):format(user, name)
  local is_installed = false
  if not path.is_dir(install_path) then
    -- Download the plugin
    vim.fn.system { "git", "clone", "--depth", "1", url, install_path }
    is_installed = true
  end
  return is_installed
end

function Packer:ensure_plugins()
  -- Ensure impatient.nvim is installed.
  -- TODO: only required until the [PR](https://github.com/neovim/neovim/pull/15436) is merged.
  ensure("lewis6991", "impatient.nvim", false)

  -- Ensure packer.nvim is installed.
  local packer_is_installed = ensure("wbthomason", "packer.nvim", true)

  if packer_is_installed then
    self:load_packer()
  end

  return packer_is_installed
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    Packer:load_packer()
    return packer[key]
  end,
})

--- Define commands provided by packer.nvim
function plugins.define_commands()
  vim.api.nvim_add_user_command("PackerInstall", function(opts)
    local fargs = opts.args ~= "" and opts.fargs or {}
    require("rc.plugins").install(unpack(fargs))
  end, {
    complete = require("rc.plugins").plugin_complete,
    nargs = "*",
    desc = "[Packer] Install plugin(s).",
  })

  vim.api.nvim_add_user_command("PackerUpdate", function(opts)
    local fargs = opts.args ~= "" and opts.fargs or {}
    require("rc.plugins").update(unpack(fargs))
  end, {
    complete = require("rc.plugins").plugin_complete,
    nargs = "*",
    desc = "[Packer] Update plugin(s).",
  })

  vim.api.nvim_add_user_command("PackerSync", function(opts)
    local fargs = opts.args ~= "" and opts.fargs or {}
    require("rc.plugins").sync(unpack(fargs))
  end, {
    complete = require("rc.plugins").plugin_complete,
    nargs = "*",
    desc = "[Packer] Sync plugin(s).",
  })

  vim.api.nvim_add_user_command("PackerClean", function()
    require("rc.plugins").clean()
  end, {
    desc = "[Packer] Clean plugin(s).",
  })

  vim.api.nvim_add_user_command("PackerStatus", function()
    require("rc.plugins").status()
  end, {
    desc = "[Packer] Output plugins' status.",
  })

  vim.api.nvim_add_user_command("PackerProfile", function()
    require("rc.plugins").profile_output()
  end, {
    desc = "[Packer] Output plugins' profile.",
  })

  vim.api.nvim_add_user_command("PackerCompile", function(opts)
    require("rc.plugins").compile(opts.args)
  end, {
    nargs = "*",
    desc = "[Packer] Output plugins' profile.",
  })

  vim.api.nvim_add_user_command("PackerLoad", function(opts)
    require("rc.plugins").loader(opts.fargs, opts.bang)
  end, {
    complete = require("rc.plugins").loader_complete,
    bang = true,
    nargs = "+",
    desc = "[Packer] Load plugin(s).",
  })
end

--- Bootstrapping plugsins.
--- Takes a callback function that takes if packer.nvim was installed.
---@param callback function(boolean)
function plugins.bootstrap(callback)
  -- hook before loading any plugins
  require "rc.plugins.hook_before"

  local installed = Packer:ensure_plugins()

  if callback then
    callback(installed)
  end

  plugins.define_commands()
end

function plugins.auto_compile()
  local file = vim.fn.expand "%:p"
  if file:match "nvim/lua/rc/plugins/packages.lua" or file:match "nvim/lua/rc/config/%a+.lua" then
    plugins.compile()
  end
end

return plugins
