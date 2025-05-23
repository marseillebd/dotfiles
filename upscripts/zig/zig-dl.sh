#!/bin/bash
set -e

if command -v zig; then
  exit
fi

if ! command -v curl; then
  echo >&2 "missing curl"
  exit 1
fi

cleanup() {
  cd "$UPUP_BUILDDIR"
  if [ -n "$tarname" ]; then
    rm -f "$tarname"
    echo "$untarname"
    rm -rf "$untarname"
  fi
}
trap cleanup EXIT

(
  cd "$UPUP_BUILDDIR"
  urls="$(curl 'https://ziglang.org/download/index.json' | jq '.master["x86_64-linux"]')"
  tarurl="$(echo "$urls" | jq -r '.tarball')"
  tarname="$(basename "$tarurl")"
  untarname="${tarname%.tar.*}"
  echo "$tarurl"
  echo "$tarname"
  echo "$untarname"
  curl "$tarurl" > "$tarname"
  # TODO check hash
  tar -xf "$tarname"

  installdir="$HOME/.local/zig"
  [ -e "$installdir" ] && rm -r "$installdir"
  mv "$untarname" "$installdir"
)

UPUP_ln "$PWD/dotfiles/path/zig.sh" "$UPUP_CONFIGDIR/profile/path"
