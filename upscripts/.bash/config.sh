#!/bin/sh
set -e

## Install config files in home directory:
## - `~/.bash_profile` for login shells (sets up environment),
##   but ours just forwards to `~/.bashrc`, because the environment should not depend on the shell.
## - `~/.bash_login` like `~/.bash_profile`,
##   so ours just forwards again.
## - `~/.bashrc` for interactive shells,
##   so it sets up aliases, the prompt, and whatnot that is useful when a human is interacting.
##   It actually should do nothing if it's not running interactively,
##   or else bash scripts could cause chaos when they come into contact with aliases and whatnot.
for rc in bash_profile bash_login bashrc; do
  UPUP_ln "$PWD/dotfiles/$rc.bash" "$HOME/.$rc"
done

## Create a config directory called `bash/`.
## The bashrc files should just be sourcing files in here.
## That way, when programs want to integrate with bash, they can use their own files
## instead of polluting a single monolithic file.
## Under this directory are several subfolders which are sourced in a given order:
## - `bash/completion/`, to set up bash completion scripts
## - `bash/color/`, to configure terminal colors
## - `bash/rc/`, for history, prompt, interpreter options, and so on
## - `bash/alias/`, for aliases and functions
mkdir -p "$UPUP_CONFIGDIR/bash"
for d in alias color rc; do
  mkdir -p "$UPUP_CONFIGDIR/bash/$d"
  # Install dotfiles
  for f in "dotfiles/$d"/*; do
    [ -f "$f" ] || continue
    UPUP_ln "$PWD/$f" "$UPUP_CONFIGDIR/bash/$d/"
  done
done
