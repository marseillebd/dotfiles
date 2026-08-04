# I don't want to maintain two configuration files.
# Thus, we defer to .bashrc for startup regardless of how I get to an interactive bash shell.
if [[ -f "~/.bashrc" ]]; then
  . "$HOME/.bashrc"
# My .bashrc will itself defer to .profile, so my bash startup is an extension of my sh startup.
# However, if .bashrc somehow doesn't exist, then we should still extend the sh startup.
elif [[ -f "$HOME/.profile" ]]; then
  . "$HOME/.profile"
fi

# Here we put anything that should be run _only_ on login.
# Login could mean loggin in from a bare console (no desktop environment),
# or it could be when I ssh into the box.
# I basically don't care about anything extra when I sit down to the box the first time:
# I know what box I'm at via my `$PS1` (or what keyboard I'm using).

# Installers keep wanting to add stuff directly to my version-controlled dotfiles.
# They should all stop it!
# Thankfully, they seem to just append stuff, so it's easy to detect after the fact.
# NOTHING BEYOND THIS POINT
