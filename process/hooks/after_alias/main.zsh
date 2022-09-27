eval $(thefuck --alias)

# to fix kitty ssh
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="kitty +kitten ssh"
