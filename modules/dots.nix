{
  flake.modules.homeManager.base =
    { config, ... }:
    let
      dotsDir = "${config.home.homeDirectory}/src/github.com/hydeik/dotfiles/dots";
      dotsLink = path: config.lib.file.mkOutOfStoreSymlink "${dotsDir}/${path}";
    in
    {
      home.file.".config/nvim".source = dotsLink "config/nvim";
    };
}
