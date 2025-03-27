{ lib, ... }:
{
  flake.modules.homeManager.base =
    { config, pkgs, ... }:
    {
      home.packages = lib.attrValues {
        inherit (pkgs.luajitPackages) luarocks;

        inherit (pkgs)
          # neovim body
          neovim

          # Dependency
          sqlite

          # Language servers
          bash-language-server
          clang-tools
          cmake-language-server
          deno # builtin server/formatter
          efm-langserver
          fortls
          lua-language-server
          marksman
          nixd
          ruff # builtin server/formatter
          taplo
          texlab
          typescript-language-server
          vscode-langservers-extracted
          vtsls
          yaml-language-server

          # Linters
          cmake-lint
          markdownlint-cli2
          shellcheck
          statix
          vim-vint

          # Formatters
          beautysh
          biome
          cmake-format
          eslint_d
          github-markdown-toc-go
          nixfmt-rfc-style
          prettierd
          shfmt
          sql-formatter
          stylua
          ;
      };
      xdg.configFile.nvim = {
        recursive = true;
        source = ./nvim;
        onChange = ''
          # Clear Lua cache
          rm -rf ${config.xdg.cacheHome}/nvim/luac/
        '';
      };
    };
}
