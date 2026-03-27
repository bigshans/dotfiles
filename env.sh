#!/bin/sh
# --- 幂等性守卫 ---
if [ -n "$_AERIAN_ENV_LOADED" ]; then
    return 0 2>/dev/null || exit 0
fi
export _AERIAN_ENV_LOADED=1

# --- 1. 基础与 XDG 规范 ---
export EDITOR="vim"
export BROWSER="/usr/bin/firefox-nightly"
export STARTSHIP_CONFIG="$HOME/dotfiles/starship/starship.toml"
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org https://repo.archlinuxcn.org"

# --- 2. 语言相关路径 (Go, Node, Rust, Ruby, C#, Deno) ---
export GOPATH="$HOME/go"
export GO111MODULE=on
export N_PREFIX="$HOME/.n"
export NPM_PACKAGES="$HOME/.npm-packages"
export NODE_ENV='development'
# 这里的 NODE_PATH 进行了规范化拼接
export NODE_PATH="/usr/lib/node_modules:/usr/local/lib/node_modules:$NPM_PACKAGES/lib/node_modules${NODE_PATH:+:${NODE_PATH}}"

# --- 3. 开发环境镜像 (China Mirrors) ---
export GOPROXY="https://goproxy.cn"
export PUB_HOSTED_URL="https://pub.flutter-io.cn"
export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
export RUSTUP_UPDATE_ROOT="https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup"
export RUSTUP_DIST_SERVER="https://mirrors.tuna.tsinghua.edu.cn/rustup"
export NODEJS_ORG_MIRROR="https://cdn.npmmirror.com/binaries/node"
export NVM_NODEJS_ORG_MIRROR="https://cdn.npmmirror.com/binaries/node"
export PHANTOMJS_CDNURL="https://cdn.npmmirror.com/binaries/phantomjs"
export CHROMEDRIVER_CDNURL="https://cdn.npmmirror.com/binaries/chromedriver"
export OPERADRIVER_CDNURL="https://cdn.npmmirror.com/binaries/operadriver"
export ELECTRON_MIRROR="https://cdn.npmmirror.com/binaries/electron/"
export ELECTRON_BUILDER_BINARIES_MIRROR="https://cdn.npmmirror.com/binaries/electron-builder-binaries/"
export SASS_BINARY_SITE="https://cdn.npmmirror.com/binaries/node-sass"
export SWC_BINARY_SITE="https://cdn.npmmirror.com/binaries/node-swc"
export NWJS_URLBASE="https://cdn.npmmirror.com/binaries/nwjs/v"
export PUPPETEER_DOWNLOAD_HOST="https://cdn.npmmirror.com/binaries"
# 解决方案: https://juejin.cn/post/7244567350720184357
export PUPPETEER_DOWNLOAD_BASE_URL="https://cdn.npmmirror.com/binaries/chrome-for-testing"
export SENTRYCLI_CDNURL="https://cdn.npmmirror.com/binaries/sentry-cli"
export SAUCECTL_INSTALL_BINARY_MIRROR="https://cdn.npmmirror.com/binaries/saucectl"
export npm_config_sharp_binary_host="https://cdn.npmmirror.com/binaries/sharp"
export npm_config_sharp_libvips_binary_host="https://cdn.npmmirror.com/binaries/sharp-libvips"
export npm_config_robotjs_binary_host="https://cdn.npmmirror.com/binaries/robotj"

# --- 4. 移动端与特定工具配置 ---
export ANDROID_SDK_ROOT="/projects/aerian/.android"
export ANDROID_HOME="/projects/aerian/.android"
export CHROME_EXECUTABLE="vivaldi"
export OLLAMA_MODELS="/mnt/disk/models"
export METALS_JAVA_OPTS='-XX:+UseG1GC -XX:+UseStringDeduplication -Xss4m -Xms100m'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# --- 5. 路径拼接 (PATH Management) ---
# 定义一个内部函数防止重复添加路径
_path_add() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1:$PATH"
    fi
}

# 按照优先级从低到高添加 (越往后添加的优先级越高)
_path_add "$HOME/.dotnet/tools"
_path_add "$HOME/.basher/bin"
_path_add "/home/aerian/.deno/bin"
_path_add "$NPM_PACKAGES/bin"
_path_add "$N_PREFIX/bin"
_path_add "$HOME/.cargo/bin"
_path_add "${SONAR_SCANNER_HOME}/bin"
_path_add "$HOME/.local/bin"
_path_add "$HOME/dotfiles/scripts"
_path_add "$GOPATH/bin"
_path_add "$HOME/.config/yarn/global/node_modules/.bin"
_path_add "$HOME/.config/emacs/bin"

# Ruby Gem 路径动态处理
if command -v gem >/dev/null; then
    for p in $(gem env gempath | tr ':' ' '); do
        _path_add "$p/bin"
    done
fi

export PATH

# --- 6. 外部脚本加载与初始化 ---
if command -v android-studio >/dev/null; then
    export CAPACITOR_ANDROID_STUDIO_PATH=$(where android-studio | head -n 1)
fi

# Basher 初始化 (仅在交互式 Shell 中)
if [[ $- == *i* ]]; then
    eval "$(basher init - zsh 2>/dev/null)"
fi

if [[ $XDG_SESSION_TYPE == "wayland" ]] then
    export QT_IM_MODULE="wayland;fcitx"
else
    export GTK_IM_MODULE=fcitx5
    export QT_IM_MODULE=fcitx
fi
export XMODIFIERS=@im=fcitx5
