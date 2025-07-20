let
  makeFontSet =
    pkgs: with pkgs; [
      biz-ud-gothic
      dejavu_fonts
      freefont_ttf
      explex-nf
      gyre-fonts
      hackgen-nf-font
      liberation_ttf
      # Latin Modern font
      lmodern
      # Latin Modern Math font
      lmmath
      material-icons
      material-symbols
      material-design-icons
      moralerspace-nf
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      plemoljp-nf
      source-han-sans
      source-han-serif
      source-han-mono
      udev-gothic-nf
      unifont

      ##
      ## Maple Fonts
      ##
      # Maple Mono (Ligature Variable)
      maple-mono.variable
      # Maple Mono (Ligature TTF hinted)
      maple-mono.truetype-autohint
      # Maple Mono (Ligature TTF unhinted)
      maple-mono.truetype
      # Maple Mono (Ligature OTF)
      maple-mono.opentype
      # Maple Mono (Ligature WOFF2)
      maple-mono.woff2
      # Maple Mono NF (Ligature hinted)
      maple-mono.NF
      # Maple Mono NF (Ligature unhinted)
      maple-mono.NF-unhinted
      # Maple Mono CN (Ligature hinted)
      maple-mono.CN
      # Maple Mono CN (Ligature unhinted)
      maple-mono.CN-unhinted
      # Maple Mono NF CN (Ligature hinted)
      maple-mono.NF-CN
      # Maple Mono NF CN (Ligature unhinted)
      maple-mono.NF-CN-unhinted

      # Maple Mono (No-Ligature Variable)
      maple-mono.NL-Variable
      # Maple Mono (No-Ligature TTF hinted)
      maple-mono.NL-TTF-AutoHint
      # Maple Mono (No-Ligature TTF unhinted)
      maple-mono.NL-TTF
      # Maple Mono (No-Ligature OTF)
      maple-mono.NL-OTF
      # Maple Mono (No-Ligature WOFF2)
      maple-mono.NL-Woff2
      # Maple Mono NF (No-Ligature hinted)
      maple-mono.NL-NF
      # Maple Mono NF (No-Ligature unhinted)
      maple-mono.NL-NF-unhinted
      # Maple Mono CN (No-Ligature hinted)
      maple-mono.NL-CN
      # Maple Mono CN (No-Ligature unhinted)
      maple-mono.NL-CN-unhinted
      # Maple Mono NF CN (No-Ligature hinted)
      maple-mono.NL-NF-CN
      # Maple Mono NF CN (No-Ligature unhinted)
      maple-mono.NL-NF-CN-unhinted

      # Maple Mono Normal (Ligature Variable)
      maple-mono.Normal-Variable
      # Maple Mono Normal (Ligature TTF hinted)
      maple-mono.Normal-TTF-AutoHint
      # Maple Mono Normal (Ligature TTF unhinted)
      maple-mono.Normal-TTF
      # Maple Mono Normal (Ligature OTF)
      maple-mono.Normal-OTF
      # Maple Mono Normal (Ligature WOFF2)
      maple-mono.Normal-Woff2
      # Maple Mono Normal NF (Ligature hinted)
      maple-mono.Normal-NF
      # Maple Mono Normal NF (Ligature unhinted)
      maple-mono.Normal-NF-unhinted
      # Maple Mono Normal CN (Ligature hinted)
      maple-mono.Normal-CN
      # Maple Mono Normal CN (Ligature unhinted)
      maple-mono.Normal-CN-unhinted
      # Maple Mono Normal NF CN (Ligature hinted)
      maple-mono.Normal-NF-CN
      # Maple Mono Normal NF CN (Ligature unhinted)
      maple-mono.Normal-NF-CN-unhinted

      # Maple Mono Normal (No-Ligature Variable)
      maple-mono.NormalNL-Variable
      # Maple Mono Normal (No-Ligature TTF hinted)
      maple-mono.NormalNL-TTF-AutoHint
      # Maple Mono Normal (No-Ligature TTF unhinted)
      maple-mono.NormalNL-TTF
      # Maple Mono Normal (No-Ligature OTF)
      maple-mono.NormalNL-OTF
      # Maple Mono Normal (No-Ligature WOFF2)
      maple-mono.NormalNL-Woff2
      # Maple Mono Normal NF (No-Ligature hinted)
      maple-mono.NormalNL-NF
      # Maple Mono Normal NF (No-Ligature unhinted)
      maple-mono.NormalNL-NF-unhinted
      # Maple Mono Normal CN (No-Ligature hinted)
      maple-mono.NormalNL-CN
      # Maple Mono Normal CN (No-Ligature unhinted)
      maple-mono.NormalNL-CN-unhinted
      # Maple Mono Normal NF CN (No-Ligature hinted)
      maple-mono.NormalNL-NF-CN
      # Maple Mono Normal NF CN (No-Ligature unhinted)
      maple-mono.NormalNL-NF-CN-unhinted
    ];
in
{
  flake.modules.darwin.desktop =
    { pkgs, ... }:
    {
      # fonts.packages = lib.attrsets.attrVals fontNames pkgs;
      fonts.packages = makeFontSet pkgs;
    };
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      fonts = {
        packages = makeFontSet pkgs;
        # TODO: add fontconfig settings
      };
    };
}
