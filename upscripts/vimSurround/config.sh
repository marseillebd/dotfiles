#!/bin/sh
set -e

intodir="$HOME/.vim/pack/surround/start/rc"
mkdir -p "$intodir/plugin"
UPUP_ln "$PWD/dotfiles/keybinds.vim" "$intodir/plugin"
