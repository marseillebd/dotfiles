# shellcheck shell=sh

###### cd ######

# make and enter directory is such a common operation
mkcd() { mkdir "$1" && cd "$1"; }
gitcd() { git clone "$1" && cd "${1##*/}"; }

# say ysap do this to make going up directories really easy
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

###### ln ######

# verbose ln gives more feedback
alias ln='ln -v'
# TODO an alias for relative symlinks

###### ls ######

# convenience aliases for ls
alias ls='ls --color=auto'
#^ harvested from ubuntu's defaults

alias l='ls -lFh'
alias ll='ls -AlFh'

# TODO harvested from ubuntu's defaults
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
