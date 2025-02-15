{ pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      hackgen-nf-font
      lmodern  # Latin Modern font
      lmmath   # Latin Modern Math font
      moralerspace-nf
      plemoljp-nf
      udev-gothic-nf
      xits-math
    ];
  };
}
