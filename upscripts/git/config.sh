#!/bin/sh
set -e

{ # check requirements
  command -v git
} >/dev/null || echo >&2 "missing dependencies"

# WORKAROUND because git still puts the config into ~/.gitconfig when there's no other config file
mkdir -p "$UPUP_CONFIGDIR/git"
touch "$UPUP_CONFIGDIR/git/config"
# end workaround

git config --global user.name 'Marseille Bouchard'
git config --global user.email 'marseillebd@proton.me'

# simple shortcuts
git config --global alias.st 'status'
git config --global alias.com 'commit -a'
git config --global alias.amend 'command -a --amend'
git config --global alias.co 'checkout'

# high)ish)-level actions
git config --global alias.hash 'rev-parse HEAD'
git config --global alias.graph 'log --graph --all --oneline --decorate'

# TODO I should learn the exact difference between unstage and rollback
git config --global alias.rollback 'checkout --'
git config --global alias.unstage 'reset --'

git config --global push.default simple # the default since v2.0
