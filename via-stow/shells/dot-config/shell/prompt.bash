# shellcheck shell=bash

# set colors depending on terminal support
# TODO someday, I'd like to set these more semantically, and translate them into the appropriate color code/color space
# I'm going with hard-coded ANSI escape sequences.
# These have been around for a very long time, and apparently tput can be broken.
# Nevertheless, I am willing to change my mind if I do the appropriate research.
# But as long as they aren't broken for me, I'll likely not fix them myself.
case "${TERM}" in
  xterm|xterm-color|*-256color|xterm-kitty)
    __prompt_color=yes ;;
esac

if [ "$__prompt_color" = yes ]; then

    red='\[\e[0;31m\]'
    RED='\[\e[1;31m\]'
    # shellcheck disable=SC2034
    green='\[\e[0;32m\]'
    GREEN='\[\e[1;32m\]'
    yellow='\[\e[0;33m\]'
    YELLOW='\[\e[1;33m\]'
    # shellcheck disable=SC2034
    blue='\[\e[0;34m\]'
    BLUE='\[\e[1;34m\]'
    purple='\[\e[0;35m\]'
    # shellcheck disable=SC2034
    PURPLE='\[\e[1;35m\]'
    cyan='\[\e[0;36m\]'
    # shellcheck disable=SC2034
    CYAN='\[\e[1;36m\]'
    grey='\[\e[0;90m\]'
    GREY='\[\e[1;90m\]'
    nc='\[\e[0m\]'

    __prompt_reset="$nc"
    __prompt_shell="$GREY"
    __prompt_failcode="$red"
    __prompt_chroot="$YELLOW"
    __prompt_nix_shell="$YELLOW"
    __prompt_git="$yellow"
    __prompt_box="$purple"
    __prompt_user="$purple"
    __prompt_pwd="$BLUE"
    __prompt_runningjob="$grey"
    __prompt_stoppedjob="$cyan"
    if [ "$UID" = 0 ]; then
      __prompt_sigil="$RED"
    else
      __prompt_sigil="$GREEN"
    fi

    unset red
    unset RED
    unset blue
    unset BLUE
    unset cyan
    unset CYAN
    unset green
    unset GREEN
    unset yellow
    unset YELLOW
    unset purple
    unset PURPLE
    unset nc

fi

########################################
###### Prompt-Rendering Utilities ######
########################################

# Print the previous commands exit code if non-zero
__prompt_failcode() (
  if [ "$__prompt_ec" != 0 ]; then
    echo "<$__prompt_ec>"
  fi
)

__prompt_gitstatus() (
  # preserve last exitcode by running in a subshell
  # `return` isn't good enough, so I have to use `exit`
  # TODO could probably put more effort in to both do the thing and exit with the right code
  ec=$?
  if [ -z $ec ]; then exit $ec; fi

  if git rev-parse --git-dir >/dev/null 2>&1; then
      branch="$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"

      # if last fetch was over  an hour ago, update remotes
      if command -v gitstat >/dev/null 2>&1; then
          gitstat -d'1 hour ago' || git remote update >/dev/null 2>/dev/null &
      fi

      symbol=''
      # if remote master has commits that local branch is missing, be sure to rebase
      if [ "$branch" != "master" ]; then
          if ( git show-branch "origin/master" "$branch" 2>/dev/null | tail -n+4 | grep -q '^[^ ] ' ); then
              symbol+=⇓
          fi
      fi
      # if remote branch has commits that local branch is missing, be sure to pull
      if ( git show-branch "origin/$branch" "$branch" 2>/dev/null | tail -n+4 | grep -q '^[^ ] ' ); then
          symbol+=↓
      fi
      # if the origin branch is missing commits that local branch has, be sure to push
      if ( git show-branch "origin/$branch" "$branch" 2>/dev/null | tail -n+4 | grep -q '^ [^ ]' ); then
          symbol+=↑
      fi

      st="$(git status --porcelain)"
      # untracked files reported as `!`
      if echo "$st" | grep -q '^??'; then symbol+='!'; fi
      # unstaged files reported as `*`
      if echo "$st" | grep -q '^ M'; then symbol+='*'; fi

      echo "(${symbol}${branch})"
  fi
)

###############################
###### The Prompt Itself ######
###############################

__prompt_command() {
  # capture previous exit code
  __prompt_ec=$?
}
PROMPT_COMMAND='__prompt_command'

# always clear any color
PS1="$__prompt_reset"

# identify any special environments you might be in
# so far: chroot, nix shell
# TODO: virtualenv ig?
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi
PS1+="$__prompt_chroot"'${debian_chroot:+(${debian_chroot})}'"$__prompt_reset"
# nix development shell
PS1+="$__prompt_nix_shell"'${IN_NIX_SHELL:+(nix:${IN_NIX_SHELL})}'"$__prompt_reset"

# display current git information
if [ "$USER" != 'root' ]; then
  PS1+="$__prompt_git\$(__prompt_gitstatus)$__prompt_reset"
fi

# user, host, and working directory
# PROMPT_DIRTRIM=3 # TODO I might reconsider this
PS1+=" $__prompt_user\u$__prompt_reset"
PS1+="@$__prompt_box\H$__prompt_reset"
PS1+=":$__prompt_pwd\w$__prompt_reset"

# I like mx linux's default prompt being split across two lines
PS1+="\\n"

# note the previous commands exit code, if unsuccessful
PS1+="$__prompt_failcode\$(__prompt_failcode)$__prompt_reset"

# output any running jobs
PS1+="$__prompt_stoppedjob\$(jobs | awk '/Stopped/{print \"[\" \$3 \"]\"}' | tr -d $'\n')$__prompt_reset"
PS1+="$__prompt_runningjob\$(jobs | awk '/Running/{print \"[\" \$3 \"]\"}' | tr -d $'\n')$__prompt_reset"
# what shell is being run?
PS1+="${__prompt_shell}[bash]$__prompt_reset"

# dollar or hash for prompt
if [ "$USER" = 'root' ]; then
  PS1+="$__prompt_sigil"\#"$__prompt_reset"
else
  PS1+="$__prompt_sigil"\$"$__prompt_reset"
fi
# lebensraum
PS1+=" "


# always clear any color
PS2="$__prompt_reset"
# a simple caret is enough
PS2+="$__prompt_sigil>$__prompt_reset "
