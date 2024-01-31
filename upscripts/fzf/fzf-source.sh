#!/bin/sh
set -e

if command -v fzf; then exit; fi

{ # Check install requirements
  command -v git
  command -v wget || command -v curl
} >/dev/null || echo >&2 'missing dependencies'

# Download
cd "$UPUP_BUILDDIR"
git clone --depth 1 https://github.com/junegunn/fzf.git
cd fzf
./install --bin

# Install
mv ./bin/fzf "$UPUP_BINDIR"
mkdir -p "${UPUP_CONFIGDIR}/fzf"
cp shell/* "$UPUP_CONFIGDIR/fzf"
