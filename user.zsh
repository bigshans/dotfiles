export PATH="./node_modules/.bin:$PATH"
export PATH=$PATH:/sbin
# source /etc/profile
export PATH=$PATH:/opt/cling/bin
export PATH=$PATH:/mnt/D/github/cquery/build
export PATH=$PATH:/home/aerian/.npm-global/bin
export PATH="/home/aerian/.cask:$PATH"
. /usr/share/autojump/autojump.sh
# export TERM=xterm-256color


#function {{
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
    elif [ $1 = 'new' ];then
        hexo new $2
    elif [ $1 = 'server' ];then
        hexo s
    elif [ $1 = 'complier' ];then
        hexo g
    elif [ $1 = 'push' ];then
        hexo deploy -g
        git add . && git commit -m "添加博文" && git push
    elif [ $1 = 'clean' ];then
        hexo clean
    elif [ $1 = 'deploy' ];then
        hexo g
        hexo s
    fi
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


setxkbmap -option ctrl:swapcaps
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
alias pg="sudo apt-get upgrade"
alias pan="BaiduPCS-Go"
alias startdate="date -d \"$(awk -F. '{print $1}' /proc/uptime) second ago\" +\"%Y-%m-%d %H:%M:%S\""
alias fuck='eval $(thefuck $(fc -ln -1));'
alias p3='python3'
alias emd='emacs --daemon'
alias e='emacsclient -c -n'
# alias emacs='emacs24'
alias desktop='~/桌面'
# alias transAuToMp='mencoder -oac mp3lame -ovc copy -of rawaudio'
alias ipy="ipython"
# alias lwebpack="node_modules/.bin/webpack"
# alias lwebpack-dev-server="./node_modules/.bin/webpack-dev-server"
alias pp="sudo apt-get update"
alias fzfp="fzf --preview 'cat {}'"
alias update="sudo apt-get update"
alias -s cpp="vim"
# alias -s py="vim"
alias -s diary="vim"
alias diary="cd ~/.yandex.disk/diary && ./diary_create && cd -"
alias upgrade="sudo apt-get update ; sudo apt-get upgrade"
alias rm="rm -i"
alias pc="proxychains"
alias cat="bat"

# }}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

