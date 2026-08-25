# shellcheck shell=sh

##################################
###### Set up XDG variables ######
##################################

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

##########################
###### PATH Helpers ######
##########################

__binpathadd() {
  case "$1" in
    -f) __binpathadd_f=1; shift ;;
    *)  __binpathadd_f=0        ;;
  esac
  __binpathadd_dir="$1"
  [ -d "$__binpathadd_dir" ] || return
  case ":$PATH:" in
    *":$__binpathadd_dir:"*) return ;; # directory is already on the path
  esac
  if [ "$__binpathadd_f" = 1 ]; then
    export PATH="$__binpathadd_dir${PATH:+:$PATH}"
  else
    export PATH="${PATH:+$PATH:}$__binpathadd_dir"
  fi
}

#######################
###### Add Paths ######
#######################

# Add sbin directories to PATH.  This is useful on systems that have sudo
__binpathadd /sbin
__binpathadd /usr/sbin

# Game directories
# for d in /usr/games /usr/local/games; do
#   __binpathadd "$d"
# done

# User-installed software
__binpathadd -f "$HOME/.local/bin"
__binpathadd -f "$HOME/.ghcup/bin" # haskell

# libraries
# FIXME include the following:
#if [ -d $HOME/.local/lib ]; then
#    export LD_LIBRARY_PATH="$HOME/.local/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
#    export PKG_CONFIG_PATH="$HOME/.local/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
#fi
#if [ -d $HOME/.local/lib64 ]; then
#    export LD_LIBRARY_PATH="$HOME/.local/lib64${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
#    export PKG_CONFIG_PATH="$HOME/.local/lib64/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
#fi

# documentation
# TODO also consider MANPATH

