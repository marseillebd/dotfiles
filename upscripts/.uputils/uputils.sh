#!/bin/sh
set -e

mkdir -p "${HOME}/.local/bin"
mkdir -p "${XDG_CONFIG_HOME:-${HOME}/.config}"
mkdir -p "${HOME}/.local/.build"
