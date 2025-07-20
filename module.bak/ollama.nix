{ lib, ... }:
{
  flake.modules.homeManager.base =
    { config, ... }:
    let
      cfg = config.my;
    in
    {
      options.my.ollama.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };

      config = {
        home.sessionVariables = lib.optionalAttrs cfg.ollama.enable {
          OLLAMA_MODELS = "${config.xdg.dataHome}/ollama/models";
        };

        services.ollama.enable = cfg.ollama.enable;
      };
    };
}
