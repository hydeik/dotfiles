{
  hydeik.dev-lang = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          # Biome
          biome
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
  };
}
