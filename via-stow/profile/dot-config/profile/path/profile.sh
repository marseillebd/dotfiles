# shellcheck shell=sh
# User-installed software

# executables
if [ -d "$HOME/.local/bin" ]; then
  case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *) export PATH="${PATH:+$PATH:}$HOME/.local/bin" ;;
  esac
fi

# libraries
# FIXME include the following:
#if [ -d $HOME/.local/lib ]; then
#    export LD_LIBRARY_PATH="$HOME/.local/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
#    export PKG_CONFIG_PATH="$HOME/.local/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
#fi
#if [ -d $HOME/.local/lib64 ]; then
#    export LD_LIBRARY_PATH="$HOME/.local/lib64${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
#    export PKG_CONFIG_PATH="$HOME/.local/lib64/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
#fi

# documentation
# TODO also consider MANPATH
