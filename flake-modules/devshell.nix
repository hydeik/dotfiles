_:
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
        decshell.packages = with pkgs; [
          bat
          biome
          deadnix
          just
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
