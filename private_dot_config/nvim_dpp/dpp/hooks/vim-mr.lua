--- [vim-mr](https://github.com/lambdalisue/vim-mr)
-- Small plugin to track MRU/MRJ

-- lua_source {{{
local state_dir = vim.fn.stdpath "state"
vim.g["mr#mru#filename"] = vim.fs.join(state_dir, "mru")
vim.g["mr#mrw#filename"] = vim.fs.join(state_dir, "mrw")
vim.g["mr#mrr#filename"] = vim.fs.join(state_dir, "mrr")
vim.g["mr#mrd#filename"] = vim.fs.join(state_dir, "mrd")
-- }}}
