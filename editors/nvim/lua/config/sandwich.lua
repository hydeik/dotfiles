local M = {}

function M.setup()
  vim.g.sandwich_no_default_key_mappings = 1
  vim.g.operator_sandwich_no_default_key_mappings = 1
  vim.g.textobj_sandwich_no_default_key_mappings = 1

  -- Key mappings
  local nmap = vim.keymap.nmap
  local xmap = vim.keymap.xmap
  local omap = vim.keymap.omap

  nmap {
    "sd",
    "<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)",
    silent = true,
  }
  nmap {
    "sr",
    "<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)",
    silent = true,
  }
  nmap {
    "sd",
    "<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)",
    silent = true,
  }
  nmap {
    "sr",
    "<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)",
    silent = true,
  }

  nmap { "sa", "<Plug>(operator-sandwich-add)" }
  xmap { "sa", "<Plug>(operator-sandwich-add)" }
  omap { "sa", "<Plug>(operator-sandwich-g@)" }
  xmap { "sd", "<Plug>(operator-sandwich-delete)" }
  xmap { "sr", "<Plug>(operator-sandwich-replace)" }

  omap { "ab", "<Plug>(textobj-sandwich-auto-a)" }
  omap { "ib", "<Plug>(textobj-sandwich-auto-i)" }
  xmap { "ab", "<Plug>(textobj-sandwich-auto-a)" }
  xmap { "ib", "<Plug>(textobj-sandwich-auto-i)" }
  omap { "as", "<Plug>(textobj-sandwich-query-a)" }
  omap { "is", "<Plug>(textobj-sandwich-query-i)" }
  xmap { "as", "<Plug>(textobj-sandwich-query-a)" }
  xmap { "is", "<Plug>(textobj-sandwich-query-i)" }
end

function M.config()
  vim.g["textobj#sandwich#stimeoutlen"] = 100
  vim.api.nvim_exec(
    [=[
      let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
      let g:sandwich#recipes += [{'buns': ['「', '」']}, {'buns': ['【', '】']}]
      let g:sandwich#recipes += [{'buns': ['（', '）']}, {'buns': ['『', '』']}]
      let g:sandwich#recipes += [{'buns': ['\(',  '\)'], 'filetype': ['vim'], 'nesting': 1}]
      let g:sandwich#recipes += [{'buns': ['\%(', '\)'], 'filetype': ['vim'], 'nesting': 1}]
    ]=],
    false
  )
end

return M
