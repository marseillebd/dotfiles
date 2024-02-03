#!/bin/sh
set -e

## Create the condig dir `shell/`, which each shell's rc file should source from (wherever possible).
## Also create the subdirectories:
## - `sh/color/`, to configure terminal colors
## - `sh/rc/`, for history, prompt, interpreter options, and so on
## - `sh/alias/`, for aliases and functions
for d in alias color rc; do
  mkdir -p "$UPUP_CONFIGDIR/shell/$d"
  for f in "dotfiles/$d"/*; do
    [ -f "$f" ] || continue
    UPUP_ln "$PWD/$f" "$UPUP_CONFIGDIR/shell/$d/"
  done
done

## For now, I have these directories pre-populated with some config files.
## Technically, these should all be _integrations_ for their respective programs.
## In practice, most of these commands are so ubiquitous that it doesn't make much sense
## to split them up.
##
## However, if those programs _do_ get their own packages, then the corresponding dotfiles
## should be moved away so that those packages' configs do not conflict with this one's.
