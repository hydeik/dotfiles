local M = {}

function M.setup()
  -- key bindings
  vim.keymap.set("n", "<Space>fb", "<Cmd>Ddu -name=buffer buffer<CR>", { silent = true })
  vim.keymap.set(
    "n",
    "<Space>ff",
    "<Cmd>Ddu -name=files file_point file_old file_rec -ui-param-displaySourceName=short<CR>",
    { silent = true }
  )
  vim.keymap.set("n", "/", "<Cmd>Ddu -name=search line -ui-param-startFilter<CR>")
  vim.keymap.set("n", "*", "<Cmd>Ddu -name=search line -input=`expand('<cword>')` -ui-param-startFilter=v:false<CR>")

  -- ftplugin for ddu buffers
  vim.api.nvim_create_autocmd("FileType", {
    group = "MyAutoCmd",
    pattern = "ddu-ff",
    callback = function()
      require("rc.config.ddu").ftplugin_ddu_ff()
    end,
    desc = "Set key mappings in ddu-ff buffers",
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = "MyAutoCmd",
    pattern = "ddu-ff-filter",
    callback = function()
      require("rc.config.ddu").ftplugin_ddu_ff_filter()
    end,
    desc = "Set key mappings in ddu-ff-filter buffers",
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = "MyAutoCmd",
    pattern = "ddu-filter",
    callback = function()
      require("rc.config.ddu").ftplugin_ddu_filer()
    end,
    desc = "Set key mappings in ddu-filer buffers",
  })
end

function M.config()
  vim.fn["ddu#custom#alias"]("source", "file_rg", "file_external")

  vim.fn["ddu#custom#patch_global"] {
    ui = "ff",
    sourceOptions = {
      ["_"] = {
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
        split = "floating",
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

--- Settings in ddu-ff-filter buffer
function M.ftplugin_ddu_ff()
  local opts = { buffer = true }
  vim.keymap.set("n", "<CR>", "<Cmd>call ddu#ui#ff#do_action('itemAction')<CR>", opts)
  vim.keymap.set("n", "<Space>", "<Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>", opts)
  vim.keymap.set("n", "<Tab>", "<Cmd>call ddu#ui#ff#do_action('chooseAction')<CR>", opts)
  vim.keymap.set("n", "<C-l>", "<Cmd>call ddu#ui#ff#do_action('refreshItems')<CR>", opts)
  vim.keymap.set("n", "i", "<Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>", opts)
  vim.keymap.set("n", "p", "<Cmd>call ddu#ui#ff#do_action('preview')<CR>", opts)
  vim.keymap.set("n", "q", "<Cmd>call ddu#ui#ff#do_action('quit')<CR>", opts)
  vim.keymap.set("n", "c", "<Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'cd'})<CR>", opts)
  vim.keymap.set("n", "d", "<Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'delete'})<CR>", opts)
  vim.keymap.set("n", "e", "<Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'edit'})<CR>", opts)
  vim.keymap.set("n", "E", "<Cmd>call ddu#ui#ff#do_action('itemAction', {'params': eval(input('params: '))})<CR>", opts)
  vim.keymap.set(
    "n",
    "v",
    "<Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'open', 'params': {'command': 'vsplit'}})<CR>",
    opts
  )
  vim.keymap.set("n", "N", "<Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'new'})<CR>", opts)
  vim.keymap.set("n", "r", "<Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'quickfix'})<CR>", opts)
  vim.keymap.set(
    "n",
    "u",
    "<Cmd>call ddu#ui#ff#do_action('updateOptions', {'sourceOptions': {'_': {'matchers': []}}})<CR>",
    opts
  )
end

--- Settings in ddu-ff-filter buffer
function M.ftplugin_ddu_ff_filter()
  local opts = { silent = true, buffer = true }
  vim.keymap.set("i", "<CR>", "<Esc><Cmd>close<CR>", opts)
  vim.keymap.set("i", "jj", "<Esc><Cmd>close<CR>", opts)
  vim.keymap.set("n", "<CR>", "<Cmd>close<CR>", opts)
  vim.keymap.set("n", "q", "<Cmd>close<CR>", opts)
end

--- Settings in ddu-filer buffer
function M.ftplugin_ddu_filer()
  vim.keymap.set("n", "q", "<Cmd>call ddu#ui#filer#do_action('quit')<CR>", { buffer = true })
  vim.keymap.set("n", "<CR>", function()
    if vim.fn["ddu#ui#filer#is_directory"]() then
      vim.fn["ddu#ui#do_action"]("itemAction", { name = "narrow" })
    else
      vim.fn["ddu#ui#do_action"]("itemAction", { name = "open" })
    end
  end, { buffer = true, expr = true })
end

return M
