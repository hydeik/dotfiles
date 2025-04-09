{
  flake.modules.homeManager.base.programs = {
    # Info
    info.enable = true;
    # Implementation of `tldr` in Rust.
    tealdeer = {
      enable = true;
      settings.display.use_pager = true;
    };
  };
}
