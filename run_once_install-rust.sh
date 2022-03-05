#!/usr/bin/env bash

set -euxo pipefail

RUSTUP="${CARGO_HOME:-$HOME/.cargo}/bin/rustup"
CARGO="${CARGO_HOME:-$HOME/.cargo}/bin/cargo"

has_command() {
  command -v "$1" > /dev/null 2>&1
}

has_toolchain() {
  "$RUSTUP" toolchain list | grep "$1" > /dev/null 2>&1
}

if [ -x "$RUSTUP" ]; then
  "$RUSTUP" update
else
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
fi

for toolchain in stable beta nightly; do
  if ! has_toolchain "$toolchain"; then
    "$RUSTUP" toolchain install $toolchain
    for component in rls rust-analysis rust-src; do
      "$RUSTUP" component add --toolchain="$toolchain" "$component" || true
    done
  fi
done

"$RUSTUP" component add --toolchain=nightly rustc-dev || true

is_installed() {
  has_command "$1" || "$CARGO" install --list | grep "$1" > /dev/null 2>&1
}

CARGO_INSTALL_TARGET=(
  # Cargo tools
  cargo-audit
  cargo-benchcmp
  cargo-check
  cargo-deps
  cargo-edit
  cargo-expand
  cargo-generate
  cargo-license
  cargo-modules
  cargo-outdated
  cargo-profiler
  cargo-release
  cargo-tarpaulin
  cargo-tree
  cargo-update
  cargo-watch
  # CLI apps
  bat
  bingrep
  choose
  cpc
  dotenv-linter
  du-dust
  evcxr_jupyter
  evcxr_repl
  exa
  fd-find
  find-files
  flamegraph
  gitui
  hx
  hyperfine
  inferno
  jless
  jql
  lsd
  procs
  pyflow
  ripgrep
  rm-improved
  skim
  stylua
  tokei
  xcp
  ytop
  zellij
  zoxide
)

CARGO_INSTALL_TARGET_NIGHTLY=(
  racer
)

for target in "${CARGO_INSTALL_TARGET[@]}"; do
  if ! is_installed "$target"; then
    "$CARGO" install "$target" || true
  fi
done

for target in "${CARGO_INSTALL_TARGET_NIGHTLY[@]}"; do
  if ! is_installed "$target"; then
    "$CARGO" +nightly install "$target" || true
  fi
done