-- [vim-easy-align](https://github.com/junegunn/vim-easy-align)
--
-- A Vim alignment plugin
--
return {
  "junegunn/vim-easy-align",
  keys = {
    { "n", "<Plug>(EasyAlign)" },
    { "v", "<Plug>(EasyAlign)" },
  },
  setup = function()
    vim.keymap.set({ "n", "v" }, "<Leader>a", "<Plug>(EasyAlign)", { silent = true })
  end,
  config = function()
    -- extending alignment rules
    vim.g.easy_align_delimiters = {
      [">"] = {
        pattern = [[>>\|=>\|>]],
      },
      ["/"] = {
        pattern = [[//\+\|/\*\|\*/]],
        ignore_groups = { "String" },
      },
      ["#"] = {
        pattern = [[#\+]],
        ignore_groups = { "String" },
        delimiter_align = "l",
      },
      ["]"] = {
        pattern = [=[[[\]]]=],
        left_margin = 0,
        right_margin = 0,
        stick_to_left = 0,
      },
      [")"] = {
        pattern = "[()]",
        left_margin = 0,
        right_margin = 0,
        stick_to_left = 0,
      },
      ["d"] = {
        pattern = [[ \(\S\+\s*[;=]\)\@=]],
        left_margin = 0,
        right_margin = 0,
      },
    }
  end,
}
