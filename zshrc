source $HOME/.antigen/antigen.zsh
source $HOME/dotfiles/user.zsh

antigen use oh-my-zsh

antigen bundle git

antigen bundle zdharma/fast-syntax-highlighting

antigen bundle zsh-users/zsh-completions

antigen bundle zsh-users/zsh-autosuggestions

antigen theme mira

antigen apply

bindkey '^x^c' "exit"
