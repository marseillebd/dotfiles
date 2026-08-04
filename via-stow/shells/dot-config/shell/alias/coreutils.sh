# shellcheck shell=sh

# make and enter directory is such a common operation

mkcd() { mkdir "$1" && cd "$1"; }
gitcd() { git clone "$1" && cd "${1##*/}"; }

# say ysap do this to make going up directories really easy
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# verbose ln gives more feedback
alias ln='ln -v'
# TODO an alias for relative symlinks


# convenience aliases for ls
alias ls='ls --color=auto'
#^ harvested from ubuntu's defaults

alias l='ls -lFh'
alias ll='ls -AlFh'
