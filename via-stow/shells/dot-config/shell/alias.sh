# shellcheck shell=sh

###### cd ######

# make and enter directory is such a common operation
mkcd() { mkdir "$1" && cd "$1" || return 1; }
gitcd() { git clone "$1" && cd "${1##*/}" || return 1; }

# FIXME this is not getting loaded in sh, nor is it parsing in sh
# got from a youtube comment by Zeutomehr on yasp's video on improving cd
__dotdot() {
  for __dotdot_i in $(seq 1 "${1:-1}"); do
    __dotdot_dir="$__dotdot_dir"../
  done
  cd "$__dotdot_dir" || return 1
}
# and I saw multiple dots somewhere as a shortcut
alias ..='__dotdot'
alias ...='.. 2'
alias ....='.. 3'

# pushd is too long to bother with
alias pd='pushd'
# popd is ok, but is helped by the fact we've already pushed; still going to shorten it
# `ud` for "Undo Directory"
alias ud='popd'
# display directory stack one-per-line and with a depth, for readability
alias dirs='dirs -p -v'

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
alias la='ls -alFh'

# TODO harvested from ubuntu's defaults
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

###### vim ######

alias v=vim
alias vi=vim

###### docker ######

alias docker='sudo docker'
