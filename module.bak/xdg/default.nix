{
  flake.modules.homeManager.base =
    { config, ... }:
    let
      inherit (config.xdg)
        cacheHome
        configHome
        dataHome
        ;
    in
    {
      xdg = {
        enable = true;
        configFile."npm/npmrc".source = ./npmrc;
        configFile."python/pythonstartup.py".source = ./pythonstartup.py;
      };
      home = {
        sessionVariables = {
          # CUDA
          CUDA_CACHE_PATH = "${cacheHome}/nv";

          # Deno
          DENO_DIR = "${cacheHome}/deno";

          # Docker
          DOCKER_CONFIG = "${configHome}/docker";
          MACHINE_STORAGE_PATH = "${dataHome}/docker-machine";

          # GnuPG
          GNUPGHOME = "${dataHome}/gnupg";

          # less
          LESSHISTFILE = "${cacheHome}/less/history";

          # Node
          NODE_REPL_HISTORY = "${dataHome}/node_repl_history";
          NPM_CONFIG_USERCONFIG = "${configHome}/npm/npmrc";

          # Python
          PYTHONSTARTUP = "${configHome}/python/pythonstartup.py";
          IPYTHONDIR = "${configHome}/ipython";
          JUPYTER_PLATFORM_DIRS = 1;
          JUPYTER_CONFIG_DIR = "${configHome}/jupyter";
          JUPYTER_DATA_DIR = "${dataHome}/jupyter";

          # Ruby
          GEM_HOME = "${dataHome}/gem";
          GEM_SPEC_CACHE = "${cacheHome}/gem";

          # Rust
          RUSTUP_HOME = "${dataHome}/rustup";
          CARGO_HOME = "${dataHome}/cargo";
        };
      };
    };
}
