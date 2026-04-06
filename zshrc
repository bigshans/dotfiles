# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#!/bin/zsh

export PROJECT=$HOME/dotfiles

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

[[ -f "$PROJECT/zsh/plugins.zsh" ]] && . "$PROJECT/zsh/plugins.zsh"
[[ -f "$HOME/.config/shell/env.sh" ]] && . "$HOME/.config/shell/env.sh"
[[ -f "$PROJECT/alias.sh" ]] && . "$PROJECT/alias.sh"
[[ -f "$PROJECT/zsh/options.zsh" ]] && . "$PROJECT/zsh/options.zsh"
[[ -f "$PROJECT/zsh/zsh-alias.sh" ]] && . "$PROJECT/zsh/zsh-alias.sh"

for func_file in $PROJECT/zsh/functions/*.zsh; do
    source $func_file
done

eval "$(zoxide init zsh)"
complete -W "update add config fix init remove wip break ignore typo refactor ui test" cm
complete -W "plugin function process" reload

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load Angular CLI autocompletion.
source <(ng completion script)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
