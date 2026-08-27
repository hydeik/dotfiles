---@class rc.utils.lsp
local M = {}

M.action = setmetatable({}, {
  __index = function(_, action)
    return function()
      vim.lsp.buf.code_action {
        apply = true,
        context = {
          only = { action },
          diagnostics = {},
        },
      }
    end
  end,
})

---@class LspCommand: lsp.ExecuteCommandParams
---@field open? boolean
---@field handler? lsp.Handler

---@param opts LspCommand
function M.execute(opts)
  local params = {
    command = opts.command,
    arguments = opts.arguments,
  }
  if opts.open then
    require("trouble").open {
      mode = "lsp_command",
      params = params,
    }
  else
    return vim.lsp.buf_request(0, "workspace/executeCommand", params, opts.handler)
  end
end

return M
