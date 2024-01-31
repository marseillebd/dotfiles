#!/bin/sh
set -e

# Install main vim config file
UPUP_ln "$PWD/dotfiles/vimrc.vim" "$HOME/.vimrc"
