#!/bin/sh
set -e

## This method exists because the `vim` package in `apt` (at least for Ubuntu 20.04)
## ships with `-clipboard`, which I frankly find essential. I'm always using `vim` from
## within a terminal emulator after all, not a raw console.
##
## The solution here is to install `vim-gtk3`, which has a GUI vim,
## and therefore compiles `+clipboard` in because that's the sensible default.

if command -v vim && (vim --version | grep -F '+clipboard'); then exit; fi

if ! command -v apt-get; then
  echo >&2 "missing apt-get"
  exit 1
fi

sudo apt-get install -y vim-gtk3
