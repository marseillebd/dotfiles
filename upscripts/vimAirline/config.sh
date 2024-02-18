#!/bin/sh
set -e

intodir="$HOME/.vim/plugin/airline"
mkdir -p "$intodir"

UPUP_ln "$PWD/dotfiles/rc.vim" "$intodir"
