# shellcheck shell=sh

export CARGO_HOME="$HOME/.local/cargo"

if [ -d "$CARGO_HOME/bin" ]; then
  case ":$PATH:" in
    *":$CARGO_HOME/bin:"*) ;;
    *) export PATH="${PATH:+$PATH:}$CARGO_HOME/bin" ;;
  esac
fi
