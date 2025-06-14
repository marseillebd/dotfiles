# shellcheck shell=sh

# TODO harvested from ubuntu's defaults
if [ -x /usr/bin/dircolors ]; then
  if [ -r "${HOME}/.dircolors" ]; then
    eval "$(dircolors -b "${HOME}/.dircolors")"
  else
    eval "$(dircolors -b)"
  fi
fi
