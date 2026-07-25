# shellcheck shell=sh

# Drawn from https://bash.cyberciti.biz/guide/%24VISUAL_vs._%24EDITOR_variable_%E2%80%93_what_is_the_difference%3F
# - The `EDITOR` "must work without advanced terminal functionality".
#   That means `ed` or `ex`.
# - Otoh, `VISUAL` is used by all modern apps and terminals.
#   It can (and probably should) be a full-screen editor.
# - On a modern Unix-like system, set them both to the same "advanced" editor.
#   This is _unlikely_ to cause a problem. Otoh, some tools don't think to look for `VISUAL`.
# - Almost all modern apps look for `VISUAL` first, then `EDITOR`.

# TODO I suppose if I wanted to get fancy, I could specify a dir where each file hols an editor and the editors it's preferred over.
# Then, cat those files together, tsort, and take the last.
if command -v vim >/dev/null 2>&1; then
  export VISUAL=vim
elif command -v vi >/dev/null 2>&1; then
  export VISUAL=vi
elif command -v nano >/dev/null 2>&1; then
  export VISUAL=nano
fi

if [ -n "$VISUAL" ]; then
  export EDITOR="$VISUAL"
fi
