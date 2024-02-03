#!/bin/sh
set -e

## Install bash completion scripts and keybindings.
## These were copied from the source repository in Jan 2024.
confdir="${UPUP_CONFIGDIR}/bash"
UPUP_ln "$PWD/dotfiles/completion.bash" "$confdir/completion/fzf.bash"
UPUP_ln "$PWD/dotfiles/key-bindings.bash" "$confdir/rc/fzf.bash"

## Similar scripts for zsh and fish were also available,
## but since I don't use those shells, they are not installed.
