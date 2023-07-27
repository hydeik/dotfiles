return {
  -- Terminal Manager for Neovim
  "rebelot/terminal.nvim",
  cmd = { "TermOpen", "TermToggle", "TermRun", "Lazygit", "IPython", "Htop" }, 
  event = "TermOpen",
  keys =  "<Space>t",
  opts = {
    autoclose = true,
  },
  config = function(_, opts)
    require("terminal").setup(opts)
    local term_map = require("terminal.mappings")
    vim.keymap.set({ "n", "x" }, "<leader>ts", term_map.operator_send, { expr = true, desc = "Send text captured by motion to a terminal" })
    vim.keymap.set("n", "<leader>to", term_map.toggle, { desc = "Toggle terminal" } )
    vim.keymap.set("n", "<leader>tO", term_map.toggle({ open_cmd = "enew" }), { desc = "Toggle terminal (new buffer)" })
    vim.keymap.set("n", "<leader>tr", term_map.run, { desc = "Run a job in terminal" })
    vim.keymap.set("n", "<leader>tR", term_map.run(nil, { layout = { open_cmd = "enew" } }), { desc = "Run a job in terminal (new buffer)" })
    vim.keymap.set("n", "<leader>tk", term_map.kill, { desc = "Kill terminal" })
    vim.keymap.set("n", "<leader>t]", term_map.cycle_next, { desc = "Cycle next terminal" })
    vim.keymap.set("n", "<leader>t[", term_map.cycle_prev, { desc = "Cycle prev terminal" })
    vim.keymap.set("n", "<leader>tl", term_map.move({ open_cmd = "belowright vnew" }), { desc = "Move terminal (belowright vnew)" })
    vim.keymap.set("n", "<leader>tL", term_map.move({ open_cmd = "botright vnew" }), { desc = "Move terminal (botright vnew)" })
    vim.keymap.set("n", "<leader>th", term_map.move({ open_cmd = "belowright new" }), { desc = "Move terminal (belowright new)" })
    vim.keymap.set("n", "<leader>tH", term_map.move({ open_cmd = "botright new" }), { desc = "Move terminal (belowright new)" })
    vim.keymap.set("n", "<leader>tf", term_map.move({ open_cmd = "float" }), { desc = "Move terminal (float)" })
  end,
}
