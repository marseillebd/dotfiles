#!/bin/sh
set -e

if command -v fzf; then exit; fi

## Requires `git` and either `wget` or `curl`.
{
  command -v git
  command -v wget || command -v curl
} >/dev/null || echo >&2 'missing dependencies'

cleanup() {
  if [ -d "$UPUP_BUILDDIR/fzf" ]; then
    rm -rf "$UPUP_BUILDDIR/fzf"
  fi
}
trap "cleanup" EXIT

## Clone the github repository,
## then run the install script to get the precompiled binary.
cd "$UPUP_BUILDDIR"
git clone --depth 1 https://github.com/junegunn/fzf.git
cd fzf
./install --bin

## Move the binary into the user-local `bin/`
mv ./bin/fzf "$UPUP_BINDIR"
