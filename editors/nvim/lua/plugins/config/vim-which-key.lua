local M = {}

function M.setup()
  local options = { noremap = true, silent = true }
  vim.api
    .nvim_set_keymap("n", "<Space>", "<cmd>WhichKey '<Space>'<CR>", options)
  vim.api.nvim_set_keymap("n", ";", "<cmd>WhichKey ';'<CR>", options)
  vim.api.nvim_set_keymap("n", ",", "<cmd>WhichKey ','<CR>", options)
  vim.api.nvim_set_keymap("n", "s", "<cmd>WhichKey 's'<CR>", options)
  vim.api.nvim_set_keymap("n", "m", "<cmd>WhichKey 'm'<CR>", options)

  vim.api.nvim_set_keymap(
    "v", "<Space>", "<cmd>WhichKeyVisual '<Space>'<CR>", options
  )
  vim.api.nvim_set_keymap("v", ";", "<cmd>WhichKeyVisual ';'<CR>", options)
  vim.api.nvim_set_keymap("v", ",", "<cmd>WhichKeyVisual ','<CR>", options)
  vim.api.nvim_set_keymap("v", "s", "<cmd>WhichKeyVisual 's'<CR>", options)
  vim.api.nvim_set_keymap("v", "m", "<cmd>WhichKeyVisual 'm'<CR>", options)
end

M._space_map = {}
M._leader_map = {}
M._localleader_map = {}
M._s_map = {}
M._m_map = {}

function M.config()
  M._space_map = {
    ['/'] = "lines",
    ['*'] = "lines-current-word",
    ['B'] = "all-buffers",
    ['G'] = "grep-project",
    ['b'] = "buffers",
    -- ['d'] = "Defx",
    ['f'] = "files",
    -- ['h'] = "help",
    ['l'] = "locationlist",
    ['p'] = "project-files",
    ['q'] = "quickfix",
    ['t'] = "buffer-tags",
    ['v'] = "Vista",
  }

  M._space_map.g = {
    name = "+git",
    ['['] = "previous hunk",
    [']'] = "next hunk",
    ['d'] = "SignifyDiff",
    ['p'] = "SignifyHunkDiff",
    ['u'] = "SignifyHunkUndo",
    -- ['s'] = "Gina status",
    -- ['c'] = "Gina commit",
    -- ['C'] = "Gina commit --amend",
    -- ['b'] = "Gina branch",
    -- ['t'] = "Gina tag",
    -- ['l'] = "Gina log",
    -- ['L'] = "Gina log :%",
    -- ['f'] = "Gina ls",
    ['a'] = "git-actions",
    ['b'] = "git-branches",
    ['f'] = "git-files",
    ['l'] = "git-logs",
  }

  vim.g.which_key_space_map = M._space_map
  vim.fn["which_key#register"]('<Space>', 'g:which_key_space_map')

  -- 'm' mappings
  --  Key mapping for LSP features
  M._m_map = {
    ["["] = "diagnostic-prev",
    ["]"] = "diagnostic-next",
    ["D"] = "declaration",
    ["F"] = "format",
    ["H"] = "signature-help",
    ["R"] = "rename",
    ["d"] = "definition",
    ["e"] = "show-line-diagnostics",
    ["f"] = "format-range",
    ["h"] = "document-hover",
    ["i"] = "implementation",
    ["o"] = "document-symbol",
    ["p"] = "peek-definition",
    ["q"] = "list-diagnostics",
    ["r"] = "reference",
    ["t"] = "type-definition",
  }

  vim.g.which_key_m_map = M._m_map
  vim.fn["which_key#register"]('m', 'g:which_key_m_map')

  -- leader mappings {{{
  M._leader_map = {
    ["J"] = "join-with-chars",
    ["Q"] = "quit-without-saving",
    ["W"] = "save-all-buffers",
    ["a"] = "easy-align",
    ["d"] = "doge-generate",
    ["q"] = "quit",
    ["r"] = "register/yank",
    ["w"] = "save",
    ["x"] = "strip-whitespace",
    [";"] = "vim-command",
  }

  M._leader_map.c = {
    name = "+comment",
    ["a"] = "caw:dollarpos:toggle",
    ["b"] = "caw:box:toggle",
    ["c"] = "caw:hatpos:toggle",
    ["w"] = "caw:wrap:toggle",
    ["["] = "caw:jump:comment-prev",
    ["]"] = "caw:jump:comment-next",
  }

  M._leader_map.t = {
    name = "+toggle",
    ["c"] = "cursor-columns",
    ["h"] = "listchars",
    ["l"] = "cursor-line",
    ["n"] = "line-number",
    ["p"] = "paste-mode",
    ["r"] = "relative-number",
    ["s"] = "spell-check",
    ["w"] = "wrap-text",
  }

  -- M._leader_map["="] = {
  --   name  = "+codefmt",
  --   ['='] = "format-line",
  --   ['b'] = "format-buffer",
  -- }

  vim.g.which_key_leader_map = M._leader_map
  vim.fn["which_key#register"](';', 'g:which_key_leader_map')

  -- s mappings
  -- Window manipulation, EasyMotion, Sandwich
  M._s_map = {
    ["f"] = "easymotion-overwin-{char}",
    ["s"] = "easymotion-overwin-{char}{char}",
    ["h"] = "easymotion-linebackward",
    ["j"] = "easymotion-j",
    ["k"] = "easymotion-k",
    ["l"] = "easymotion-lineforward",
    ["n"] = "easymotion-move-next",
    ["p"] = "easymotion-move-prev",
    ["/"] = "easymotion-search",
    ["a"] = "sandwich-add",
    ["d"] = "sandwich-delete",
    ["db"] = "sandwich-delete-between",
    ["r"] = "sandwich-replace",
    ["rb"] = "sandwich-replace-between",
    ["-"] = "window-split-below",
    ["|"] = "window-split-right",
    ["="] = "window-balance",
    ["c"] = "window-close",
    ["o"] = "windown-only",
    ["t"] = "window-tabnew",
    ["x"] = "window-clear-buffer",
    ["z"] = "window-toggle-zoom",
  }

  vim.g.which_key_s_map = M._s_map
  vim.fn["which_key#register"]('s', 'g:which_key_s_map')

  -- which-key events
  require("core.event").create_augroups(
    {
      user_plugin_which_key = {
        { "FileType", "which_key", "set laststatus=0" },
        { "BufLeave", "<buffer>", "set laststatus=2" },
      },
    }
  )
end

return M
