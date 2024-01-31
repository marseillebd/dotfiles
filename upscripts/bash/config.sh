#!/bin/sh
set -e

# backup any existing bash configs
for rc in bash_profile bash_login bashrc; do
  if [ -f "$HOME/.$rc" ] && [ ! -L "$HOME/.$rc" ]; then
    mkdir -p "$HOME/.local/share/bash"
    mv "$HOME/.$rc" "$HOME/.local/share/bash/$rc.orig"
  fi
done

# Install bash config files
for rc in bash_profile bash_login bashrc; do
  UPUP_ln "$PWD/dotfiles/$rc.bash" "$HOME/.$rc"
done

# Create bash config directory
mkdir -p "$UPUP_CONFIGDIR/bash"
for d in alias color rc; do
  mkdir -p "$UPUP_CONFIGDIR/bash/$d"
  # Install dotfiles
  for f in "dotfiles/$d"/*; do
    [ -f "$f" ] || continue
    UPUP_ln "$PWD/$f" "$UPUP_CONFIGDIR/bash/$d/"
  done
done
