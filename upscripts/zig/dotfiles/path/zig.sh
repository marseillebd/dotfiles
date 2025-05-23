# shellcheck shell=sh

if [ -d "$HOME/.local/zig" ]; then
  case ":$PATH:" in
    *:"$HOME/.local/zig":*) ;;
    *) export PATH="${PATH:+$PATH:}$HOME/.local/zig" ;;
  esac
fi
