{ inputs, ... }:
{
  hydix.darwin.darwin =
    { pkgs, ... }:
    {
      environment.systemPackages = with inputs.darwin.packages.${pkgs.stdenv.hostPlatform.system}; [
        darwin-option
        darwin-rebuild
        darwin-version
        darwin-uninstaller
      ];
    };
}
