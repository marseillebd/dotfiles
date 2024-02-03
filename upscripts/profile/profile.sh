#!/bin/sh
set -e

## Create a config directory `profile/`, with the following structure:
## - `profile/`
##   - `path/`
mkdir -p "$UPUP_CONFIGDIR/profile"
mkdir -p "$UPUP_CONFIGDIR/profile/path"

## Create the directory for user-local executables.
mkdir -p "$UPUP_BINDIR"

## Install `~/.profile`.
## This should source all the scripts under the `profile/` config dir in an appropriate order:
## - `profile/xdg.sh` to set up any xdg environment variables
## - `profile/path/*.sh` to initialize the `PATH` environment variable.
UPUP_ln "$PWD/dotfiles/profile.sh" "$HOME/.profile"

## Install dotfiles
## TODO move this to config.sh
UPUP_ln "$PWD/dotfiles/xdg.sh" "$UPUP_CONFIGDIR/profile/"
for f in dotfiles/path/*; do
  [ -f "$f" ] || continue
  UPUP_ln "$PWD/$f" "$UPUP_CONFIGDIR/profile/path/"
done
