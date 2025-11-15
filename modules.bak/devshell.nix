{
  perSystem =
    { pkgs, ... }:
    {
      devshells.default = {
        commands = [
          {
            package = "vim";
          }
        ];
        devshell.packages = with pkgs; [
          age
          bat
          biome
          deadnix
          gnupg
          lua-language-server
          nixd
          nixfmt-rfc-style
          ripgrep
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
