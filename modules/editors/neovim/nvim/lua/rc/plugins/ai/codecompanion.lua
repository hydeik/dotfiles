return {
  -- CodeCompanion
  {
    "olimorris/codecompanion.nvim",
    opts = {
      adapters = {
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            opts = {
              stream = true,
            },
            env = {
              api_key = "cmd:op read op://personal/OpenAI_API/credential --no-newline",
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
      strategies = {},
    },
  },
}
