local M = {}

function M.setup()
  vim.keymap.set("n", "<Space>b", "<Cmd>Ddu -name=buffer buffer<CR>", { silent = true })
  vim.keymap.set(
    "n",
    "<Space>f",
    "<Cmd>Ddu -name=files file_point file_old file_rec -ui-param-displaySourceName=short<CR>",
    { silent = true }
  )

  vim.keymap.set("n", "/", "<Cmd>Ddu -name=search line -ui-param-startFilter<CR>")
  vim.keymap.set("n", "*", "<Cmd>Ddu -name=search line -input=`expand('<cword>')` -ui-param-startFilter=v:false<CR>")
end

function M.config()
  vim.fn["ddu#custom#alias"]("source", "file_rg", "file_external")

  vim.fn["ddu#custom#patch_global"] {
    ui = "ff",
    sourceOptions = {
      _ = {
        ignoreCase = true,
        matchers = { "matcher_substring" },
      },
      file_old = {
        matchers = { "matcher_substring", "matcher_relative", "matcher_hidden" },
      },
      file_external = {
        matchers = { "matcher_substring", "matcher_hidden" },
      },
      file_rec = {
        matchers = { "matcher_substring", "matcher_hidden" },
      },
    },
    sourceParams = {
      file_external = {
        cmd = { "git", "ls-files", "-co", "--exclude-standard" },
      },
    },
    uiParams = {
      ff = {
        filterSplitDirection = "floating",
      },
    },
    kindOptions = {
      file = { defaultAction = "open" },
      word = { defaultAction = "append" },
      action = { defaultAction = "do" },
    },
  }

  -- vim.fn["ddu#custom#patch_local"]("files", {
  --   uiParams = {
  --     ff = { split = "floating" },
  --   },
  -- })
  vim.fn["ddu#custom#patch_global"] {
    sourceParams = {
      file_rg = {
        cmd = { "rg", "--files", "--glob", "!.git", "--color", "never", "--no-messages" },
        updataItems = 50000,
      },
      rg = {
        args = { "--ignore-case", "--column", "--no-heading", "--color", "never" },
      },
    },
  }

  vim.fn["ddu#custom#patch_global"] {
    filterParams = {
      matcher_substring = { highlightMatched = "Search" },
    },
  }
end

return M
