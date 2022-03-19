# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz compinit
compinit
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt
bindkey '^x^c' "exit"

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export GOPROXY=https://mirrors.aliyun.com/goproxy/
# 配置 GOPROXY 环境变量
# export GOPROXY=https://goproxy.io,direct
export GOPROXY=https://goproxy.cn
# 还可以设置不走 proxy 的私有仓库或组，多个用逗号相隔（可选）
# export GOPRIVATE=git.mycompany.com,github.com/my/private

# nvm() {
    # nvm $@
# }

eval "$(zoxide init zsh)"
eval "$(mcfly init zsh)"
export NODE_ENV='development'
# export HTTPS_PROXY=socks5://127.0.0.1:8888
export EDITOR="/usr/bin/nvim"
# export BROWSER="/usr/bin/firefox-developer-edition"
export BROWSER="/usr/bin/firefox-nightly"
export GO111MODULE=on
# export GOPROXY="https://goproxy.io"
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
IN=$(gem env gempath)
ps=(`echo $IN | tr ':' ' '`)
for p in ${ps[@]}
do
    p=$p/bin
    export PATH=$p:$PATH
done
export ANDROID_SDK_ROOT=/mnt/disk/Android
export ANDROID_HOME=/mnt/disk/Android/
export ELECTRON_MIRROR=https://npmmirror.com/mirrors/electron/
# Add Local Script
export PATH=$PATH:$HOME/dotfiles/scripts
export PATH=$PATH:$HOME/.local/bin

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# begin appcenter completion
# . <(appcenter --completion)
# end appcenter completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export PATH=$HOME/.emacs.d/bin:$PATH
# [[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn
# export PATH=/opt/graalvm-ce-java11-21.0.0.2/bin:$PATH
# export JAVA_HOME=/opt/graalvm-ce-java11-21.0.0.2
export PATH=~/.npm-global/bin:$PATH
export SONAR_SCANNER_HOME="/opt/sonar-scanner"
export PATH="${PATH}:${SONAR_SCANNER_HOME}/bin"
export PATH=${PATH}:$HOME/.cargo/bin
. $HOME/dotfiles/user.zsh
export METALS_JAVA_OPTS='-XX:+UseG1GC -XX:+UseStringDeduplication -Xss4m -Xms100m'

[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/nvm.sh >/dev/null 2>&1
source /usr/share/nvm/bash_completion > /dev/null 2>&1
source /usr/share/nvm/install-nvm-exec >/dev/null 2>&1
# nvm

$HOME/dotfiles/scripts/ctrlCaps
export QT_AUTO_SCREEN_SCALE_FACTOR=1
