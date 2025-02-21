#!/bin/sh
set -e

if command -v node \
  && command -v npm
then
  exit
fi

###### Install `nvm` ######

if ! command -v bash >/dev/null
then
  echo >&2 "nvm installation of node.js requires bash"
fi

UPUP_viasudo curl

(
  version='v0.40.1'
  export PROFILE=/dev/null
  curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$version/install.sh" | bash
)

UPUP_ln "$PWD/dotfiles/nvm.bash" "$UPUP_CONFIGDIR/bash/path/nvm.bash"
UPUP_ln "$PWD/dotfiles/bash_completion.bash" "$UPUP_CONFIGDIR/bash/completion/nvm.bash"

. "$PWD/dotfiles/nvm.bash"
nvm install lts/*
