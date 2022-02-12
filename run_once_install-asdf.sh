#!/usr/bin/env bash

set -euxo pipefail

if [ -f "$HOME/.asdf/asdf.sh" ]; then
  echo "asdf is already installed"
else
  git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" --branch v0.9.0
fi
