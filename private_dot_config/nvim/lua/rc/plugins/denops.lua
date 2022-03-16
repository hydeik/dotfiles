local M = {}

function M.cache_plugin(path)
  local plugin_denops_dir = path .. "/denops"
  if vim.fn.isdirectory(plugin_denops_dir) == 0 then
    return
  end
  local candidates = vim.fn.globpath(path, "denops/*/*.ts", true, true)
  local args = { "deno", "cache", "--no-check" }
  for _, c in ipairs(candidates) do
    table.insert(args, c)
  end
  vim.fn.system(args)
end

function M.register_plugin(name, path)
  local plugin_denops_dir = path .. "/denops"
  if vim.fn.isdirectory(plugin_denops_dir) == 0 then
    return
  end
  local candidates = vim.fn.globpath(path, "denops/*/main.ts", true, true)
  local to_load = {}
  for _, c in ipairs(candidates) do
    local denops_plugin = vim.fn.fnamemodify(c, ":h:t")
    local ok, is_loaded = pcall(vim.fn["denops#plugin#is_loaded"], denops_plugin)
    if not ok then
      local msg = string.format("%s needs denops.vim to be loaded beforehand.", name)
      vim.api.nvim_echo({ { msg, "WarningMsg" } }, true, {})
      return
    end
    if is_loaded == 0 then
      table.insert(to_load, denops_plugin)
    end
  end
  for _, denops_plugin in ipairs(to_load) do
    if vim.fn["denops#server#status"] == "running" then
      pcall(vim.fn["denops#plugin#register"], denops_plugin, { mode = "skip" })
    end
    vim.fn["denops#plugin#wait"](denops_plugin)
  end
end

return M
