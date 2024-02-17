# shellcheck shell=sh

if [ -d "$HOME/.cabal/bin" ]; then
  case ":$PATH:" in
    *:"$HOME/.cabal/bin":*) ;;
    *) export PATH="${PATH:+$PATH:}$HOME/.cabal/bin" ;;
  esac
fi
