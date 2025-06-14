# shellcheck shell=bash

# The first thing I want to do is ensure my bash environment is an extension of my sh environment.
# Thus, we being by sourcing `~/.profile`, which does the startup for sh.
if [[ -f "$HOME/.profile" ]]; then
  # shellcheck disable=SC1090
  . "$HOME/.profile"
fi

# The rest of the startup is useful for interactive shells only.
# Scripts will not benefit from them, and indeed may have their behavoir unexpectedly altered.
# If not running interactively, don't do anything.
case "$-" in
  *i*)
    confdir="${XDG_CONFIG_HOME:-$HOME/.config}"

    # Adjust path and path-like environment variables
    # but only for bash-specific tooling
    for rc in "${confdir}/bash/path/"*.bash; do
      [ -f "$rc" ] || continue
      # shellcheck disable=SC1090
      . "$rc"
    done

    # setup programmable completion
    # each program should put its completions in its own file
    if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
            # shellcheck disable=SC1091
            . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
            # shellcheck disable=SC1091
            . /etc/bash_completion
        fi
        for rc in "${confdir}/"{shell,bash}"/completion"/*.bash; do
          [ -f "$rc" ] || continue
          # shellcheck disable=SC1090
          . "$rc"
        done
    fi

    # set up any color configuration
    case "${TERM}" in
      xterm|xterm-color|*-256color)
        for rc in "${confdir}/"{shell,bash}"/color"/*.{sh,bash}; do
          [ -f "$rc" ] || continue
          # shellcheck disable=SC1090
          . "$rc"
        done
        ;;
    esac

    # configure shell features (history, prompt, &c)
    for rc in "${confdir}/"{shell,bash}"/rc"/*.{sh,bash}; do
      [ -f "$rc" ] || continue
      # shellcheck disable=SC1090
      . "$rc"
    done

    # set up aliases last so that they don't interfere with other setup actions
    # also sets up utility functions, and programs that integrate with the shell
    # each program should go in its own file
    for rc in "${confdir}/"{shell,bash}"/alias"/*.{sh,bash}; do
      [ -f "$rc" ] || continue
      # shellcheck disable=SC1090
      . "$rc"
    done
    unset confdir
    ;;
esac

# Installers keep wanting to add stuff directly to my version-controlled dotfiles.
# They should all stop it!
# Thankfully, they seem to just append stuff, so it's easy to detect after the fact.
# NOTHING BEYOND THIS POINT
