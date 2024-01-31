#!/bin/sh
set -e

if [ -z "$1" ]; then
  echo >&2 "usage: $0 <filepath>"
  exit 1
fi
profile="$1"

# TODO ensure all dependencies are available, and in the right order

###################################################
###### prepare upup tools for use by scripts ######
###################################################


export UPUP_BINDIR="${HOME}/.local/bin"
export UPUP_CONFIGDIR="${XDG_CONFIG_HOME:-${HOME}/.config}"
export UPUP_BUILDDIR="${HOME}/.local/.build"

# use the system package manager to install
# WARNING this assumes the package name is consistent across different package managers
UPUP_viasudo() {
  if command -v apt-get >/dev/null; then
    sudo apt-get install -y "$@"
  else
    echo >&2 "did not recognize system package manager"
    return 1
  fi
}

UPUP_ln() (
  src="$1"
  dst="$2"
  if [ -z "$src" ]; then
    echo >&2 "$0: requires source file"
  fi
  if [ -z "$dst" ]; then
    echo >&2 "$0: requires destination location"
  fi
  if [ -d "$dst" ]; then
    dst="${dst%/}/$(basename "$src")"
  fi
  if [ "$(realpath "$src")" = "$(realpath "$dst")" ]; then
    echo >&2 "'$dst' == '$src'"
  else
    ln --backup=numbered -sv "$1" "$2"
  fi
)

#################################################
###### execute all installs and configures ######
#################################################

(
  # shellcheck disable=SC2002
  cat "$profile" | while read -r req; do
    case "$req" in */*) continue ;; esac
    short="${req%%-*}"
    (
      echo >&2 "################## installing $short ##################"
      if [ ! -d "upscripts/$short" ]; then
        echo >&2 "unknown upscript: $short"
        exit 1
      fi
      cd "upscripts/$short"
      (
        echo >&2 '### install ###'
        # shellcheck disable=SC1090
        . "./$req.sh"
      )
      if [ -f "./config.sh" ]; then
        (
          echo >&2 '### configure ###'
          # shellcheck disable=SC1091
          . "./config.sh"
        )
      fi
      echo >&2 "### setup ok: $short ###"
      if [ -f "./activate.sh" ]; then
        echo >&2 '### activate ###'
        # shellcheck disable=SC1091
        . "./activate.sh"
      fi
      echo >&2 "### OK: $short ###"
    )
    if [ $? -gt 0 ]; then
      echo >&2 "################## setup FAILED: $short ##################"
      return 1
    fi
  done

  # shellcheck disable=SC2002
  cat "$profile" | while read -r req; do
    case "$req" in
      */*)
        plug="${req%%/*}"
        base="${req#*/}"
      ;;
      *) continue ;;
    esac
    echo "################## integrating $plug into $base ##################"
    if (
      if [ -f "upscripts/$plug/integrations/$base/config.sh" ]; then
        echo >&2 '### configure ###'
        cd "upscripts/$plug/integrations/$base"
        # shellcheck disable=SC1091
        . "./config.sh"
      fi
    ); then
      echo >&2 "### OK: $base/$plug ###"
    else
      echo >&2 "################## integration FAILED: $base/$plug ##################"
      return 1
    fi
  done
  echo >&2 '################## SETUP SUCCESSFUL ##################'
)
if [ $? -gt 0 ]; then
    echo >&2 "################## SETUP FAILED ##################"
    return 1
fi

#######################################################
###### activate all changes in the current shell ######
#######################################################

# shellcheck disable=SC2002
cat "$profile" | while read -r req; do
  # TODO activate integrations differently
  short="${req%%-*}"
  if [ -f "upscripts/$short/activate.sh" ]; then
    # shellcheck disable=SC1090
    . "upscripts/$short/activate.sh"
    echo >&2 "### $short ACTIVE ###"
  fi
done
echo >&2 '##########################################'
echo >&2 '################## NOTE ##################'
echo >&2 '##########################################'
echo >&2 "Interactive applications will need to have their configuration reloaded."
