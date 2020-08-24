source $HOME/.antigen/antigen.zsh
source $HOME/dotfiles/user.zsh

antigen use oh-my-zsh

antigen bundle git

antigen bundle skywind3000/z.lua

antigen bundle zdharma/fast-syntax-highlighting

antigen bundle zsh-users/zsh-completions

antigen bundle zsh-users/zsh-autosuggestions

# antigen theme mira

antigen bundle mafredri/zsh-async

antigen bundle sindresorhus/pure

antigen bundle pure

antigen apply

bindkey '^x^c' "exit"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export GOPROXY=https://mirrors.aliyun.com/goproxy/

[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/nvm.sh
source /usr/share/nvm/bash_completion
source /usr/share/nvm/install-nvm-exec
export NODE_ENV='development'
# export HTTPS_PROXY=socks5://127.0.0.1:8888
export EDITOR="/usr/bin/vim"
export GO111MODULE=on
export GOPROXY="https://goproxy.io"
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
export ANDROID_ROOT=$HOME/Android/Sdk
