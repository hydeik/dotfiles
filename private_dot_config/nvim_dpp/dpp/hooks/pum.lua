--- [pum.vim](https://github.com/Shougo/pum.vim)
--- Original popup completion menu framework library

-- lua_source {{{
vim.fn["pum#set_option"] {
  commit_characters = { "." },
  insert_preview = true,
  follow_cursor = true,
  max_width = 80,
  preview = true,
  preview_width = 80,
}
-- }}}
