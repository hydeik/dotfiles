-- lua_add {{{
vim.keymap.set("n", "<Space>?", function()
  require("which-key").show { global = false }
end, { desc = "Buffer keymaps (which-key)" })

vim.keymap.set("n", "<C-w><Space>", function()
  require("which-key").show { kyes = "<C-w>", loop = true }
end, { desc = "Window Hydra mode (which-key)" })
-- }}}

-- lua_source {{{
require("which-key").setup {
  defaults = {},
  spec = {
    mode = { "n", "v" },
    { "<Space><tab>", group = "tabs" },
    { "<Space>c", group = "code" },
    { "<Space>f", group = "file/find" },
    { "<Space>g", group = "git" },
    { "<Space>h", group = "hunks" },
    { "<Space>q", group = "quit/session" },
    { "<Space>s", group = "search" },
    { "<Space>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
    { "<Space>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
    { "[", group = "prev" },
    { "]", group = "next" },
    { "g", group = "goto" },
    { "gs", group = "surround" },
    { "z", group = "fold" },
  },
}
-- }}}
