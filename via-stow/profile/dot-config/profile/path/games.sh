# shellcheck shell=sh
# Game directories

for d in /usr/games /usr/local/games; do
  if [ -d "$d" ]; then
    case ":$PATH:" in
      *":$d:"*) ;;
      *) export PATH="${PATH:+$PATH:}$d" ;;
    esac
  fi
done
