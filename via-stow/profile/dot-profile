# shellcheck shell=sh

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# WARNING the path given here must agree with the config path given in xdg.sh
confdir="${XDG_CONFIG_HOME:-$HOME/.config}"

# Set up XDG base directories.
if [ -f "$confdir/profile/xdg.sh" ]; then
  # shellcheck disable=SC1090
  . "$confdir/profile/xdg.sh"
fi

# Adjust path and path-like environment variables
for rc in "${confdir}/profile/path"/*.sh; do
  [ -f "$rc" ] || continue
  # shellcheck disable=SC1090
  . "$rc"
done

unset confdir
