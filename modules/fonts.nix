{ lib, ... }:
let
  fontNames = [
    "dejavu_fonts"
    "freefont_ttf"
    "gyre-fonts"
    "hackgen-nf-font"
    "liberation_ttf"
    "lmodern" # Latin Modern font
    "lmmath" # Latin Modern Math font
    # "maple-mono"
    "material-icons"
    "material-symbols"
    "material-design-icons"
    "moralerspace-nf"
    "noto-fonts"
    "noto-fonts-cjk-sans"
    "noto-fonts-cjk-serif"
    "noto-fonts-color-emoji"
    "plemoljp-nf"
    "source-han-sans"
    "source-han-serif"
    "source-han-mono"
    "udev-gothic-nf"
    "unifont"
  ];
in
{
  flake.modules.darwin.desktop =
    { pkgs, ... }:
    {
      fonts.packages = lib.attrsets.attrVals fontNames pkgs;
    };
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      fonts = {
        fonts.packages = lib.attrsets.attrVals fontNames pkgs;
        # TODO: add fontconfig settings
      };
    };
}
