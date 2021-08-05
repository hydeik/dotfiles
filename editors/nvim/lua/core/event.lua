-- ~/.config/nvim/lua/core/event.lua
local M = {
  _funcs = {},
  name = (function()
    local file = debug.getinfo(1, "S").source
    return file:match "/(%a+)%.lua$"
  end)(),
}

function M.create_augroups(groups)
  vim.validate { groups = { groups, "table" } }
  for name, definitions in pairs(groups) do
    vim.validate {
      name = { name, "string" },
      definitions = { definitions, "table" },
    }
    local cmds = {}
    for _, def in ipairs(definitions) do
      vim.validate {
        def = {
          def,
          function()
            return type(def) == "table" and vim.tbl_count(def) == 3
          end,
          "each definition should contain 3 values",
        },
      }
      local events, patterns, cmd_or_func = def[1], def[2], def[3]
      local command
      if type(cmd_or_func) == "string" then
        command = cmd_or_func
      else
        table.insert(M._funcs, cmd_or_func)
        command = ([[lua require'core.%s'._funcs[%d]()]]):format(M.name, #M._funcs)
      end
      table.insert(cmds, string.format("autocmd %s %s %s", events, patterns, command))
    end

    vim.cmd("augroup " .. name)
    vim.cmd "autocmd!"
    for _, command in ipairs(cmds) do
      vim.cmd(command)
    end
    vim.cmd "augroup END"
  end
end

function M.load_autocmds()
  local definitions = {
    user_event_packer = {
      { "BufWritePost", "*.lua", "lua require'plugins'.auto_compile()" },
    },
    user_event_bufs = {
      { "BufWritePre", "/tmp/*", "setlocal noundofile" },
      { "BufWritePre", "*.tmp", "setlocal noundofile" },
      { "BufWritePre", "*.bak", "setlocal noundofile" },
      { "BufWritePre", "COMMIT_EDITMSG", "setlocal noundofile" },
      { "BufWritePre", "MERGE_MSG", "setlocal noundofile" },
    },
    user_event_wins = {
      { "VimLeave", "*", "wshada!" },
      { "FocusGained", "*", "checktime" },
    },
    user_event_yank = {
      {
        "TextYankPost",
        "*",
        [[silent! lua vim.highlight.on_yank({highlight = "IncSearch", timeout = 400})]],
      },
    },
  }
  M.create_augroups(definitions)
end

return M
