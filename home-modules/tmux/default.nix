{
  config,
  lib,
  pkgs,
  catppuccin,
  ...
}:
let
  inherit (pkgs.stdenv) isDarwin;
  inherit (lib) optionals attrValues;
in
{
  home = {
    packages =
      with pkgs;
      [
        tmux-xpanes
      ]
      ++ optionals isDarwin (attrValues {
        inherit (pkgs)
          reattach-to-user-namespace
          ;
      });
  };

  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 50;
    focusEvents = true;
    historyLimit = 10000;
    mouse = true;
    prefix = "C-z";
    resizeAmount = 3;
    terminal = "tmux-256color";

    plugins = with pkgs; [
      tmuxPlugins.battery
      tmuxPlugins.copycat
      tmuxPlugins.cpu
      tmuxPlugins.open
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set-option -g @resurrect-dir ${config.xdg.stateHome}/tmux-ressurect
          set-option -g @resurrect-processes "ssh psql mysql sqlite3"
          set-option -g @resurrect-strategy-vim "session"
          set-option -g @resurrect-strategy-nvim "session"
        '';
      }
      {
        plugin = tmuxPlugins.prefix-highlight;
        extraConfig = ''
          set-option -g @prefix_highlight_fg 'black'
          set-option -g @prefix_highlight_bg 'blue'
          set-option -g @prefix_highlight_show_copy_mode 'on'
          set-option -g @prefix_highlight_copy_mode_attr 'fg=black,bg=yellow,bold'
          set-option -g @prefix_highlight_show_sync_mode 'on'
          set-option -g @prefix_highlight_sync_mode_attr 'fg=black,bg=magenta'
          set-option -g @prefix_highlight_prefix_prompt 'Wait'
          set-option -g @prefix_highlight_copy_prompt 'Copy'
          set-option -g @prefix_highlight_sync_prompt 'Sync'
          set-option -g @prefix_highlight_empty_prompt ' Tmux '
          set-option -g @prefix_highlight_empty_attr 'fg=black,bg=brightgreen'
        '';
      }
    ];

    extraConfig = ''
      # --- General settings
      set-option -g buffer-limit 50
      set-option -g display-time 5000
      set-option -g display-panes-time 5000
      set-option -g renumber-windows on

      # --- Key bindings
      source-file ${config.xdg.configHome}/tmux/keybinds.conf
    '';
  };

  catppuccin.tmux = {
    enable = true;
    extraConfig = ''
      set-option -g @catppuccin_flavor "frappe"
      set-option -g @catppuccin_window_status_style "rounded"

      # --- Status line
      set-option -g   status on
      set-option -g   status-interval 10
      set-option -g   status-position top
      set-option -g   status-right-length 100
      set-option -g   status-left-length 100
      set-option -g   status-left ""
      set-option -g   status-right "#{E:@catppuccin_status_application}"
      set-option -agF status-right "#{E:@catppuccin_status_cpu}"
      set-option -ag  status-right "#{E:@catppuccin_status_session}"
      set-option -ag  status-right "#{E:@catppuccin_status_uptime}"
      set-option -agF status-right "#{E:@catppuccin_status_host}"
      set-option -ag  status-right "#{prefix_highlight}"
    '';
  };

  xdg.configFile = {
    "tmux/keybinds.conf".source = pkgs.substituteAll {
      src = ./keybinds.conf;
      tmux_config_dir = "${config.xdg.configHome}/tmux";
    };
    "tmux/clipboard-copy.sh" = {
      source = ./clipboard-copy.sh;
    };
  };
}
