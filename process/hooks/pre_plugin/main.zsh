# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  # source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

eval "$(starship init zsh)"

antidote=$PROJECT/bundle

PLUGINS=""

start_plug () {
    PLUGINS=""
}

plug () {
    PLUGINS=$PLUGINS"\n"$1
}

end_plug () {
    plugin_text=$(cat ~/.zsh_plugins.txt)
    complied=$antidote/plugin.zsh
    if [[ ! $plugin_text -nt $PLUGINS ]]; then
        source $antidote/antidote/antidote.zsh
        echo $PLUGINS > ~/.zsh_plugins.txt
        antidote bundle < ~/.zsh_plugins.txt > $complied
    fi
    source $complied
    unset PLUGINS complied
}
