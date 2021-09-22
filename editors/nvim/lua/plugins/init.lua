local nvim_dir = require("globals").nvim_dir
local site_packages = nvim_dir.site_packages
local packer = nil

local Packer = {}
Packer.__index = Packer

function Packer:load_packer()
  if not packer then
    vim.cmd [[packadd packer.nvim]]
    packer = require "packer"
    packer.init {
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

  require("plugins.packages").load_plugins(packer.use, packer.use_rocks)
end

function Packer:init_ensure_plugins()
  -- Install packer.nvim automatically if necessary.
  local packer_dir = site_packages .. "/pack/packer/opt/packer.nvim"
  local packer_repo = "https://github.com/wbthomason/packer.nvim"
  local state = vim.loop.fs_stat(packer_dir)
  if not state then
    local out = vim.fn.system { "git", "clone", packer_repo, packer_dir }
    print(out)
    self:load_packer()
    packer.install()
    packer.compile()
  end
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    Packer:load_packer()
    return packer[key]
  end,
})

function plugins.ensure_plugins()
  Packer:init_ensure_plugins()
end

function plugins.auto_compile()
  local file = vim.fn.expand "%:p"
  if file:match "nvim/lua/plugins/packages.lua" or file:match "nvim/lua/plugins/config/%a+.lua" then
    plugins.compile()
  end
end

function plugins.define_commands()
  vim.cmd [[command! PackerInstall           lua require('plugins').install()]]
  vim.cmd [[command! PackerUpdate            lua require('plugins').update()]]
  vim.cmd [[command! PackerSync              lua require('plugins').sync()]]
  vim.cmd [[command! PackerClean             lua require('plugins').clean()]]
  vim.cmd [[command! -nargs=* PackerCompile  lua require('plugins').compile(<q-args>)]]
  vim.cmd [[command! PackerStatus            lua require('plugins').status()]]
  vim.cmd [[command! PackerProfile           lua require('plugins').profile_output()]]
  vim.cmd [[command! -nargs=+ -complete=customlist,v:lua.require'plugins'.loader_complete PackerLoad lua require('plugins').loader(<q-args>)]]
end

return plugins
