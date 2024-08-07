--- Configure skkeleton

-- lua_add {{{
vim.keymap.set({ "i", "c", "t" }, "<C-j>", "<Plug>(skkeleton-toggle)", { desc = "Toggle skkeleton" })
-- }}}

-- lua_source {{{

-- Configure skkeleton
-- TODO: set paths for global and user jisyo on Windows
local global_jisyo, user_jisyo
local plat = require "rc.platform"
if plat.is_mac then
  global_jisyo = "~/Library/Application Support/AquaSKK/SKK-JISYO.L"
  user_jisyo = "~/Library/Application Support/AquaSKK/skk-jisyo.utf8"
else
  global_jisyo = "/usr/share/skk/SKK-JISYO.L"
  user_jisyo = "~/.skkeleton"
end

vim.fn["skkeleton#config"] {
  globalJisyo = global_jisyo,
  userJisyo = user_jisyo,
  eggLikeNewline = true,
  useSkkServer = true,
  immediatelyCancel = false,
  registerConvertResult = true,
}

-- custom kana-table
vim.fn["skkeleton#register_kanatable"]("rom", {
  ["("] = { "（", "" },
  [")"] = { "）", "" },
  ["/"] = { "・", "" },
  ["z["] = { "『", "" },
  ["z]"] = { "』", "" },
  ["z("] = { "【", "" },
  ["z)"] = { "】", "" },
})

-- sticky key
vim.fn["skkeleton#register_keymap"]("input", ";", "henkanPoint")

-- Configure skkeleton_indicator
require("skkeleton_indicator").setup {}

-- }}}
