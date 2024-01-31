# set colors depending on terminal support
# TODO someday, I'd like to set these more semantically, and translate them into the appropriate color code/color space
# I'm going with hard-coded ANSI escape sequences.
# These have been around for a very long time, and apparently tput can be broken.
# Nevertheless, I am willing to change my mind if I do the appropriate research.
# But as long as they aren't broken for me, I'll likely not fix them myself.
case "${TERM}" in
  xterm|xterm-color|*-256color)
    __prompt_reset="\e[0m"
    __prompt_shell="\e[90m" # gray
    __prompt_failcode="\e[31m" # red
    __prompt_chroot="\e[1;33m" # bold; yellow
    __prompt_git="\e[33m" # yellow
    __prompt_userbox="\e[34m" # blue
    __prompt_pwd="\e[94m"
    __prompt_rootPS="\e[1;31m" # bold; red
    __prompt_PS1="\e[32m" # green
    __prompt_PS2="\e[1;32m" # bold; green
  ;;
  *)
  ;;
esac

########################################
###### Prompt-Rendering Utilities ######
########################################

# Print the previous commands exit code if non-zero
__prompt_failcode() (
  ec="$?"
  if [ $ec != 0 ]; then
    echo "<$ec>"
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


# always clear any color
PS1="\[$__prompt_reset\]"
# what shell is being run?
PS1+="\[$__prompt_shell\][bash]\[$__prompt_reset\]"
# show last exit code if non-zero
PS1+="\[$__prompt_failcode\]\$(__prompt_failcode)\[$__prompt_reset\]"
# chroot
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi
PS1+="\[$__prompt_chroot\]"'${debian_chroot:+(${debian_chroot})}'"\[$__prompt_reset\]"
# display current git branch
if [ "$USER" != 'root' ]; then
  PS1+="\[$__prompt_git\]\$(__prompt_gitstatus)\[$__prompt_reset\]"
fi
# user, host, and working directory
PROMPT_DIRTRIM=3
PS1+="\[$__prompt_userbox\]\u@\H:\[$__prompt_pwd\]\w\[$__prompt_reset\]"
# dollar or hash for prompt
if [ "$USER" = 'root' ]; then
  PS1+="\[$__prompt_rootPS1\]"\#"\[$__prompt_reset\]"
else
  PS1+="\[$__prompt_PS1\]$\[$__prompt_reset\]"
fi
# lebensraum
PS1+=" "


# always clear any color
PS2="\[$__prompt_reset\]"
# a simple caret is enough
if [ "$USER" = 'root' ]; then
  PS2+="\[$__prompt_rootPS\]"\#"\[$__prompt_reset\]"
else
  PS2+="\[$__prompt_PS2\]>\[$__prompt_reset\] "
fi
