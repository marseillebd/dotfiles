#!/bin/sh
set -e

# Install dotfiles from subdirectories
for d in alias color rc; do
  mkdir -p "$UPUP_CONFIGDIR/shell/$d"
  for f in "dotfiles/$d"/*; do
    [ -f "$f" ] || continue
    UPUP_ln "$PWD/$f" "$UPUP_CONFIGDIR/shell/$d/"
  done
done
