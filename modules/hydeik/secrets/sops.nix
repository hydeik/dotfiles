{ inputs, ... }:
let
  flake-file.inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  hydeik.secrets = {
    homeManager =
      { config, pkgs, ... }:
      {
        imports = [
          inputs.sops-nix.homeManagerModules.sops
        ];

        home.packages = [
          pkgs.sops
        ];

        sops = {
          age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
          age.sshKeyPaths = [ ];
          age.generateKey = false;
          defaultSopsFile = ./secrets.yaml;
          secrets.openai-api-key = { };
          templates."zshrc_secret" = {
            content = ''
              export OPENAI_API_KEY="${config.sops.placeholder.openai-api-key}"
            '';
            path = "${config.xdg.configHome}/zsh/.zshrc_secret";
          };
        };

      };
  };
in
{
  inherit flake-file;
  inherit hydeik;
}
