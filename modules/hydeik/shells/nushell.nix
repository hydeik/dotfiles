{
  hydeik.shells.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        nushell
      ];

      programs.bash.profileExtra = ''
        if ! [ "$TERM" = "dumb" ] && [ -z "$BASH_EXECUTION_STRING" ]; then
          exec nu
        fi
      '';
    };
}
