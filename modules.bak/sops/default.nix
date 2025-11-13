{ inputs, ... }:
{
  flake.modules = {
    homeManager.base =
      { config, ... }:
      {
        imports = [
          inputs.sops-nix.homeManagerModules.sops
        ];
        sops = {
          age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
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

    # darwin.desktop = {
    #   home-manager = {
    #     sharedModules = [
    #       inputs.sops-nix.homeManagerModules.sops
    #     ];
    #   };
    # };
  };
}
