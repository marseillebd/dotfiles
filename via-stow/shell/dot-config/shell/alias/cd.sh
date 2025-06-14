# shellcheck shell=sh

mkcd() { mkdir "$1" && cd "$1"; }

gitcd() { git clone "$1" && cd "${1##*/}"; }
