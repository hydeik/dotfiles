#!/bin/sh

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

# Install latest nodejs
if ! command -v node > /dev/null; then
    curl --fail -L https://install-node.now.sh/latest | sh
    # Or use apt-get
    # sudo apt-get install nodejs
fi

# Install yarn
if ! command -v yarn > /dev/null; then
    curl --fail -L https://yarnpkg.com/install.sh | sh
fi

# Install extensions
mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
if [ ! -f package.json ]
then
  echo '{"dependencies":{}}'> package.json
fi
# Change arguments to extensions you need
yarn add coc-css coc-emmet coc-emoji coc-eslint coc-highlight coc-html \
         coc-json coc-lists coc-neosnippet coc-omni coc-prettier \
         coc-pyls coc-rls coc-tag coc-tsserver coc-vetur coc-vimtex \
         coc-word coc-yaml coc-yank
