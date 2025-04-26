#!/bin/sh
set -e

if ! command -v >/dev/null; then
  echo >&2 "requires git installed"
  exit 1
fi

intodir="$HOME/.vim/pack/supertab/start/supertab"
if [ ! -d "$intodir" ]; then
  mkdir -p "$intodir"
  git clone --depth=1 https://github.com/edemko/supertab.git "$intodir"
  vim -e -u NONE -c "helptags $intodir/doc" -c "q"
fi
