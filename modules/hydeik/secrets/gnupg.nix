{
  hydeik.secrets = {
    homeManager =
      { config, pkgs, ... }:
      {
        home.packages = [
          pkgs.gnupg
        ];

        home.sessionVariables = {
          GNUPGHOME = "${config.xdg.dataHome}/gnupg";
        };
      };
  };
}
