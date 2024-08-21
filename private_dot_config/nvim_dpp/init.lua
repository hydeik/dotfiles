if vim.loader then
  vim.loader.enable()
end

-- Load settings & plugins
require("rc.bootstrap").run()

vim.cmd [[filetype plugin indent on]]
vim.cmd [[syntax enable]]
