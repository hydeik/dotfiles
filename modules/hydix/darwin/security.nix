{
  hydix.darwin.darwin =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.pam-reattach
      ];

      security.pam.services.sudo_local = {
        enable = true;
        reattach = true;
        touchIdAuth = true;
      };
    };
}
