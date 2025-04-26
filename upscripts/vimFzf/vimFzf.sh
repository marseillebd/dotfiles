#!/bin/sh
set -e

{
  command -v git
  command -v fzf
} >/dev/null || echo >&2 "missing dependencies"

cleanup() {
  if [ -d "$UPUP_BUILDDIR/fzf" ]; then
    rm -rf "$UPUP_BUILDDIR/fzf"
  fi
}
trap "cleanup" EXIT

# grab the vim plugin from the main fzf repository
(
  cd "$UPUP_BUILDDIR"
  git clone --depth 1 https://github.com/junegunn/fzf.git
)
intodir="$HOME/.vim/pack/fzf/start/fzf"
if [ ! -d "$intodir" ]; then
  mkdir -p "$intodir"
  mv "$UPUP_BUILDDIR/fzf/plugin" "$intodir"
  mv "$UPUP_BUILDDIR/fzf/doc" "$intodir"
  vim -e -u NONE -c "helptags $intodir/doc" -c "q"
fi

# install junegunn's fzf.vim plugin for ¿a better ux?
intodir="$HOME/.vim/pack/fzf/start/fzf.vim"
if [ ! -d "$intodir" ]; then
  mkdir -p "$intodir"
  git clone --depth=1 https://github.com/junegunn/fzf.vim.git "$intodir"
  vim -e -u NONE -c "helptags $intodir/doc" -c "q"
fi

# install my own completion list functions
intodir="$HOME/.vim/pack/fzf/start/words/plugin"
if [ ! -d "$intodir" ]; then
  mkdir -p "$intodir"
  UPUP_ln "$PWD/dotfiles/words.vim" "$intodir"
fi
