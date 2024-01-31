#!/bin/sh
set -e

# backup any existing ~/.profile
if [ -f "$HOME/.profile" ] && [ ! -L "$HOME/.profile" ]; then
  mkdir -p "$HOME/.local/share/sh"
  mv "$HOME/.profile" "$HOME/.local/share/sh/profile.orig"
fi

# Create profile config directory
mkdir -p "$UPUP_CONFIGDIR/profile"
mkdir -p "$UPUP_CONFIGDIR/profile/path"

mkdir -p "$UPUP_BINDIR"

# Install ~/.profile
UPUP_ln "$PWD/dotfiles/profile.sh" "$HOME/.profile"

# Install dotfiles
UPUP_ln "$PWD/dotfiles/xdg.sh" "$UPUP_CONFIGDIR/profile/"
for f in dotfiles/path/*; do
  [ -f "$f" ] || continue
  UPUP_ln "$PWD/$f" "$UPUP_CONFIGDIR/profile/path/"
done
