#!/bin/sh
set -e

# Install dotfiles from subdirectories
confdir="${UPUP_CONFIGDIR}/bash"
UPUP_ln "$PWD/dotfiles/completion.bash" "$confdir/completion/fzf.bash"
UPUP_ln "$PWD/dotfiles/key-bindings.bash" "$confdir/rc/fzf.bash"
