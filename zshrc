#!/bin/zsh

export PROJECT=$HOME/dotfiles
. $PROJECT/process/option/main.zsh
scripts=('plugin' 'env' 'function' 'alias' 'process')

for proc in ${scripts[@]}
do
    . $PROJECT/process/hooks/pre_$proc/main.zsh
    . $PROJECT/process/$proc/main.zsh
    . $PROJECT/process/hooks/after_$proc/main.zsh
done
