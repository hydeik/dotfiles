# Dotfiles (powered by mise)

These are my personal dotfiles for macOS and Linux, managed primarily with [mise-en-place](https://mise.jdx.dev/).

The repository uses mise not only for development tools, but also for machine bootstrapping, package installation, dotfile deployment, repository setup, and platform-specific configuration. 

## Overview

The configuration is organized around mise's declarative bootstrap features:

- **Tools** — command-line tools and language runtimes are managed by mise.
- **System packages** — macOS packages and applications are installed via mise's builtin Homebrew installer on bootstrap.
- **Dotfiles** — configuration files under `$HOME` and `$XDG_CONFIG_HOME` are deployed by mise using symlinks, copies, or templates.
- **Repositories** — required Git repositories, including shell and tmux plugins, are cloned automatically.
- **Platform-specific settings** — macOS defaults and other OS-specific configuration are separated into environment-specific mise config files.
- **Shell setup** — Zsh configuration and the login shell are configured during bootstrap.

The main mise configuration lives under `.mise/`, with additional configuration split into `.mise/conf.d/`.

## Requirements

Before bootstrapping a new machine, the following commands must be available:

- `git`
- `curl`

The bootstrap script installs the required package managers when they are missing:

- **macOS:** Homebrew and mise
- **Linux:** mise

mise is installed using its official installer on both platforms.

## Installation

### 1. Clone this repository

The configuration expects the repository at `~/src/github.com/hydeik/dotfiles`, so clone it there:

```bash
git clone --branch mise https://github.com/hydeik/dotfiles.git \
  ~/src/github.com/hydeik/dotfiles
cd ~/src/github.com/hydeik/dotfiles
```

### 2. Install package managers

Run the bootstrap script:

```bash
./scripts/bootstrap-package-managers.sh
```

If mise has just been installed and is not yet available in the current shell, add its default install location to `PATH`:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

### 3. Trust the mise configuration

```bash
mise trust
```

### 4. Bootstrap the machine

```bash
mise bootstrap --yes
```

`mise bootstrap` applies the machine configuration in dependency order, including system packages, Git repositories, dotfiles, platform-specific settings, the login shell, and mise-managed tools.

After bootstrap completes, start a new shell session so that the updated shell configuration is loaded.

## Updating the environment

Pull the latest dotfiles and re-run bootstrap:

```bash
cd ~/src/github.com/hydeik/dotfiles
git pull
mise bootstrap --yes
```

To update repositories declared in the mise bootstrap configuration explicitly, use:

```bash
mise bootstrap repos update --yes
```

To install or reconcile mise-managed tools without applying the full machine bootstrap:

```bash
mise install
```

## Dotfile management

Dotfiles are declared in `.mise/conf.d/dotfiles.toml` and are applied as part of `mise bootstrap`.

To inspect their current state:

```bash
mise bootstrap dotfiles status
```

To apply only the dotfiles configuration:

```bash
mise bootstrap dotfiles apply --yes
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
