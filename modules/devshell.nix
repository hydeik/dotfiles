{
  perSystem =
    { pkgs, ... }:
    {
      devshells.default = {
        commands = [
          {
            package = "neovim";
          }
        ];
        devshell.packages = with pkgs; [
          bat
          biome
          deadnix
          just
          lua-language-server
          nixd
          nixfmt-rfc-style
          shellcheck
          shfmt
          statix
          stylua
          taplo
          yamlfmt
        ];
      };
    };
}
