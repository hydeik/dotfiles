{
  config,
  lib,
  pkgs,
  ...
}:
{
  home = {
    packages = lib.attrValues {
      inherit (pkgs)
        coreutils
        curl
        ghq
        gnumake
        gnutar
        jnv
        nix-init
        nix-output-monitor
        nix-update
        nkf
        wget
        zstd
        ;
    };
  };
  programs = {
    bash.enable = true;
    bat.enable = true;
    bottom.enable = true;
    btop = {
      enable = true;
      settings = {
        vim_keys = true;
      };
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    eza.enable = true;
    fd.enable = true;
    fzf.enable = true;
    gh.enable = true;
    git = {
      enable = true;
      delta = {
        enable = true;
        options = {
          line-numbers = true;
          navigate = true;
          side-by-side = true;
        };
      };
      extraConfig = {
        init.defaultBranch = "main";
        ghq.root = "${config.home.homeDirectory}/src";
      };
      ignores = [
        ".direnv"
        ".DS_Store"
        ".direnv"
        ".vscode/"
        "__pycache__/"
        ".ipynb_checkpoints"
        ".worktree"
      ];
    };
    gitui = {
      enable = true;
      keyConfig = ''
        (
            open_help: Some(( code: Char('?'), modifiers: "SHIFT")),

            move_left: Some(( code: Char('h'), modifiers: "")),
            move_right: Some(( code: Char('l'), modifiers: "")),
            move_up: Some(( code: Char('k'), modifiers: "")),
            move_down: Some(( code: Char('j'), modifiers: "")),

            popup_up: Some(( code: Char('p'), modifiers: "CONTROL")),
            popup_down: Some(( code: Char('n'), modifiers: "CONTROL")),
            page_up: Some(( code: Char('b'), modifiers: "CONTROL")),
            page_down: Some(( code: Char('f'), modifiers: "CONTROL")),
            home: Some(( code: Char('g'), modifiers: "")),
            end: Some(( code: Char('G'), modifiers: "SHIFT")),
            shift_up: Some(( code: Char('K'), modifiers: "SHIFT")),
            shift_down: Some(( code: Char('J'), modifiers: "SHIFT")),

            edit_file: Some(( code: Char('I'), modifiers: "SHIFT")),

            status_reset_item: Some(( code: Char('U'), modifiers: "SHIFT")),

            diff_reset_lines: Some(( code: Char('u'), modifiers: "")),
            diff_stage_lines: Some(( code: Char('s'), modifiers: "")),

            stashing_save: Some(( code: Char('w'), modifiers: "")),
            stashing_toggle_index: Some(( code: Char('m'), modifiers: "")),

            stash_open: Some(( code: Char('l'), modifiers: "")),

            abort_merge: Some(( code: Char('M'), modifiers: "SHIFT")),
        )
      '';
    };
    gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
    };
    jq.enable = true;
    lazygit = {
      enable = true;
      settings = {
        git = {
          paging = {
            colorArg = "always";
            pager = "delta --dark --paging=never";
          };
        };
        gui = {
          showIcons = true;
        };
      };
    };
    ripgrep.enable = true;
  };

}
