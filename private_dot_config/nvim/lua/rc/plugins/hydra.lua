-- Create custom submodes and menus
local M = {
  "anuvyklack/hydra.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "mrjones2014/smart-splits.nvim",
    "sindrets/winshift.nvim",
  },
  keys = {
    { "z", mode = "n" },
    { "<C-w>", mode = "n" },
    { "<Space>o", mode = { "n", "x" } },
    { "<Space>g", mode = { "n", "x" } },
  },
}

M.hydra_git = function()
  local Hydra = require "hydra"
  local gitsigns = require "gitsigns"

  local hint = [[
 _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full
 ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
 ^
 ^ ^              _<Enter>_: Neogit              _q_: exit
]]

  Hydra {
    name = "Git",
    hint = hint,
    config = {
      buffer = bufnr,
      color = "pink",
      invoke_on_body = true,
      hint = {
        border = "rounded",
      },
      on_enter = function()
        vim.cmd "mkview"
        vim.cmd "silent! %foldopen!"
        vim.bo.modifiable = false
        gitsigns.toggle_signs(true)
        gitsigns.toggle_linehl(true)
      end,
      on_exit = function()
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        vim.cmd "loadview"
        vim.api.nvim_win_set_cursor(0, cursor_pos)
        vim.cmd "normal zv"
        gitsigns.toggle_signs(false)
        gitsigns.toggle_linehl(false)
        gitsigns.toggle_deleted(false)
      end,
    },
    mode = { "n", "x" },
    body = "<Space>g",
    heads = {
      {
        "J",
        function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gitsigns.next_hunk()
          end)
          return "<Ignore>"
        end,
        { expr = true, desc = "next hunk" },
      },
      {
        "K",
        function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gitsigns.prev_hunk()
          end)
          return "<Ignore>"
        end,
        { expr = true, desc = "prev hunk" },
      },
      { "s", ":Gitsigns stage_hunk<CR>", { silent = true, desc = "stage hunk" } },
      { "u", gitsigns.undo_stage_hunk, { desc = "undo last stage" } },
      { "S", gitsigns.stage_buffer, { desc = "stage buffer" } },
      { "p", gitsigns.preview_hunk, { desc = "preview hunk" } },
      { "d", gitsigns.toggle_deleted, { nowait = true, desc = "toggle deleted" } },
      { "b", gitsigns.blame_line, { desc = "blame" } },
      {
        "B",
        function()
          gitsigns.blame_line { full = true }
        end,
        { desc = "blame show full" },
      },
      { "/", gitsigns.show, { exit = true, desc = "show base file" } }, -- show the base of the file
      { "<Enter>", "<Cmd>Neogit<CR>", { exit = true, desc = "Neogit" } },
      { "q", nil, { exit = true, nowait = true, desc = "exit" } },
    },
  }
end

-- Simple hydra to scroll screen to the side with auto generated hint.
M.hydra_side_scroll = function()
  local Hydra = require "hydra"
  Hydra {
    name = "Side scroll",
    redmode = "n",
    body = "z",
    heads = {
      { "h", "5zh" },
      { "l", "5zl", { desc = "←/→" } },
      { "H", "zH" },
      { "L", "zL", { desc = "half screen ←/→" } },
    },
  }
end

-- Frequetly used vim options
M.hydra_vim_options = function()
  local Hydra = require "hydra"

  local hint = [[
  ^ ^        Options
  ^
  _v_ %{ve} virtual edit
  _i_ %{list} invisible characters
  _s_ %{spell} spell
  _w_ %{wrap} wrap
  _c_ %{cuc} cursor column
  _l_ %{cul} cursor line
  _n_ %{nu} number
  _r_ %{rnu} relative number
  ^
       ^^^^                _<Esc>_
]]

  Hydra {
    name = "Options",
    hint = hint,
    config = {
      color = "amaranth",
      invoke_on_body = true,
      hint = {
        border = "rounded",
        position = "middle",
      },
    },
    mode = { "n", "x" },
    body = "<Space>o",
    heads = {
      {
        "n",
        function()
          vim.o.number = not vim.o.number
        end,
        { desc = "number" },
      },
      {
        "r",
        function()
          if vim.o.relativenumber == true then
            vim.o.relativenumber = false
          else
            vim.o.number = true
            vim.o.relativenumber = true
          end
        end,
        { desc = "relativenumber" },
      },
      {
        "v",
        function()
          if vim.o.virtualedit == "all" then
            vim.o.virtualedit = "block"
          else
            vim.o.virtualedit = "all"
          end
        end,
        { desc = "virtualedit" },
      },
      {
        "i",
        function()
          vim.o.list = not vim.o.list
        end,
        { desc = "show invisible" },
      },
      {
        "s",
        function()
          vim.o.spell = not vim.o.spell
        end,
        { exit = true, desc = "spell" },
      },
      {
        "w",
        function()
          if vim.o.wrap ~= true then
            vim.o.wrap = true
            -- Dealing with word wrap:
            -- If cursor is inside very long line in the file than wraps
            -- around several rows on the screen, then 'j' key moves you to
            -- the next line in the file, but not to the next row on the
            -- screen under your previous position as in other editors. These
            -- bindings fixes this.
            vim.keymap.set("n", "k", function()
              return vim.v.count > 0 and "k" or "gk"
            end, { expr = true, desc = "k or gk" })
            vim.keymap.set("n", "j", function()
              return vim.v.count > 0 and "j" or "gj"
            end, { expr = true, desc = "j or gj" })
          else
            vim.o.wrap = false
            vim.keymap.del("n", "k")
            vim.keymap.del("n", "j")
          end
        end,
        { desc = "wrap" },
      },
      {
        "c",
        function()
          vim.o.cursorcolumn = not vim.o.cursorcolumn
        end,
        { desc = "cursor column" },
      },
      {
        "l",
        function()
          vim.o.cursorline = not vim.o.cursorline
        end,
        { desc = "cursor line" },
      },
      { "<Esc>", nil, { exit = true } },
    },
  }
end

-- Hydra for the window management
M.hydra_windows = function()
  local window_hint = [[
 ^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
 ^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
 ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<C-k>_   ^   _s_: horizontally
 _h_ ^ ^ _l_  _H_ ^ ^ _L_   _<C-h>_ _<C-l>_   _v_: vertically
 ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<C-j>_   ^   _q_, _c_: close
 focus^^^^^^  window^^^^^^  ^_=_: equalize^   _z_: maximize
 ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^^ ^          ^   _o_: remain only
]]

  local Hydra = require "hydra"
  local splits = require "smart-splits"
  local cmd = require("hydra.keymap-util").cmd
  local pcmd = require("hydra.keymap-util").pcmd
  Hydra {
    name = "Windows",
    hint = window_hint,
    config = {
      invoke_on_body = true,
      hint = {
        border = "rounded",
        offset = -1,
      },
    },
    mode = "n",
    body = "<C-w>",
    heads = {
      { "h", "<C-w>h" },
      { "j", "<C-w>j" },
      { "k", pcmd("wincmd k", "E11", "close") },
      { "l", "<C-w>l" },

      { "H", cmd "WinShift left" },
      { "J", cmd "WinShift down" },
      { "K", cmd "WinShift up" },
      { "L", cmd "WinShift right" },

      {
        "<C-h>",
        function()
          splits.resize_left(2)
        end,
      },
      {
        "<C-j>",
        function()
          splits.resize_down(2)
        end,
      },
      {
        "<C-k>",
        function()
          splits.resize_up(2)
        end,
      },
      {
        "<C-l>",
        function()
          splits.resize_right(2)
        end,
      },
      { "=", "<C-w>=", { desc = "equalize" } },

      { "s", pcmd("split", "E36") },
      { "<C-s>", pcmd("split", "E36"), { desc = false } },
      { "v", pcmd("vsplit", "E36") },
      { "<C-v>", pcmd("vsplit", "E36"), { desc = false } },

      { "w", "<C-w>w", { exit = true, desc = false } },
      { "<C-w>", "<C-w>w", { exit = true, desc = false } },

      { "z", cmd "WindowsMaximaze", { exit = true, desc = "maximize" } },
      { "<C-z>", cmd "WindowsMaximaze", { exit = true, desc = false } },

      { "o", "<C-w>o", { exit = true, desc = "remain only" } },
      { "<C-o>", "<C-w>o", { exit = true, desc = false } },

      -- { "b", choose_buffer, { exit = true, desc = "choose buffer" } },

      { "c", pcmd("close", "E444") },
      { "q", pcmd("close", "E444"), { desc = "close window" } },
      { "<C-c>", pcmd("close", "E444"), { desc = false } },
      { "<C-q>", pcmd("close", "E444"), { desc = false } },

      { "<Esc>", nil, { exit = true, desc = false } },
    },
  }
end

M.config = function()
  -- add hydra
  M.hydra_git()
  M.hydra_side_scroll()
  M.hydra_vim_options()
  M.hydra_windows()
end

return M
