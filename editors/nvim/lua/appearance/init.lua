-- -- Colorschem Sonokai
-- vim.cmd[[packadd sonokai]]
-- vim.o.background = "dark"
-- vim.g.sonokai_style = "shusia"
-- vim.g.sonokai_enable_italic = 1
-- vim.g.sonokai_enable_bold   = 1
-- if vim.fn.exists("g:GuiLoaded") == 0 and vim.fn.has("gui") == 0 and vim.fn.exists("$SSH_CONNECTION") then
--   -- Transparent background on terminal
--   vim.g.sonokai_transparent_background = 1
-- end
-- vim.cmd("autocmd VimEnter * ++nested colorscheme sonokai")
-- -- Set statusline
-- require("appearance.statusline").setup("sonokai")
vim.cmd [[packadd tokyonight.nvim]]
vim.g.tokyonight_style = "night"
if vim.fn.exists "g:GuiLoaded" == 0 and vim.fn.has "gui" == 0 and vim.fn.exists "$SSH_CONNECTION" == 0 then
  vim.g.tokyonight_transparent = true
end
vim.cmd [[colorscheme tokyonight]]
require("appearance.statusline").setup "tokyonight"
