{
  hydeik.shells.homeManager =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.yazi ];
    };
}
