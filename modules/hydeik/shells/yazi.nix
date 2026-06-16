{
  hydeik.shells.homeManager =
    { pkgs, ... }:
    {
      # home.packages = [ pkgs.yazi ];
      programs.yazi = {
        enable = true;
        enableBashIntegration = false;
        enableFishIntegration = false;
        enableNushellIntegration = false;
        enableZshIntegration = false;
        settings = {
          yazi = {
            sort_by = "natural";
            sort_sensitive = true;
            sort_reverse = false;
            sort_dir_first = true;
            show_hidden = true;
            show_symlink = true;
          };
        };
      };
    };
}
