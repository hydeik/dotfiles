{ inputs, ... }:
let
  hydeik.direnv.homeManager = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    xdg.configFile = {
      "direnv/lib/use_nix_installables.sh".text = use_nix_installables;
      "direnv/lib/use_hydeik_go.sh".text = use_hydeik_go;
    };
  };

  # Allows quickly setup an environment with the provided nix-installables (outputs from flake).
  # See https://github.com/direnv/direnv/pull/1420
  use_nix_installables = ''
    use_nix_installables() {
      direnv_load nix shell "''${@}" -c $direnv dump
    }
  '';

  use_hydeik_go = ''
    use_hydeik_go() {
      use nix_installables ${inputs.nixpkgs}#go ${inputs.nixpkgs}#gopls
    }
  '';
in
{
  inherit hydeik;
}
