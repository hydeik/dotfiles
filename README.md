# Dotfiles (powered by Nix)

These are my personal, Nix-based dotfiles configured using [Nix flakes](https://nixos.wiki/wiki/Flakes).

## Overview

This repository provides a structured and reproducible system configuration for Darwin machines using [nix-darwin](https://github.com/nix-darwin/nix-darwin) and [home-manager](https://github.com/nix-community/home-manager).

## Installation

1. **Install Nix with flakes enabled**:

 - [Official Nix Installer](https://nixos.org/download/)
 - [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer)

> [!WARING]
> Determinate Nix Installer has the options to install official (planner) Nix, as well as Determinate's own variants (Determinate Nix).
> Make sure to install the official Nix, otherwise the configurations raise errors coming from the incompatible options.

3. **Clone this repo**:

   ```bash
   $ git clone https://github.com/hydeik/dotfiles <path-to-dotfiles> 
   $ cd <path-to-dotfiles>
   ```

4. **Run Nix flake**:

   ```bash
   $ nix flake lock
   # Setup darwin system
   $ nix run flake nix-darwin/nix-darwin/master#darwin-rebuild -- switch --flake .#<hostname> 
   ```


## Update system configurations and packages

   ```bash
   $ nix flake update
   # update darwin system
   $ darwin-rebuild switch --flake .#<hostname>
   ```

## License

This project is licensed under the MIT License. See the [LICENSE](../LICENSE) file for details.

