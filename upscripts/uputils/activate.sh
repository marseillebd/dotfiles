#!/bin/sh
set -e

UPUP_BINDIR="${HOME}/.local/bin"
UPUP_CONFIGDIR="${XDG_CONFIG_HOME:-${HOME}/.config}"
UPUP_BUILDDIR="${HOME}/.local/.build"

# use the system package manager to install
# WARNING this assumes the package name is consistent across different package managers
UPUP_viasudo() {
  if command -v apt-get >/dev/null; then
    sudo apt-get install -y "$@"
  else
    echo >&2 "did not recognize system package manager"
    return 1
  fi
}
