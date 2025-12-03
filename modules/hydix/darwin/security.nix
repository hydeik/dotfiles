{ inputs, ... }:
{
  hydix.darwin.darwin =
    { pkgs, ... }:
    {
      environment.systemPackages = with inputs.darwin.packages.${pkgs.stdenv.hostPlatform.system}; [
        pam-reattach
      ];

      security.pam.services.sudo_local.touchIdAuth = true;
    };
}
