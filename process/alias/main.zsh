ALIAS_PWD=$PROJECT/process/alias

alias refresh="source ~/.zshrc"
alias p="python"
alias p2="python2"
alias p3="ipython3"
alias ifconfig="/sbin/ifconfig"
alias q="exit"
alias cls="clear"
alias vi="/usr/bin/vim"
alias nv="/usr/bin/nvim"
alias gv="gvim"

alias startdate="date -d \"$(awk -F. '{print $1}' /proc/uptime) second ago\" +\"%Y-%m-%d %H:%M:%S\""
alias ge='git clone'
alias p3='python3'
alias emd='emacs --daemon'
alias e='emacsclient -c -n'
alias desktop='~/桌面'
alias ipy="ipython"
alias fzfp="fzf --preview 'cat {}'"
alias update="sudo pacman -Syu"
alias -s cpp="vim"
alias -s diary="vim"
alias -s ts="ts-node"
alias -s js="node"
alias diary="cd ~/.yandex.disk/diary && ./diary_create && cd -"
alias upgrade="sudo apt-get update ; sudo apt-get upgrade"
alias rm="rm -i"
alias pc="proxychains -q"
alias emnw="emacs -nw"
alias doom="~/.emacs.d/bin/doom"

# yarn
alias ynd='yarn run dev'
alias yns='yarn run start'
alias open='xdg-open'

alias history='fc -l 1'
alias lah='ls -lah'
alias ppy='pypy3'
alias adb-start='sudo adb kill-server && sudo adb start-server'

# alias trash-cli
alias tl='trash-list'
alias ts='trash-restore'
alias tm='trash'

# alias application
alias br='$BROWSER -P'
alias en='trans -t english'
alias ja='trans -t ja'
alias cn='trans'
alias mk='mkdir'
alias sl='exa'
alias ts='ts-node'
alias cp='cp -r'
alias crm='rm -rf'

# paru alias
alias pau='paru'
alias par='paru -Ss'
alias pai='paru -S'
alias ppu='proxychains -q paru'
alias ppi='proxychains -q paru -S'
alias yay='paru'

alias pack-marktext='mv linux-unpacked marktext-x64 && tar cvf marktext-x64.tar.gz marktext-x64'

alias vlang='/usr/bin/v'
alias post="msync gen && vim new_post && msync queue post new_post && msync sync -s && rm -f new_post"

alias icat="kitty +kitten icat"
alias code996='/bin/bash -c "$(curl -fsSL https://fastly.jsdelivr.net/gh/hellodigua/code996/bin/code996.sh)"'
alias lg="lazygit"
alias old-pnpm="~/.npm-packages/bin/pnpm" 

source $ALIAS_PWD/git.zsh
