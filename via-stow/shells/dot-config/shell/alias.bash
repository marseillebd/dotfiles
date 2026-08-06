# shellcheck shell=bash

###### apt ######

# for "Apt Search Install"
# used when you probably know the name of the package you want to install, but might need to search if you aren't right
asi() {
  local yn
  if ! apt show "$1"; then
    apt search "$1"
    return
  fi
  # apt doesn't prompt when a package has no dependencies, so I prompt here, too
  echo "Install? (default yes)"
  select yn in "yes" "no"; do
    yn="${yn:-$REPLY}" # allow alternate spellings
    yn="${yn,,}" # to lower case
    yn="${yn:-yes}" # default yes
    case "$yn" in
      yes | y) break ;;
      no | n) return ;;
    esac
  done
  sudo apt install "$1"
}
