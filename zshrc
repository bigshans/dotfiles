# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#!/bin/zsh

export PROJECT=$(pwd)/dotfiles
. $PROJECT/process/option/main.zsh
scripts=('plugin' 'env' 'function' 'alias')

for proc in ${scripts[@]}
do
    . $PROJECT/process/hooks/pre_$proc/main.zsh
    . $PROJECT/process/$proc/main.zsh
    . $PROJECT/process/hooks/after_$proc/main.zsh
done

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
