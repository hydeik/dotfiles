{
  hydeik.dev-lang = {
    homeManager =
      { config, pkgs, ... }:
      {
        home.packages = with pkgs; [
          # Biome
          biome
          # Deno
          deno
          # Nodejs
          nodejs_latest
          # Language servers
          typescript-language-server
          vtsls
          # Formatter
          eslint_d
          prettierd
        ];

        home.sessionVariables = {
          # Deno
          DENO_DIR = "${config.xdg.cacheHome}/deno";
          # Node
          NODE_REPL_HISTORY = "${config.xdg.dataHome}/node_repl_history";
          NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";
        };
      };
  };
}
