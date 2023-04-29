return {
  -- Flexible key mapping manager.
  "hrsh7th/nvim-insx",
  event = { 'InsertEnter', 'CmdlineEnter' },
  config = function(_, _)
    -- Alias <C-h> to <BS>
    vim.keymap.set({ 'i', 'c' }, '<C-h>', '<BS>', { remap = true })
    -- Use preset
    require('insx.preset.standard').setup()
  end,
}
