# shellcheck shell=bash

# set colors depending on terminal support
# TODO someday, I'd like to set these more semantically, and translate them into the appropriate color code/color space
# I'm going with hard-coded ANSI escape sequences.
# These have been around for a very long time, and apparently tput can be broken.
# Nevertheless, I am willing to change my mind if I do the appropriate research.
# But as long as they aren't broken for me, I'll likely not fix them myself.
case "${TERM}" in
  xterm|xterm-color|*-256color|xterm-kitty)
    __ps_color=yes ;;
esac

if [ "$__ps_color" = yes ]; then

    # shellcheck disable=SC2034
    red='\[\e[0;31m\]'
    RED='\[\e[1;31m\]'
    # shellcheck disable=SC2034
    green='\[\e[0;32m\]'
    GREEN='\[\e[1;32m\]'
    yellow='\[\e[0;33m\]'
    YELLOW='\[\e[1;33m\]'
    blue='\[\e[0;34m\]'
    # shellcheck disable=SC2034
    BLUE='\[\e[1;34m\]'
    purple='\[\e[0;35m\]'
    PURPLE='\[\e[1;35m\]'
    cyan='\[\e[0;36m\]'
    # shellcheck disable=SC2034
    CYAN='\[\e[1;36m\]'
    grey='\[\e[0;90m\]'
    GREY='\[\e[1;90m\]'
    nc='\[\e[0m\]'

    __ps_reset="$nc"
    __ps_shell="$GREY"
    __ps_failcode="$RED"
    __ps_chroot="$YELLOW"
    __ps_nix_shell="$YELLOW"
    __ps_git="$yellow"
    __ps_box="$purple"
    __ps_at="$PURPLE"
    __ps_user="$purple"
    __ps_colon="$PURPLE"
    __ps_pwd="$blue"
    __ps_runningjob="$grey"
    __ps_stoppedjob="$cyan"
    if [ "$UID" = 0 ]; then
      __ps_sigil="$RED"
    else
      __ps_sigil="$GREEN"
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
__ps_failcode() (
  if [ "$__ps_ec" != 0 ]; then
    echo "<$__ps_ec>"
  fi
)

__ps_gitstatus() (
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

      echo "(${symbol}${branch}) "
  fi
)

###############################
###### The Prompt Itself ######
###############################

__ps_command() {
  # capture previous exit code
  __ps_ec=$?
}
PROMPT_COMMAND='__ps_command'

# always clear any color
PS1="$__ps_reset"

# identify any special environments you might be in
# so far: chroot, nix shell
# TODO: virtualenv ig?
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi
PS1+="$__ps_chroot"'${debian_chroot:+(${debian_chroot})}'"$__ps_reset"
# nix development shell
PS1+="$__ps_nix_shell"'${IN_NIX_SHELL:+(nix:${IN_NIX_SHELL})}'"$__ps_reset"

# display current git information
if [ "$USER" != 'root' ]; then
  PS1+="$__ps_git\$(__ps_gitstatus)$__ps_reset"
fi

# user, host, and working directory
# PROMPT_DIRTRIM=3 # TODO I might reconsider this
PS1+="$__ps_user\u$__ps_reset"
PS1+="$__ps_at@$__ps_box\H$__ps_reset"
PS1+="$__ps_colon:$__ps_pwd\w$__ps_reset"

# I like mx linux's default prompt being split across two lines
PS1+="\\n"

# note the previous commands exit code, if unsuccessful
PS1+="$__ps_failcode\$(__ps_failcode)$__ps_reset"

# output any running jobs
PS1+="$__ps_stoppedjob\$(jobs | awk '/Stopped/{print \"[\" \$3 \"]\"}' | tr -d $'\n')$__ps_reset"
PS1+="$__ps_runningjob\$(jobs | awk '/Running/{print \"[\" \$3 \"]\"}' | tr -d $'\n')$__ps_reset"
# what shell is being run?
PS1+="${__ps_shell}[bash]$__ps_reset"

# dollar or hash for prompt
if [ "$USER" = 'root' ]; then
  PS1+="$__ps_sigil"\#"$__ps_reset"
else
  PS1+="$__ps_sigil"\$"$__ps_reset"
fi
# lebensraum
PS1+=" "


# always clear any color
PS2="$__ps_reset"
# a simple caret is enough
PS2+="$__ps_sigil>$__ps_reset "
