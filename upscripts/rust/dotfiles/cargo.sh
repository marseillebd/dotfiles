# shellcheck shell=sh

if [ -d "$HOME/.local/cargo/bin" ]; then
  case ":$PATH:" in
    *":$HOME/.local/cargo/bin:"*) ;;
    *) export PATH="${PATH:+$PATH:}$HOME/.local/cargo/bin" ;;
  esac
fi
