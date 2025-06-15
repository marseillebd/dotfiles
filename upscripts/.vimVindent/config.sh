#!/bin/sh
set -e

intodir="$HOME/.vim/plugin/vindent"
mkdir -p "$intodir"

UPUP_ln "$PWD/dotfiles/rc.vim" "$intodir"
UPUP_ln "$PWD/dotfiles/keybinds.vim" "$intodir"
