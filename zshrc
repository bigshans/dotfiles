# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#!/bin/zsh

export PROJECT=$HOME/dotfiles
. $PROJECT/process/option/main.zsh
scripts=('plugin' 'function' 'alias' 'process')

[[ -f "$HOME/.config/shell/env.sh" ]] && . "$HOME/.config/shell/env.sh"

for proc in ${scripts[@]}
do
    . $PROJECT/process/hooks/pre_$proc/main.zsh
    . $PROJECT/process/$proc/main.zsh
    . $PROJECT/process/hooks/after_$proc/main.zsh
done

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi


# Load Angular CLI autocompletion.
source <(ng completion script)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
