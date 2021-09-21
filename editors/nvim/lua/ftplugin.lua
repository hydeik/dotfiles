local M = {}

--- Global options for filetypes
-- Bash
function M.setup()
  vim.g.is_bash = 1
  vim.g.sh_fold_enabled = 1

  -- C++
  vim.g.cpp_class_scope_highlight = 1

  -- Markdown
  vim.g.markdown_fenced_languages = {
    "css",
    "javascript",
    "js=javascript",
    "json=javascript",
    "python",
    "py=python",
    "rust",
    "sh",
    "sass",
    "xml",
    "vim",
    "help",
  }

  -- Perl
  vim.g.perl_fold = 1
  vim.g.perl_blocks = 1

  -- php
  vim.g.php_folding = 1

  -- Python
  vim.g.python_highlight_all = 1

  -- Ruby
  vim.g.ruby_fold = 1

  -- TeX
  vim.g.tex_stylish = 1
  vim.g.tex_conceal = ""
  vim.g.tex_flavor = "latex"
  vim.g.tex_isk = "48-57,a-z,A-Z,192-255,:"
  vim.g.tex_fold_enabled = 1

  -- Vim
  vim.g.vimsyn_embed = "l"

  -- XML
  vim.g.xml_syntax_folding = 1

  --- Override $VIMRUNTIME/ftplugin.vim
  if vim.g.did_load_ftplugin ~= nil then
    return
  end
  vim.g.did_load_ftplugin = true
end

function M.ftplugin_post_hook()
  -- A hook after filetypeplugin events
  vim.opt_local.formatoptions:remove {
    "r", -- Don't insert a comment leader after hitting <Enter>.
    "o", -- Don't insert a comment leader after hitting 'o' or 'O'.
    "a", -- Disable auto-format
  }
  vim.opt_local.formatoptions:append {
    "c", -- Auto-wrap comments using text width.
    "q", -- Allow formatting of comments with "gq".
    "n", -- Recognize numbered list when formatting text.
    "l", -- Long lines are not broked in insert mode.
    "m", -- Also break at a multibyte character above 255.
    "M", -- Don't insert a space before or after a mutibyte character.
    "j", -- Where it make sence, remove a comment leader when joining lines.
  }

  if not vim.bo.modifiable then
    vim.wo.foldenable = false
    vim.wo.foldcolumn = "0"
    vim.wo.colorcolumn = ""
  end
end

return M

-- local au = require "utils.autocmd"
-- au.group("filetypeplugin", {
--   {
--     "FileType",
--     "*",
--     function()
--       if vim.b.undo_ftplugin ~= nil then
--         vim.cmd [[execute b:undo_ftplugin]]
--         vim.b.undo_ftplugin = nil
--         vim.b.did_ftplugin = nil
--       end

--       local s = vim.fn.expand "<amatch>"
--       if s ~= "" then
--         local cpo = vim.api.nvim_get_option "cpoptions"
--         if string.match(cpo, "S") ~= nil and vim.b.did_ftplugin ~= nil then
--           vim.b.did_ftplugin = nil
--         end
--         for name in vim.gsplit(s, "%.") do
--           local cmd_vim = string.format(
--             "runtime! ftplugin/%s.vim ftplugin/%s_*.vim ftplugin/%s/*.vim",
--             name,
--             name,
--             name
--           )
--           local cmd_lua = string.format(
--             "runtime! ftplugin/%s.lua ftplugin/%s_*.lua ftplugin/%s/*.lua",
--             name,
--             name,
--             name
--           )
--           vim.cmd(cmd_vim)
--           vim.cmd(cmd_lua)
--         end
--       end

--       -- A hook after filetypeplugin events
--       vim.opt_local.formatoptions:remove {
--         "r", -- Don't insert a comment leader after hitting <Enter>.
--         "o", -- Don't insert a comment leader after hitting 'o' or 'O'.
--         "a", -- Disable auto-format
--       }
--       vim.opt_local.formatoptions:append {
--         "c", -- Auto-wrap comments using text width.
--         "q", -- Allow formatting of comments with "gq".
--         "n", -- Recognize numbered list when formatting text.
--         "l", -- Long lines are not broked in insert mode.
--         "m", -- Also break at a multibyte character above 255.
--         "M", -- Don't insert a space before or after a mutibyte character.
--         "j", -- Where it make sence, remove a comment leader when joining lines.
--       }

--       if not vim.bo.modifiable then
--         vim.wo.foldenable = false
--         vim.wo.foldcolumn = "0"
--         vim.wo.colorcolumn = ""
--       end
--     end,
--   },
-- })
