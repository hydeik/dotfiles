if vim.loader then
  vim.loader.enable()
end

if not vim.g.vscode then
  require "rc.core"
end
