--- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
-- Git integration for buffers

-- lua_source {{{
require("gitsigns").setup {
  signs = {
    add = { text = "▍" },
    change = { text = "▍" },
    delete = { text = "▸" },
    topdelete = { text = "▾" },
    changedelete = { text = "▍" },
    untracked = { text = "▍" },
  },
  numhl = true,
  word_diff = true,
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]h", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "Next diff/hunk" })

    map("n", "[h", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "Prev diff/hunk" })

    -- Actions
    map({ "n", "v" }, "<Space>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
    map({ "n", "v" }, "<Space>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
    map("n", "<Space>hS", gs.stage_buffer, { desc = "Stage Buffer" })
    map("n", "<Space>hu", gs.undo_stage_hunk, { desc = "Undo Stage Buffer" })
    map("n", "<Space>hR", gs.reset_buffer, { desc = "Reset Buffer" })
    map("n", "<Space>hp", gs.preview_hunk, { desc = "Preview Hunk" })
    map("n", "<Space>hb", function()
      gs.blame_line { full = true }
    end, { desc = "Blame Line" })
    map("n", "<Space>tb", gs.toggle_current_line_blame, { desc = "Toggle Current Line Blame" })
    map("n", "<Space>hd", gs.diffthis, { desc = "Diff This" })
    map("n", "<Space>hD", function()
      gs.diffthis "~"
    end, { desc = "Diff This ~" })
    map("n", "<Space>td", gs.toggle_deleted, { desc = "Toggle `Show Deleted`" })

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Hunk" })
  end,
}
-- }}}
