#!/usr/bin/env bash

set -euxo pipefail

if ! [ -x "$HOME/.local/share/rtx/bin/rtx" ]; then
    curl https://rtx.pub/install.sh | sh
fi

if [ $? -ne 0 ]; then
    echo "rtx is not installed..."
fi

exit 0
