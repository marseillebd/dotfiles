#!/bin/sh
set -e

intodir="$HOME/.vim/plugin/zig.vim"
mkdir -p "$intodir"

UPUP_ln "$PWD/dotfiles/rc.vim" "$intodir"
