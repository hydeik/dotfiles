{
  flake.modules.homeManager.base =
    { config, pkgs, ... }:
    {
      home.packages = with pkgs; [
        # Package manager
        pixi
        uv
        # Language server / Linter / Formatter
        ruff
      ];

      home.sessionVariables = {
        PYTHONSTARTUP = "${config.xdg.configHome}/python/pythonstartup.py";
        IPYTHONDIR = "${config.xdg.configHome}/ipython";
        JUPYTER_PLATFORM_DIRS = 1;
        JUPYTER_CONFIG_DIR = "${config.xdg.configHome}/jupyter";
        JUPYTER_DATA_DIR = "${config.xdg.dataHome}/jupyter";
      };
    };
}
