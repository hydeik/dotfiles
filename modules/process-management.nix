{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        bottom
        lsof
        procs
        watchexec
      ];
      programs = {
        # bottom = {
        #   enable = true;
        #   settings = {
        #     rate = 500;
        #   };
        # };
        btop = {
          enable = true;
          settings = {
            vim_keys = true;
          };
        };
      };
    };
}
