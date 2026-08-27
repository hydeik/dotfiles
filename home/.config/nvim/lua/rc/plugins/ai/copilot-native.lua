-- local status = {} ---@type table<number, "ok" | "error" | "pending">

-- Native inline compiletion don't support being shown as regular completion
vim.g.vimrc_use_ai_cmp = false

return {
  -- copilot-language-server
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        copilot = {
          keys = {
            {
              "<M-]>",
              function()
                vim.lsp.inline_completion.select { count = 1 }
              end,
              desc = "Next Copilot Suggestion",
              mode = { "n", "i" },
            },
            {
              "<M-[>",
              function()
                vim.lsp.inline_completion.select { count = -1 }
              end,
              desc = "Prev Copilot Suggestion",
              mode = { "n", "i" },
            },
          },
        },
        setup = {
          copilot = function()
            vim.schedule(function()
              vim.lsp.inline_completion.enable()
            end)
            -- Accept inline suggestion or next edits
            require("rc.utils.cmp").ai_accept = function()
              vim.lsp.inline_completion.get()
            end

            -- vim.lsp.config("copilot", {
            --   didChangeStatus = function(err, res, ctx)
            --     if err then
            --       return
            --     end
            --     status[ctx.client_id] = res.kind ~= "Normal" and "error" or res.busy and "pending" or "ok"
            --     if res.status == "Error" then
            --       require("rc.utils").error "Please use `:LspCopilotSignIn` to sign in to Copilot"
            --     end
            --   end,
            -- })
          end,
        },
      },
    },
  },
}
