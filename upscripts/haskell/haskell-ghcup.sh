#!/bin/sh
set -e

if command -v ghc \
  && command -v ghci \
  && command -v runghc \
  && command -v cabal
then
  exit
fi

UPUP_viasudo curl build-essential \
  libffi-dev libffi7 \
  libgmp-dev libgmp10 \
  libncurses-dev libncurses5 libtinfo5

export BOOTSTRAP_HASKELL_NONINTERACTIVE=1
## On install, ghcup uses the XDG dirs, but then when you run it again
## (sucha s `ghcup tui`), it does not seem to look there for binaries.
## Thus, ghcup thinks nothing is installed, even though the toolchain is
## in fact present.
# export GHCUP_USE_XDG_DIRS=1
## I'm going to disable cabl XDG "support" as well, as ghcup claims it
## doesn't work the way you'd expect.
# export BOOTSTRAP_HASKELL_CABAL_XDG=1
export BOOTSTRAP_HASKELL_INSTALL_HLS=1

curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

UPUP_ln "$PWD/dotfiles/path/cabal.sh" "$UPUP_CONFIGDIR/profile/path"
UPUP_ln "$PWD/dotfiles/path/ghcup.sh" "$UPUP_CONFIGDIR/profile/path"
