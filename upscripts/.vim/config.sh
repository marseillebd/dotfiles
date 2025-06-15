#!/bin/sh
set -e

## Vim does not respect the XDG Base Directory Specification.
## It looks unlikely to in the forseeable future.
## For now, I've just got this package configuring in the default path.
## Plugins should be installed using Vim8's package system: under `~/.vim/pack/VENDOR/{start,opt}/*`.

## Install `~/.vimrc`.
UPUP_ln "$PWD/dotfiles/vimrc.vim" "$HOME/.vimrc"
