if vim.env.VSCODE then
  vim.g.vscode = true
end

if vim.loader then
  vim.loader.enable()
end

-- Variables depending on Nix packages
vim.g.sqlite_clib_path = "@sqlite_clib_path@"

require "rc.core"
