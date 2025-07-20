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
          age
          bat
          biome
          deadnix
          gnupg
          just
          lua-language-server
          nixd
          nixfmt-rfc-style
          shellcheck
          shfmt
          sops
          ssh-to-age
          statix
          stylua
          taplo
          yamlfmt
        ];
      };
    };
}
