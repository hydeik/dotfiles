local M = {}
local event = require "core.event"

function M.on_filetype()
  local s = vim.cmd [[filetype]]
  if s:find "OFF" ~= nil then
    vim.cmd [[
      silent! filetype plugin indent on
      syntax enable
      filetype detect
    ]]
  end
end

function M.setup()
  --- Global options for filetypes
  -- Bash
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

  --- Register filetype events
  event.create_augroups {
    user_ftplugin = {
      { "FileType", "*", "lua require'core.ftplugin'.ftplugin_common()" },
      { "FileType", "c, cpp", "lua require'core.ftplugin'.ftplugin_c_cpp()" },
      { "FileType", "fortran", "lua require'core.ftplugin'.ftplugin_fortran()" },
      { "FileType", "help", "lua require'core.ftplugin'.ftplugin_help()" },
      { "FileType", "ruby", "lua require'core.ftplugin'.ftplugin_ruby()" },
      { "FileType", "toml", "lua require'core.ftplugin'.ftplugin_toml()" },
      { "FileType", "vim", "lua require'core.ftplugin'.ftplugin_vim()" },
    },
  }
end

--- ftplugin
-- common
function M.ftplugin_common()
  vim.bo.formatoptions = "jtcqmMBl"

  if not vim.bo.modifiable then
    vim.wo.foldenable = false
    vim.wo.foldcolumn = "0"
    vim.wo.colorcolumn = ""
  end
end

-- C/C++
function M.ftplugin_c_cpp()
  vim.bo.foldignore = "#/"
end

-- Fortran
function M.ftplugin_fortran()
  local ext = vim.fn.expand "%:e"
  -- fixed or free format
  if ext == "f" or ext == "for" then
    vim.b.fortran_free_source = 0
    vim.b.fortran_fixed_source = 1
  else
    vim.b.fortran_free_source = 1
    vim.b.fortran_fixed_source = 0
  end
  -- Folding
  vim.b.fortran_fold = 1
  vim.b.fortran_fold_conditionals = 1
  vim.b.fortran_fold_multilinecomments = 1
  -- Indent do-enddo block
  vim.b.fortran_do_enddo = 1
end

-- Ruby
function M.ftplugin_ruby()
  vim.bo.iskeyword = vim.bo.iskeyword .. ",!,?"
end

-- TOML
function M.ftplugin_toml()
  vim.cmd "syntax sync minlines=500"
end

-- VIM
function M.ftplugin_vim()
  if vim.fn.line "$" > 5000 then
    vim.cmd "syntax sync minlines=500"
  end
  vim.wo.foldmethod = "indent"
end

-- VIM help
function M.ftplugin_help()
  vim.bo.iskeyword = vim.bo.iskeyword .. ",:,#,-"
end

return M
