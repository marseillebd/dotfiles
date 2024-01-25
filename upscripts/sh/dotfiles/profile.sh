# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# User-installed software
if [ -d "$HOME/.local/bin" ]; then
  if [ ! ":$PATH:" = *":$HOME/.local/bin:"* ]; then
    export PATH="${PATH:+$PATH:}$HOME/.local/bin"
  fi
fi
# FIXME include the following:
#if [ -d $HOME/.local/lib ]; then
#    export LD_LIBRARY_PATH="$HOME/.local/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
#    export PKG_CONFIG_PATH="$HOME/.local/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
#fi
#if [ -d $HOME/.local/lib64 ]; then
#    export LD_LIBRARY_PATH="$HOME/.local/lib64${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
#    export PKG_CONFIG_PATH="$HOME/.local/lib64/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
#fi
# TODO also consider MANPATH

# XDG Base Directories
# some programs require these to be set in order to use the defaults
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
      . "$HOME/.bashrc"
    fi
fi

