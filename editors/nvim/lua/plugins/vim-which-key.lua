local M = {}

function M.hook_add()
  local options = {noremap = true, silent = true}
  vim.api.nvim_set_keymap("n", "<Space>", "<cmd>WhichKey '<Space>'<CR>", options)
  vim.api.nvim_set_keymap("n", ";",       "<cmd>WhichKey ';'<CR>",       options)
  vim.api.nvim_set_keymap("n", ",",       "<cmd>WhichKey ','<CR>",       options)
  vim.api.nvim_set_keymap("n", "s",       "<cmd>WhichKey 's'<CR>",       options)

  vim.api.nvim_set_keymap("v", "<Space>", "<cmd>WhichKeyVisual '<Space>'<CR>", options)
  vim.api.nvim_set_keymap("v", ";",       "<cmd>WhichKeyVisual ';'<CR>",       options)
  vim.api.nvim_set_keymap("v", ",",       "<cmd>WhichKeyVisual ','<CR>",       options)
  vim.api.nvim_set_keymap("v", "s",       "<cmd>WhichKeyVisual 's'<CR>",       options)
end

M._space_map = {}
M._leader_map = {}
M._localleader_map = {}
M._s_map = {}
M._m_map = {}

function M.hook_source()
  M._space_map = {
    ['['] = "previous item in list",
    [']'] = "next item in list",
    ['/'] = "grep",
    ['*'] = "grep-current-word",
    ['b'] = "buffers",
    ['d'] = "Defx",
    ['f'] = "files",
    ['h'] = "help",
    ['l'] = "locationlist",
    ['q'] = "quickfix",
    ['v'] = "Vista",
  }

  -- " gina
  -- let g:which_key_space_map.g = {
  --      \ 'name': '+git',
  --      \ 's': 'Gina status',
  --      \ 'A': 'Gina changes HEAD',
  --      \ 'c': 'Gina commit',
  --      \ 'C': 'Gina commit --amend',
  --      \ 'b': 'Gina branch',
  --      \ 'f': 'Gina ls',
  --      \ 't': 'Gina tag',
  --      \ 'g': 'Gina grep',
  --      \ 'q': 'Gina qrep',
  --      \ 'd': 'Gina changes origin/HEAD...',
  --      \ 'l': 'Gina log',
  --      \ 'L': 'Gina log :%',
  --      \ 'rc': 'Gina changes <C-r><C-w>',
  --      \ 'rs': 'Gina show <C-r><C-w>',
  --      \ }
  vim.g.which_key_space_map = M._space_map
  vim.fn["which_key#register"]('<Space>', 'g:which_key_space_map')

  -- " 'm' mappings {{{
  -- " -----
  -- " Key mapping for LSP features
  -- let g:which_key_m_map = {
  --      \ '?': 'diagnostic-info',
  --      \ '[': 'diagnostic-prev',
  --      \ ']': 'diagnostic-next',
  --      \ 'A': 'codeaction',
  --      \ 'D': 'declaration',
  --      \ 'F': 'fix-current',
  --      \ 'R': 'rename',
  --      \ 'a': 'codeaction-selected',
  --      \ 'd': 'definition',
  --      \ 'e': 'refactor',
  --      \ 'f': 'format',
  --      \ 'h': 'document-hover',
  --      \ 'i': 'implementation',
  --      \ 'j': 'list-location',
  --      \ 'L': 'codelens',
  --      \ 'o': 'document-symbols',
  --      \ 'q': 'list-diagnostics',
  --      \ 'r': 'reference',
  --      \ 's': 'workspace-symbols',
  --      \ 't': 'type-definition',
  --      \ }
  --
  -- call which_key#register('m', 'g:which_key_m_map')
  -- " }}}

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
    name =  "+comment",
    ["a"] = "caw:dollarpos:toggle",
    ["b"] = "caw:box:toggle",
    ["c"] = "caw:hatpos:toggle",
    ["w"] = "caw:wrap:toggle",
    ["["] = "caw:jump:comment-prev",
    ["]"] = "caw:jump:comment-next",
  }

  M._leader_map.t = {
    name  = "+toggle",
    ["c"] = "cursor-columns",
    ["h"] = "listchars",
    ["l"] = "cursor-line",
    ["n"] = "line-number",
    ["p"] = "paste-mode",
    ["r"] = "relative-number",
    ["s"] = "spell-check",
    ["w"] = "wrap-text",
  }

  vim.g.which_key_leader_map = M._leader_map
  vim.fn["which_key#register"](';', 'g:which_key_leader_map')

  -- s mappings
  -- Window manipulation, EasyMotion, Sandwich
  M._s_map = {
    ["f"]  = "easymotion-overwin-{char}",
    ["s"]  = "easymotion-overwin-{char}{char}",
    ["h"]  = "easymotion-linebackward",
    ["j"]  = "easymotion-j",
    ["k"]  = "easymotion-k",
    ["l"]  = "easymotion-lineforward",
    ["n"]  = "easymotion-move-next",
    ["p"]  = "easymotion-move-prev",
    ["/"]  = "easymotion-search",
    ["a"]  = "sandwich-add",
    ["d"]  = "sandwich-delete",
    ["db"] = "sandwich-delete-between",
    ["r"]  = "sandwich-replace",
    ["rb"] = "sandwich-replace-between",
    ["-"]  = "window-split-below",
    ["|"]  = "window-split-right",
    ["="]  = "window-balance",
    ["c"]  = "window-close",
    ["o"]  = "windown-only",
    ["t"]  = "window-tabnew",
    ["x"]  = "window-clear-buffer",
    ["z"]  = "window-toggle-zoom",
  }

  vim.g.which_key_s_map = M._s_map
  vim.fn["which_key#register"](';', 'g:which_key_s_map')

  -- which-key events
  vim.api.nvim_command("augroup user-plugin-which-key")
  vim.api.nvim_command("autocmd!")
  vim.api.nvim_command[[
    autocmd FileType which_key set laststatus=0 | autocmd BufLeave <buffer> set laststatus=2
  ]]
  vim.api.nvim_command("augroup END")
end

return M