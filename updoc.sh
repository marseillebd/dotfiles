#!/bin/sh
set -e

here="$(dirname "$(realpath "$0")")"
cd "$here"

main() (
  mkdir -p docs
  for dir in upscripts/*; do
    if [ ! -d "$dir" ]; then continue; fi
    pkg="${dir#upscripts/}"
    exec >"docs/${pkg}.md"

    dumpPkg "$dir" "$pkg"

    if [ ! -d "$dir/integrations" ]; then continue; fi
    printf "\n# Integrations\n"
    for idir in "$dir/integrations/"*; do
      if [ ! -d "$idir" ]; then continue; fi
      ipkg="$(basename "$idir")"
      printf "\n## %s\n\n" "$ipkg"
      dumpPkg "$idir" "$ipkg" '##'
    done # with all integrations
  done # with all upscripts
)

dumpPkg() (
  dir="$1" # directory where the package is
  pkg="$2" # name of the package
  h="$3" # prefix for headings

  # dump the "about" page
  if [ -f "$dir/$pkg.md" ]; then
    cat "$dir/$pkg.md"
  fi

  # dump installation documentation
  if [ -f "$dir/$pkg.sh" ] ||
      ls "$dir/$pkg-"*.sh >/dev/null 2>&1; then
    printf "\n$h# Install\n\n"
    # first, for the primary/default install method
    if [ -f "$dir/$pkg.sh" ]; then
      dumpHH <"$dir/$pkg.sh"
    fi
    # then, for named install methods
    for f in "$dir/$pkg-"*.sh; do
      if [ ! -f "$f" ]; then continue; fi
      method="${f##*/}"
      method="${method#*-}"
      method="${method%.sh}"
      printf "\n$h## %s\n\n" "$method"
      dumpHH <"$f"
    done
  fi

  # dump configuration documentation
  if [ -f "$dir/config.sh" ]; then
    printf "\n$h# Configure\n\n"
    dumpHH <"$dir/config.sh"
  fi

  # dump dotfiles
  if [ -d "$dir/dotfiles" ]; then
    printf "\n$h# Dotfiles\n\n"
    echo '```'
    tree "$dir/dotfiles"
    echo '```'
  fi
)

dumpHH() {
  awk '
    BEGIN { doc = 0 }
    /^ *##/ { doc = 1; print; next }
    doc == 1 { print "" }
    { doc = 0 }' \
  | sed -E 's/^ *## ?//' \
  | sed '$!N; /^\n$/!P; D'
}

main
# tidy up extra whitespace
for md in docs/*.md; do
  sed -i '$!N; /^\n$/!P; D' "$md"
done

