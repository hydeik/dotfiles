return {
  -- CodeCompanion
  {
    "olimorris/codecompanion.nvim",
    keys = {
      { "<Space>a", "", desc = "+ai", mode = { "n", "v" } },
      { "<Space>aa", "<cmd>CodeCompanionChat Toggle<CR>", desc = "Toggle (CodeCompanion)", mode = { "n", "v" } },
      { "<Space>aA", "<cmd>CodeCompanionActions<CR>", desc = "Action Palette (CodeCompanion)", mode = { "n", "v" } },
      { "<Space>ac", "<cmd>CodeCompanionChat Add<CR>", desc = "Add Selection to Chat", mode = { "v" } },
      { "ga", "<cmd>CodeCompanionChat Add<CR>", desc = "Add Selection to Chat", mode = { "v" } },
    },
    opts = {
      adapters = {
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            opts = {
              stream = true,
            },
            env = {
              api_key = vim.env.OPENAI_API_KEY,
            },
            schema = {
              model = {
                default = function()
                  return "gpt-4o"
                end,
              },
            },
          })
        end,
      },
      strategies = {
        chat = { adapter = "copilot" },
        inline = { adapter = "copilot" },
        cmd = { adapter = "copilot" },
      },
    },
  },
}
