#!/bin/sh
set -e

intodir="$HOME/.vim/plugin/lsp"
mkdir -p "$intodir"

UPUP_ln "$PWD/dotfiles/rc.vim" "$intodir"
UPUP_ln "$PWD/dotfiles/haskell.vim" "$intodir"
