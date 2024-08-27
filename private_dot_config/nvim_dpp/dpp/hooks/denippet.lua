--- [denippet.vim](https://github.com/uga-rosa/denippet.vim)
-- A snippet plugin for Vim/Neovim, powered by TypeScript.

-- lua_source {{{
local config_dir = vim.fn.stdpath "config" --[[@as string]]
local snippets_files = vim.fn.globpath(vim.fs.joinpath(config_dir, "snippets"), "**/*.*", true, true)

if not vim.tbl_isempty(snippets_files) then
  vim.iter(snippets_files):each(function(path)
    local name = vim.fn.fnamemodify(path, ":t:r")
    if name == "global" then
      vim.fn["denippet#load"](path, "")
    else
      vim.fn["denippet#load"](path)
    end
  end)
end

vim.keymap.set({ "i", "s" }, "<C-f>", function()
  if vim.fn["denippet#jumpable"](1) then
    return "<Plug>(denippet-jump-next)"
  else
    return "<C-G>U<Right>"
  end
end, { expr = true, remap = true })

vim.keymap.set({ "i", "s" }, "<C-b>", function()
  if vim.fn["denippet#jumpable"](-1) then
    return "<Plug>(denippet-jump-prev)"
  else
    return "<C-G>U<Left>"
  end
end, { expr = true, remap = true })
-- }}}
