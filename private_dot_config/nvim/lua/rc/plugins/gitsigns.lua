local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
}

M.config = function()
  require("gitsigns").setup {
    signs = {
      add = {
        hl = "GitSignsAdd",
        text = "▍",
        numhl = "GitSignsAddNr",
        linehl = "GitSignsAddLn",
      },
      change = {
        hl = "GitSignsChange",
        text = "▍",
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
      delete = {
        hl = "GitSignsDelete",
        text = "▸",
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      topdelete = {
        hl = "GitSignsDelete",
        text = "▾",
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      changedelete = {
        hl = "GitSignsChange",
        text = "▍",
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
      untracked = {
        hl = "GitSignsAdd",
        text = "▍",
        numhl = "GitSignsAddNr",
        linehl = "GitSignsAddLn",
      },
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
      map("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true, desc = "Next diff/hunk" })

      map("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true, desc = "Prev diff/hunk" })

      -- Actions
      map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
      map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
      map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
      map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo Stage Buffer" })
      map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
      map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
      map("n", "<leader>hb", function()
        gs.blame_line { full = true }
      end, { desc = "Blame Line" })
      map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle Current Line Blame" })
      map("n", "<leader>hd", gs.diffthis, { desc = "Diff This" })
      map("n", "<leader>hD", function()
        gs.diffthis "~"
      end, { desc = "Diff This ~" })
      map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle `Show Deleted`" })

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Hunk" })
    end,
  }
end

return M
