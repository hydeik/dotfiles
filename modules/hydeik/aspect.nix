{
  den,
  hydeik,
  hydix,
  ...
}:
{
  den.aspects.hydeik = {
    includes = [
      (den.provides.unfree [
        "copilot-language-server"
        "cursor"
        "github-copilot-cli"
        "vscode"
      ])

      hydeik.ai
      hydeik.catppuccin
      hydeik.cli-tui
      hydeik.dev-lang
      hydeik.direnv
      hydeik.dots
      hydeik.editors
      hydeik.fonts
      hydeik.git
      hydeik.hm-backup
      hydeik.homebrew
      hydeik.jujutsu
      hydeik.nix-btw
      hydeik.secrets
      hydeik.shells
      hydeik.terminals
      hydeik.tmux

      (den.lib.perHost hydix.nix-index)
      (den.lib.perHost hydix.nix-registry)
    ];
  };
}
