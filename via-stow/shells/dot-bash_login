# An interactive login shell looks here if it can't find `~/.bash_profile`.
# It is much less well-known, so using one increases complexity.
# Still, if the `~/.bash_profile` goes missing, I've included this.
# It merely deleagtes to other startup scripts.

if [[ -f "~/.bash_profile" ]]; then
  . "$HOME/.bash_profile"
elif [[ -f "~/.bashrc" ]]; then
  . "$HOME/.bashrc"
# My .bashrc will itself defer to .profile, so my bash startup is an extension of my sh startup.
# However, if .bashrc somehow doesn't exist, then we should still extend the sh startup.
elif [[ -f "$HOME/.profile" ]]; then
  . "$HOME/.profile"
fi

# Installers keep wanting to add stuff directly to my version-controlled dotfiles.
# They should all stop it!
# Thankfully, they seem to just append stuff, so it's easy to detect after the fact.
# NOTHING BEYOND THIS POINT
