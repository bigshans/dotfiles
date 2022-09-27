# setxkbmap -option ctrl:swapcaps
eval "$(zoxide init zsh)"
complete -W "update add config fix init remove wip break ignore typo refactor ui test" cm
_reload_complete=$(join ' ' "${scripts[@]}")
complete -W $_reload_complete reload
unset _reload_complete
