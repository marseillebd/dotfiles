# shellcheck shell=sh

if [ -d "$HOME/.ghcup/bin" ]; then
  case ":$PATH:" in
    *:"$HOME/.ghcup/bin":*) ;;
    *) export PATH="${PATH:+$PATH:}$HOME/.ghcup/bin" ;;
  esac
fi
