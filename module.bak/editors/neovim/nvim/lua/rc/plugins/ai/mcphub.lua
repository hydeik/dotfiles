return {
  {
    "ravitemer/mcphub.nvim",
    cmd = { "MCPHub" },
    build = "bundled_build.lua", -- using bundled binary
    opts = {
      use_bundled_binary = true,
      extensions = {
        codecompanion = {
          -- Show the mcp tool result in the chat buffer
          show_result_in_chat = true,
          -- Make chat #variables from MCP server resources
          make_vars = true,
          -- Create slash commands for prompts
          make_slash_commands = true,
        },
      },
    },
  },
  -- CodeCompanion config for mcphub.nvim
  {
    "olimorris/codecompanion.nvim",
    optional = true,
    opts = {
      strategies = {
        chat = {
          tools = {
            ["mcp"] = {
              -- Prevent mcphub from loading before needed
              callback = function()
                return require "mcphub.extensions.codecompanion"
              end,
              description = "Call tools and resources from the MCP Servers",
            },
          },
        },
      },
    },
  },
}
