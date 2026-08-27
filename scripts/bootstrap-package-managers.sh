#!/usr/bin/env bash

set -Eeuo pipefail

readonly HOMEBREW_INSTALL_URL="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
readonly MISE_INSTALL_URL="https://mise.run"

log() {
  printf '[bootstrap] %s\n' "$*"
}

die() {
  printf '[bootstrap] ERROR: %s\n' "$*" >&2
  exit 1
}

require_curl() {
  command -v curl >/dev/null 2>&1 ||
    die "curl is required to install package managers."
}

load_homebrew() {
  local brew_bin=""
  local candidate

  if command -v brew >/dev/null 2>&1; then
    brew_bin="$(command -v brew)"
  else
    for candidate in /opt/homebrew/bin/brew /usr/local/bin/brew; do
      if [[ -x "$candidate" ]]; then
        brew_bin="$candidate"
        break
      fi
    done
  fi

  [[ -n "$brew_bin" ]] || return 1
  eval "$("$brew_bin" shellenv)"
}

ensure_homebrew() {
  if load_homebrew; then
    log "Homebrew is already installed: $(brew --version | head -n 1)"
    return
  fi

  require_curl
  log "Homebrew was not found; starting the official installer."
  /bin/bash -c "$(curl -fsSL "$HOMEBREW_INSTALL_URL")"

  load_homebrew ||
    die "Homebrew was installed, but its executable could not be located."
  log "Homebrew installed: $(brew --version | head -n 1)"
}

ensure_mise() {
  # The official installer uses this location by default. Adding it here also
  # detects an existing installation that is not yet configured in a shell RC.
  export PATH="${HOME}/.local/bin:${PATH}"

  if command -v mise >/dev/null 2>&1; then
    log "mise is already installed: $(mise --version)"
    return
  fi

  require_curl
  log "mise was not found; starting the official installer."
  curl -fsSL "$MISE_INSTALL_URL" | sh

  command -v mise >/dev/null 2>&1 ||
    die "mise was installed, but ${HOME}/.local/bin/mise is not executable."
  log "mise installed: $(mise --version)"
}

main() {
  case "$(uname -s)" in
    Darwin)
      ensure_homebrew
      ensure_mise
      ;;
    Linux)
      ensure_mise
      ;;
    *)
      die "Unsupported operating system: $(uname -s)"
      ;;
  esac

  log "Package-manager bootstrap completed."
}

main "$@"
