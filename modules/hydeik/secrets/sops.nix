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
          secrets.openrouter-api-key = { };
          templates = {
            "zshrc_secret" = {
              content = ''
                export OPENAI_API_KEY="${config.sops.placeholder.openai-api-key}"
                export OPENROUTER_API_KEY="${config.sops.placeholder.openrouter-api-key}"
              '';
              path = "${config.xdg.configHome}/zsh/.zshrc_secret";
            };
            "env_secret.nu" = {
              content = ''
                $env.OPENAI_API_KEY = "${config.sops.placeholder.openai-api-key}"
                $env.OPENROUTER_API_KEY="${config.sops.placeholder.openrouter-api-key}"
              '';
              path = "${config.xdg.configHome}/nushell/env_secret.nu";
            };
          };
        };

      };
  };
in
{
  inherit flake-file;
  inherit hydeik;
}
