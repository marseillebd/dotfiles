# shellcheck shell=sh

# lolcat, but less
loless() {
  case $# in
    0) lolcat -f | less -R ;;
    *) lolcat -f "$1" | less -R ;;
  esac
}
