{
  flake.modules.homeManager.base.programs.lazygit = {
    enable = true;
    settings = {
      git = {
        padding = {
          colorArg = "always";
          pager = "delta --dark --paging=never";
        };
      };
      gui = {
        showIcons = true;
      };
    };
  };
}
