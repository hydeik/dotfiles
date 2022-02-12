#!/usr/bin/env bash

set -euxo pipefail

POETRY_DIR="$HOME/.poetry"

if [ -x "$POETRY_DIR/bin/poetry" ]; then
  echo "Poetry is already installed"
else
  curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
fi
