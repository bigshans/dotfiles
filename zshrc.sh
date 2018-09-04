# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export PATH="./node_modules/.bin:$PATH"
export ZSH=/home/aerian/.oh-my-zsh
source /etc/profile
# export PATH="/home/aerian/.cask:$PATH"
export TERM=xterm-256color

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="ys"
# ZSH_THEME="candy"
# ZSH_THEME="agnoster"
# ZSH_THEME="pure"
# ZSH_THEME="amuse"
# ZSH_THEME="random"
ZSH_THEME="mira"
# ZSH_THEME="wedisagree"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
git
# zsh-syntax-highlighting
fast-syntax-highlighting
zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# [[ -s /home/aerian/.autojump/etc/profile.d/autojump.sh ]] && source /home/aerian/.autojump/etc/profile.d/autojump.sh
source /usr/share/autojump/autojump.sh
autoload -U compinit && compinit -u

#function
function template() {
    if [ $# -eq 1 ];then
        cp ~/模板/Template.$1 ./Template.$1
        echo "Template.$1 复制完成"
    else
        cp ~/模板/Template.$1 ./$2.$1
        echo "$2.$1 复制完成"
    fi
    # cp ~/模板/Template.$1 ./Template.$1
}
function runningtime() {
    cat /proc/uptime| awk -F. '{run_days=$1 / 86400;run_hour=($1 % 86400)/3600;run_minute=($1 % 3600)/60;run_second=$1 % 60;printf("系统已运行：%d天%d时%d分%d秒",run_days,run_hour,run_minute,run_second)}'
}

bindkey '^x^c' "exit"

setxkbmap -option ctrl:swapcaps
alias refresh="source ~/.zshrc"
alias p="python"
alias p2="python2"
alias ifconfig="/sbin/ifconfig"
alias q="exit"
alias cls="clear"
alias vi="/usr/bin/vim"
alias vim="/usr/bin/nvim"
alias gv="gvim"
alias pg="sudo apt-get upgrade"
alias pan="BaiduPCS-Go"
alias startdate="date -d \"$(awk -F. '{print $1}' /proc/uptime) second ago\" +\"%Y-%m-%d %H:%M:%S\""
# alias runningtime="cat /proc/uptime| awk -F. '{run_days=$1 / 86400;run_hour=($1 % 86400)/3600;run_minute=($1 % 3600)/60;run_second=$1 % 60;printf(\"系统已运行：%d天%d时%d分%d秒\",run_days,run_hour,run_minute,run_second)}'" # 不起作用
#
alias fuck='eval $(thefuck $(fc -ln -1));'
alias p3='python3'
alias emd='emacs --daemon'
alias e='emacsclient -c -n'
# alias emacs='emacs24'
alias desktop='~/桌面'
alias transAuToMp='mencoder -oac mp3lame -ovc copy -of rawaudio'
alias ipy="ipython"
alias lwebpack="node_modules/.bin/webpack"
alias lwebpack-dev-server="./node_modules/.bin/webpack-dev-server"
alias pp="sudo apt-get update"
alias fzfp="fzf --preview 'cat {}'"
alias update="sudo apt-get update"
alias -s cpp="gvim"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
