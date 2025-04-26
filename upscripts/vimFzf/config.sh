#!/bin/sh
set -e

intodir="$HOME/.vim/plugin/fzf"
mkdir -p "$intodir"

UPUP_ln "$PWD/dotfiles/keybinds.vim" "$intodir"
