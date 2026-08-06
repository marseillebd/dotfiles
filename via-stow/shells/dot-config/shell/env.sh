# shellcheck shell=sh

#################################
###### The Terminal Itself ######
#################################

# needed so that vim can use ^s and ^q, rather than them getting intercepted for stop/resume
# after all, why would I need ^s when ^z would background it as well
stty -ixon

##########################
###### Default Apps ######
##########################

# Drawn from https://bash.cyberciti.biz/guide/%24VISUAL_vs._%24EDITOR_variable_%E2%80%93_what_is_the_difference%3F
# - The `EDITOR` "must work without advanced terminal functionality".
#   That means `ed` or `ex`.
# - Otoh, `VISUAL` is used by all modern apps and terminals.
#   It can (and probably should) be a full-screen editor.
# - On a modern Unix-like system, set them both to the same "advanced" editor.
#   This is _unlikely_ to cause a problem. Otoh, some tools don't think to look for `VISUAL`.
# - Almost all modern apps look for `VISUAL` first, then `EDITOR`.

# TODO I suppose if I wanted to get fancy, I could specify a dir where each file hols an editor and the editors it's preferred over.
# Then, cat those files together, tsort, and take the last.
if command -v vim >/dev/null 2>&1; then
  export VISUAL=vim
elif command -v vi >/dev/null 2>&1; then
  export VISUAL=vi
elif command -v nano >/dev/null 2>&1; then
  export VISUAL=nano
fi

if [ -n "$VISUAL" ]; then
  export EDITOR="$VISUAL"
fi

# sudo specified that the value of SUDO_EDITOR is searched before VISUAL or EDITOR
if [ -n "$SUDO_EDITOR" ]; then
  export SUDO_EDITOR="$VISUAL"
fi

##################
###### less ######
##################

# make less more friendly for non-text input files, see lesspipe(1)
if [ -x /usr/bin/lesspipe ]; then
  eval "$(SHELL=/bin/sh lesspipe)"
fi

# Default parameter to send to the "less" command
# -R: show ANSI colors correctly; -i: case insensitive search
[ -z "$LESS" ] && export LESS="-R -i"

#################
###### gcc ######
#################

# TODO harvested from ubuntu's defaults
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

################
###### ls ######
################

# TODO harvested from ubuntu's defaults
if command -v dircolors >/dev/null ; then
  if [ -r "${HOME}/.dircolors" ]; then
    eval "$(dircolors -b "${HOME}/.dircolors")"
  else
    eval "$(dircolors -b)"
  fi
fi
