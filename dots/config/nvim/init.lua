if vim.env.VSCODE then
  vim.g.vscode = true
end

if vim.loader then
  vim.loader.enable()
end

require "rc.core"
