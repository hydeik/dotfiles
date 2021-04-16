local nvim_dir = require("core.globals").nvim_dir
local site_packages = nvim_dir.site_packages
local packer = nil

local Packer = {}
Packer.__index = Packer

function Packer:load_packer()
  if not packer then
    vim.cmd [[packadd packer.nvim]]
    packer = require("packer")
    packer.init { disable_commands = true, max_jobs = 50 }
  end
  packer.reset()

  require("plugins.packages").load_plugins(packer.use, packer.use_rocks)
end

function Packer:init_ensure_plugins()
  local packer_dir = site_packages .. "/pack/packer/opt/packer.nvim"
  local packer_repo = "https://github.com/wbthomason/packer.nvim"
  local state = vim.loop.fs_stat(packer_dir)
  if not state then
    local out = vim.fn.system({ "git", "clone", packer_repo, packer_dir })
    print(out)
    self:load_packer()
    packer.install()
    packer.compile()
  end
end

local plugins = setmetatable(
  {}, {
    __index = function(_, key)
      Packer:load_packer()
      return packer[key]
    end,
  }
)

function plugins.ensure_plugins() Packer:init_ensure_plugins() end

function plugins.auto_compile()
  local file = vim.fn.expand("%:p")
  if file:match("nvim/lua/plugins/packages.lua") or
    file:match("nvim/lua/plugins/config/%a+.lua") then plugins.compile() end
end

return plugins
