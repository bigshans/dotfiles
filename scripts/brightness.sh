#!/bin/bash

# 默认步进
DEFAULT_STEP=5

function get_brightness {
    brightnessctl get | awk -v max=$(brightnessctl max) '{printf "%d", $1*100/max}'
}

function get_icon {
    brightness=$(get_brightness)
    if [ "$brightness" -eq 0 ]; then
        echo "display-brightness-off"
    elif [ "$brightness" -lt 30 ]; then
        echo "display-brightness-low"
    elif [ "$brightness" -lt 70 ]; then
        echo "display-brightness-medium"
    else
        echo "display-brightness-high"
    fi
}

function send_notification {
    brightness=$(get_brightness)
    icon=$(get_icon)

    dunstify -i "$icon" -t 2000 -r 2594 -u normal \
        -h int:value:"$brightness" "Brightness: ${brightness}%"
}

# 取第二个参数作为步进，没给就用默认
STEP=${2:-$DEFAULT_STEP}

case $1 in
    up)
        brightnessctl set +${STEP}%
        send_notification
        ;;
    down)
        brightnessctl set ${STEP}%-
        send_notification
        ;;
    set)
        if [[ -z "$2" ]]; then
            echo "Usage: $0 set <value>"
            exit 1
        fi
        brightnessctl set "$2"% 
        send_notification
        ;;
    *)
        echo "Usage: $0 {up|down|set <value>} [step]"
        exit 1
        ;;
esac
