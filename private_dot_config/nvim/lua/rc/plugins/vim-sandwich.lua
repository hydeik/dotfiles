-- [vim-sandwich](https://github.com/machakann/vim-sandwich)
--
-- Set of operators and textobjects to search/select/edit sandwiched texts.
--
return {
    "machakann/vim-sandwich",
    event = { "CursorHold" },
    keys = {
      { "n", "<Plug>(sandwich-" },
      { "x", "<Plug>(sandwich-" },
      { "o", "<Plug>(sandwich-" },
      { "o", "<Plug>(operator-sandwich-" },
      { "x", "<Plug>(operator-sandwich-" },
      { "o", "<Plug>(textobj-sandwich-" },
      { "x", "<Plug>(textobj-sandwich-" },
    },
    setup = function()
      vim.g.sandwich_no_default_key_mappings = 1
      vim.g.operator_sandwich_no_default_key_mappings = 1
      vim.g.textobj_sandwich_no_default_key_mappings = 1

      -- Key mappings
      -- add
      vim.keymap.set({ "n", "x", "o" }, "sa", "<Plug>(sandwich-add)", { silent = true })
      -- delete
      vim.keymap.set({ "n", "x" }, "sd", "<Plug>(sandwich-delete)")
      vim.keymap.set("n", "sdb", "<Plug>(sandwich-delete-auto)")
      -- replace
      vim.keymap.set({ "n", "x" }, "sr", "<Plug>(sandwich-replace)")
      vim.keymap.set("n", "srb", "<Plug>(sandwich-replace-auto)")
      -- textobj auto
      vim.keymap.set({ "o", "x" }, "ab", "<Plug>(textobj-sandwich-auto-a)")
      vim.keymap.set({ "o", "x" }, "ib", "<Plug>(textobj-sandwich-auto-i)")
      -- textobj query
      vim.keymap.set({ "o", "x" }, "as", "<Plug>(textobj-sandwich-query-a)")
      vim.keymap.set({ "o", "x" }, "is", "<Plug>(textobj-sandwich-query-i)")
    end,
    config = function()
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
    end,
  }
