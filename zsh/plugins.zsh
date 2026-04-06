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

WHITELIST_OMZ=(
    completion
    correction
    key-bindings
    history
    directories
    git
)

start_plug

plug "bigshans/ohmyzsh"
plug "zsh-users/zsh-autosuggestions"
plug "Aloxaf/fzf-tab"
plug "zdharma-continuum/fast-syntax-highlighting"
plug "mfaerevaag/wd"

end_plug

unset start_plug plug end_plug WHITELIST_OMZ
