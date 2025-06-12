#!/bin/bash
set -e

# this is a quick-and-dirty script to transfer documentation from
# this repository into my obsidian vault on tsybulenko

obsdir="$HOME/Documents/obsidian/Actions/Artifacts/Upup/docs"

rm -rfv docs
./updoc.sh
for f in docs/*; do
  mv -v "$f" "docs/Upup - $(basename "$f")"
done
mv -v "$obsdir" ".obsdir.bak"
mv -v docs "$obsdir"
rm -rv ".obsdir.bak"
