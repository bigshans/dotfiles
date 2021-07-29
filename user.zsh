# export TERM=xterm-256color


#function {{


function mp4Tomp3() {
    ffmpeg -i $1 -acodec libmp3lame -ac 2 -ab 160k -ar 48000 $2
}

function restart_compton() {
    kill $(pgrep compton)
    compton -c -f -o 1.0 -I 0.1 -O 0.1 -C -i 0.95 -z --vsync opengl-swc --paint-on-overlay --backend glx --shadow-exclude "! name~=''" -b --use-ewmh-active-win --glx-no-stencil
}
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

function gitpage() {
    if [ -z $(pwd | grep 'gitpage') ];then
        cd /mnt/D/gitpage
    fi
    if [ -z $1 ];then
        return
    fi
    case $1 in
        'new' )
            hexo new $2;;
        'server' )
            hexo s;;
        'complier' )
            hexo g;;
        'push' )
            hexo deploy -g
            git add . && git commit -m "添加博文" && git push;;
        'clean' )
            hexo clean;;
        'deploy' | 'run' )
            hexo clean && hexo g && hexo s;;
    esac
}


# added by Miniconda2 4.5.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
function conda-init() {
    __conda_setup="$(CONDA_REPORT_ERRORS=false '/home/aerian/.miniconda2/bin/conda' shell.bash hook 2> /dev/null)"
    if [ $? -eq 0 ]; then
        \eval "$__conda_setup"
    else
        if [ -f "/home/aerian/.miniconda2/etc/profile.d/conda.sh" ]; then
            . "/home/aerian/.miniconda2/etc/profile.d/conda.sh"
            CONDA_CHANGEPS1=false conda activate base
        else
            \export PATH="/home/aerian/.miniconda2/bin:$PATH"
        fi
    fi
    unset __conda_setup
}
# <<< conda init <<<

# }}


# setxkbmap -option ctrl:swapcaps
# alias {{
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
# alias pg="sudo apt-get upgrade"
# alias pan="BaiduPCS-Go"
alias startdate="date -d \"$(awk -F. '{print $1}' /proc/uptime) second ago\" +\"%Y-%m-%d %H:%M:%S\""
alias fuck='eval $(thefuck $(fc -ln -1));'
alias ge='git clone'
alias p3='python3'
alias emd='emacs --daemon'
alias e='emacsclient -c -n'
# alias emacs='emacs24'
alias desktop='~/桌面'
# alias transAuToMp='mencoder -oac mp3lame -ovc copy -of rawaudio'
alias ipy="ipython"
# alias lwebpack="node_modules/.bin/webpack"
# alias lwebpack-dev-server="./node_modules/.bin/webpack-dev-server"
# alias pp="sudo apt-get update"
alias fzfp="fzf --preview 'cat {}'"
# alias update="sudo apt-get update"
alias update="sudo pacman -Syu"
alias -s cpp="vim"
# alias -s py="vim"
alias -s diary="vim"
alias diary="cd ~/.yandex.disk/diary && ./diary_create && cd -"
alias upgrade="sudo apt-get update ; sudo apt-get upgrade"
alias rm="rm -i"
alias pc="proxychains -q"
alias emnw="emacs -nw"
alias doom="~/.emacs.d/bin/doom"
alias n="nvim"
alias v="/usr/bin/vim"
alias vim="nvim"
# git alias
alias gcz="git cz"
alias gph='git push'
alias gpl='git pull'
alias ga='git add'
alias gaa='git add .'
# yarn
alias ynd='yarn run dev'
alias yns='yarn run start'
alias open='xdg-open'
# alias code="vscodium"
# alias cat="bat"

# }}
source $HOME/dotfiles/alias.zsh
