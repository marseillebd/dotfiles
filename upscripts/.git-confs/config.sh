#!/bin/sh
set -e

## Ensure `git/config` exists in the config dir,
## because (WORDAROUND) if git doesn't find a config file,
## `git -e` will put it at `~/.gitconfig` rather than respect XDG.
mkdir -p "$UPUP_CONFIGDIR/git"
touch "$UPUP_CONFIGDIR/git/config"

## Set up my user settings (name&email).
git config --global user.name 'Marseille Bouchard'
git config --global user.email 'marseillebd@proton.me'

## Set up simple shortcuts:
## - `st`
## - `com`
## - `amend`
## - `co`
git config --global alias.st 'status'
git config --global alias.com 'commit -a'
git config --global alias.amend 'command -a --amend'
git config --global alias.co 'checkout'

## Some handy (but less simple) shortcuts:
## - `hash` to print the hash of the last commit
## - `graph` to print a short-form graph of the commit tree
git config --global alias.hash 'rev-parse HEAD'
git config --global alias.graph 'log --graph --all --oneline --decorate'

## - [ ] TODO I should learn the exact difference between unstage and rollback
git config --global alias.rollback 'checkout --'
git config --global alias.unstage 'reset --'

## Explicitly set default push style to simple.
## Git itself recommended this years ago, and I've still got it hanging around.
git config --global push.default simple
