return {
  "mfussenegger/nvim-lint",
  dependencies = {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "shellcheck",
        "vale",
        "vint",
      },
    },
  },
  events = { "BufReadPost", "BufNewFile", "BufWritePre" },
  config = function()
    require("lint").linter_by_ft {
      markdown = { "vale" },
      sh = { "shellcheck" },
      vim = { "vint" },
    }

    local group = vim.api.nvim_create_augroup("NvimLintConfig", {})
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      group = group,
      callback = function()
        require("lint").try_lint()
      end,
      desc = "Linting buffer",
    })
  end,
}
