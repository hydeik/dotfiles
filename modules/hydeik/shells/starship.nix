{
  hydeik.shells = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          starship
        ];
      };
  };
}
