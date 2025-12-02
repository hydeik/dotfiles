{
  hydeik.dev-lang = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          fx
          jd-diff-patch
          jq
        ];
      };
  };
}
