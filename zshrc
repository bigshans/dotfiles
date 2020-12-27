# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
export NVM_LAY_LOAD=true
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
# zinit light-mode for \
    # zinit-zsh/z-a-rust \
    # zinit-zsh/z-a-as-monitor \
    # zinit-zsh/z-a-patch-dl \
    # zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# Or using OMZL:: shorthand:
DISABLE_MAGIC_FUNCTIONS=true
zinit ice lucid wait='0'
# zinit snippet OMZ::lib/clipboard.zsh
# zinit snippet OMZ::lib/completion.zsh
# zinit snippet OMZ::lib/history.zsh
# zinit snippet OMZ::lib/key-bindings.zsh
# zinit snippet OMZ::lib/git.zsh
# zinit snippet OMZ::lib/theme-and-appearance.zsh
# zinit snippet OMZ::plugins/compleat/compleat.plugin.zsh
# zinit snippet OMZL::functions.zsh
zinit light ohmyzsh/ohmyzsh

zinit light zsh-users/zsh-completions
# zinit light  marlonrichert/zsh-autocomplete 
zinit light skywind3000/z.lua
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light mafredri/zsh-async
# zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
# zinit light sindresorhus/pure
zinit ice depth=1 pick 'async.zsh';
zinit light romkatv/powerlevel10k
# zinit load lukechilds/zsh-nvm
zicompinit

source $HOME/dotfiles/user.zsh

bindkey '^x^c' "exit"

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export GOPROXY=https://mirrors.aliyun.com/goproxy/

# nvm() {
    # nvm $@
# }

if [ -z "$NVM_DIR" ]; then
    export NVM_DIR=$HOME/.nvm
    source /usr/share/nvm/nvm.sh
    source /usr/share/nvm/bash_completion
    source /usr/share/nvm/install-nvm-exec
fi
# nvm

export NODE_ENV='development'
# export HTTPS_PROXY=socks5://127.0.0.1:8888
export EDITOR="/usr/bin/vim"
export BROWSER="/usr/bin/firefox-developer-edition"
export GO111MODULE=on
export GOPROXY="https://goproxy.io"
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
export ELECTRON_MIRROR=http://npm.taobao.org/mirrors/electron/

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# begin appcenter completion
# . <(appcenter --completion)
# end appcenter completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/aerian/.sdkman"
[[ -s "/home/aerian/.sdkman/bin/sdkman-init.sh" ]] && source "/home/aerian/.sdkman/bin/sdkman-init.sh"
