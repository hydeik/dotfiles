{
  perSystem.treefmt.programs = {
    biome.enable = true;
  };

  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # Deno
        deno
        # Nodejs
        nodePackages.nodejs
        # Language servers
        typescript-language-server
        vtsls
        # Formatter
        eslint_d
        prettierd
      ];
    };
}
