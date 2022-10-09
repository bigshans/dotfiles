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

function update_plugin() {
    (( $+commands[antidote] )) && source $antidote/antidote/antidote.zsh
    antidote update
}

reload() {
    for proc in ${scripts[@]}
    do
        if [[ $proc == $1 ]] then
            . $PROJECT/process/hooks/pre_$proc/main.zsh
            . $PROJECT/process/$proc/main.zsh
            . $PROJECT/process/hooks/after_$proc/main.zsh
            echo "reload "$1" finished!"
            return
        fi
    done
    source ~/.zshrc
}

slen() {
    echo $1 | wc -c
}

refresh_github_host() {
    CURRENT_HOSTS=$(cat /etc/hosts)
    HOSTS_START=$(echo "$CURRENT_HOSTS" | grep -n "# GitHub Host Start" | cut -d: -f1)
    HOSTS_END=$(echo "$CURRENT_HOSTS" | grep -n "# GitHub Host End" | cut -d: -f1)
    UPDATED_HOSTS_TEMP=$(curl -s https://git.bigshans.top/carrotAdmin/hosts/raw/branch/master/hosts)
    UPDATED_HOSTS_START=$(echo "$UPDATED_HOSTS_TEMP" | grep -n '# GitHub Host Start' | cut -d: -f1)
    UPDATED_HOSTS=$(echo "$UPDATED_HOSTS_TEMP" | tail -n +$(expr $UPDATED_HOSTS_START))
    if [ -z "$HOSTS_START" ] || [ -z "$HOSTS_END" ]; then
        NEW_HOSTS=$(echo -e "$CURRENT_HOSTS\n$UPDATED_HOSTS")
    else
        # Get the content of the hosts file before # GitHub Host Start
        BEFORE_HOSTS=$(echo "$CURRENT_HOSTS" | head -n $(expr $HOSTS_START - 1))
        # Get the content of the hosts file after # GitHub Host End
        AFTER_HOSTS=$(echo "$CURRENT_HOSTS" | tail -n +$(expr $HOSTS_END + 1))
        # Replace the content of the hosts file between # GitHub Host Start and # GitHub Host End with the updated hosts file
        NEW_HOSTS=$(echo -e "$BEFORE_HOSTS\n$UPDATED_HOSTS\n$AFTER_HOSTS")
    fi
    echo "$NEW_HOSTS" | sudo tee /etc/hosts
}
