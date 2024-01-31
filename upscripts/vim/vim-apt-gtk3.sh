#!/bin/sh
set -e

# This is here because the `vim` package in `apt` doesn't have clipboard support

# Don't bother if `vim` already has clipboard support
if command -v vim && (vim --version | grep -F '+clipboard'); then exit; fi

if ! command -v apt-get; then
  echo >&2 "missing apt-get"
  exit 1
fi

sudo apt-get install -y vim-gtk3
