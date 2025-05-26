#!/bin/sh
set -e

if ! command -v >/dev/null; then
  echo >&2 "requires git installed"
  exit 1
fi

intodir="$HOME/.vim/pack/zig/start/zig.vim"
if [ ! -d "$intodir" ]; then
  mkdir -p "$intodir"
  git clone --depth=1 https://github.com/ziglang/zig.vim "$intodir"
  vim -e -u NONE -c "helptags $intodir/doc" -c "q"
fi
