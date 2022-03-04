-- ~/.config/nvim/rc/user/builtins.lua
-- [[ Configure NeoVim builtin plugins ]]

local path = require "rc.core.path"

-- Disable some builtin plugins. {{{1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_man = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.netrw_nogx = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
-- }}}1

-- [[ filetype, syntax, indent ]] {{{1
-- Use $VIMRUNTIME/filetype.lua for file type detection
vim.g.do_filetype_lua = 1
-- Disable $VIMRUNTIME/{filetype,indent,ftplugin}.vim
vim.g.did_load_filetypes = 0
vim.g.did_indent_on = 1
vim.g.did_load_ftplugin = 1
--- }}}1

--- [[ Providers ]] {{{1
-- python3 interpretor
vim.g.python3_host_prog = path.join(path.home, ".asdf", "shims", "python3")
-- Disable Nodejs / python2 / ruby / perl providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
--- }}}1

--- [[ Global variables to customize behaviours of builtin filetype-plugins ]] {{{1
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

--- }}}1
