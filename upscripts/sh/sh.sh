#!/bin/sh
set -e

mkdir -p "${HOME}/.local/bin"
mkdir -p "${HOME}/.config"
mkdir -p "${HOME}/.local/.build"

if [ -f "$HOME/.profile" ]; then
  mkdir -p "$HOME/.local/share/sh"
  mv "$HOME/.profile" "$HOME/.local/share/sh/profile.orig"
fi
ln -sv "$PWD/dotfiles/profile.sh" "$HOME/.profile"

