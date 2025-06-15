#!/bin/sh
set -e

# Install dotfiles from subdirectories
for d in alias color rc; do
  for f in "dotfiles/$d"/*; do
    [ -f "$f" ] || continue
    mkdir -p "$UPUP_CONFIGDIR/shell/$d"
    UPUP_ln "$PWD/$f" "$UPUP_CONFIGDIR/shell/$d/"
  done
done
