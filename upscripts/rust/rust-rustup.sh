#!/bin/sh
set -e

export RUSTUP_HOME="$HOME/.local/rustup"
export CARGO_HOME="$HOME/.local/cargo"
curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path -y

UPUP_ln "$PWD/dotfiles/cargo.sh" "$UPUP_CONFIGDIR/profile/path"
