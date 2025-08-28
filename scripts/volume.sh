#!/bin/bash

# 默认步进值
DEFAULT_STEP=5

function get_volume {
    pamixer --get-volume
}

function is_mute {
    pamixer --get-mute | grep -q true
}

function get_icon {
    volume=$(get_volume)
    if is_mute || [ "$volume" -eq 0 ]; then
        echo "audio-volume-muted"
    elif [ "$volume" -lt 30 ]; then
        echo "audio-volume-low"
    elif [ "$volume" -lt 70 ]; then
        echo "audio-volume-medium"
    else
        echo "audio-volume-high"
    fi
}

function send_notification {
    if is_mute; then
        volume=0
        icon="audio-volume-muted"
    else
        volume=$(get_volume)
        icon=$(get_icon)
    fi

    # Use dunstify progress bar (0–100)
    dunstify -i "$icon" -t 2000 -r 2593 -u normal \
        -h int:value:"$volume" "Volume: ${volume}%"
}

# 判断步进参数
STEP=${2:-$DEFAULT_STEP}

case $1 in
    up)
        pamixer -u
        pamixer -i "$STEP"
        send_notification
        ;;
    down)
        pamixer -u
        pamixer -d "$STEP"
        send_notification
        ;;
    mute)
        pamixer -t
        send_notification
        ;;
    *)
        echo "Usage: $0 {up|down|mute} [step]"
        exit 1
        ;;
esac
