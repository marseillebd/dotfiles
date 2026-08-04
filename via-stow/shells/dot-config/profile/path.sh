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
  local dir
  dir="$1"
  [ -d "$dir" ] || return
  case ":$PATH:" in
    *":$dir:"*) return ;; # directory is already on the path
  esac
  export PATH="${PATH:+$PATH:}$dir"
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
__binpathadd "$HOME/.local/bin"

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

