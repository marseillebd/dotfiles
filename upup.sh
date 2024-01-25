#!/bin/sh
set -e

profile="$1"

# TODO ensure all dependencies are available, and in the right order

{
  echo '#!/bin/sh'
  echo 'set -e'
  echo ''

  echo '#################################################'
  echo '###### execute all installs and configures ######'
  echo '#################################################'
  echo '('

  for req in $(cat "$profile"); do
    short="${req%%-*}"
    echo "###### $short ######"
    echo '( ### install ###'
    echo "echo >&2 '################## installing $short ##################'"
    echo "cd 'upscripts/$short'"
    cat "upscripts/$short/$req.sh"
    echo ')'
    if [ -f "upscripts/$short/config.sh" ]; then
      echo '( ### configure ###'
      echo "cd 'upscripts/$short'"
      cat "upscripts/$short/config.sh"
      echo ')'
    fi
    if [ -f "upscripts/$short/activate.sh" ]; then
      echo '### activate ###'
      cat "upscripts/$short/activate.sh"
    fi
    echo "echo >&2 '################## $short OK ##################'"
    echo ''
  done
  echo "echo >&2 '################## INSTALL SUCCESSFUL ##################'"

  echo ') # END: execute all installs and configures'
  echo ''

  echo '#######################################################'
  echo '###### activate all changes in the current shell ######'
  echo '#######################################################'
  echo 'set +e'
  for req in $(cat "$profile"); do
    short="${req%%-*}"
    if [ -f "upscripts/$short/activate.sh" ]; then
      echo "###### $short ######"
      cat "upscripts/$short/activate.sh"
      echo "echo >&2 '### $short ACTIVE ###'"
    else
      echo "echo >&2 '### $short OK ###'"
    fi
  done
} >"dist/upscript-$(basename "$1")"
chmod +x "dist/upscript-$(basename "$1")"

