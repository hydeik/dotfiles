local M = {}

function M.setup()
  vim.g.vsnip_snippet_dir = vim.fn.stdpath "config" .. "/snippets"
  local nvim_dir = require("core.globals").nvim_dir
  vim.g.vsnip_snippet_dirs = { nvim_dir.site_packages .. "/pack/packer/start/friendly-snippets/snippets" }
end

function M.config()
  vim.keymap.imap {
    "<C-l>",
    "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'",
    expr = true,
    silent = true,
  }
  vim.keymap.smap {
    "<C-l>",
    "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'",
    expr = true,
    silent = true,
  }
  vim.keymap.imap {
    "<Tab>",
    "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'",
    expr = true,
    silent = true,
  }
  vim.keymap.smap {
    "<Tab>",
    "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'",
    expr = true,
    silent = true,
  }
  vim.keymap.imap {
    "<S-Tab>",
    "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'",
    expr = true,
    silent = true,
  }
  vim.keymap.smap {
    "<S-Tab>",
    "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'",
    expr = true,
    silent = true,
  }
end

return M
