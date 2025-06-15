# shellcheck shell=sh

alias tree='tree -I ".git|dist-newstyle"'
treeless() {
  tree -C "$@" | less -R
}
