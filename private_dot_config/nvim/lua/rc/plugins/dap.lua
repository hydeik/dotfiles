-- Debug Adapter Protocol client implementation for Neovim
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },
    keys = {
      { "<Space>d", "", desc = "+debug", mode = { "n", "v" } },
      {
        "<Space>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
        end,
        desc = "Breakpoint Condition",
      },
      {
        "<Space>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<Space>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<Space>dC",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to Cursor",
      },
      {
        "<Space>dg",
        function()
          require("dap").goto_()
        end,
        desc = "Go to line (no execute)",
      },
      {
        "<Space>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<Space>dj",
        function()
          require("dap").down()
        end,
        desc = "Down",
      },
      {
        "<Space>dk",
        function()
          require("dap").up()
        end,
        desc = "Up",
      },
      {
        "<Space>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run Last",
      },
      {
        "<Space>do",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<Space>dO",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<Space>dp",
        function()
          require("dap").pause()
        end,
        desc = "Pause",
      },
      {
        "<Space>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Toggle REPL",
      },
      {
        "<Space>ds",
        function()
          require("dap").session()
        end,
        desc = "Session",
      },
      {
        "<Space>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<Space>dw",
        function()
          require("dap.ui.widgets").hover()
        end,
        desc = "Widgets",
      },
    },
    config = function()
      local mdap = require("lazy.core.config").spec.plugins["mason-nvim-dap.nvim"]
      local mdap_opts = require("lazy.core.plugin").values(mdap, "opts", false)
      require("mason-nvim-dap").setup(mdap_opts)

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(require("rc.core.config").icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end
    end,
  },
  -- A UI for nvim-dap
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    keys = {
      {
        "<Space>du",
        function()
          require("dapui").toggle {}
        end,
        desc = "Toggle UI",
      },
      {
        "<Space>de",
        function()
          require("dapui").eval()
        end,
        desc = "Eval",
        mode = { "n", "v" },
      },
    },
    opts = {},
    config = function(_, opts)
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open {}
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close {}
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close {}
      end
    end,
  },
  -- mason.nvim integration
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
      },
    },
    -- mason-nvim-dap is loaded when nvim-dap loads
    config = function() end,
  },
}
