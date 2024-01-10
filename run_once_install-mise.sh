#!/usr/bin/env bash

set -euxo pipefail

install_mise() {
  install_path="${MISE_INSTALL_PATH:-$HOME/.local/bin/mise}"

  if ! [ -x "$install_path" ]; then
    curl https://mise.jdx.dev/install.sh | sh
  fi
}

if ! install_mise; then
    echo "mise is not installed..."
fi

exit 0
