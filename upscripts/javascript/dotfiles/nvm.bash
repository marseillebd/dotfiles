if [ -z "$XDG_CONFIG_HOME" ]; then
  export NVM_DIR="$HOME/.nvm"
else
  export NVM_DIR="$XDG_CONFIG_HOME/nvm"
fi

# This loads the nvm function
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
# And this activates the latest long-term release
nvm use lts/* >/dev/null
