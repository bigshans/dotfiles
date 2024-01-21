fpath+=~/.zfunc
ENV_PROJECT=$PROJECT/process/env
export GOPROXY=https://goproxy.cn
export GO111MODULE=on

export BROWSER="/usr/bin/firefox-nightly"
export GOPATH=$HOME/go
export ANDROID_SDK_ROOT=/mnt/disk/Android
export ANDROID_HOME=/mnt/disk/Android/

export PATH=$HOME/.config/emacs/bin:$PATH
export SONAR_SCANNER_HOME="/opt/sonar-scanner"
export METALS_JAVA_OPTS='-XX:+UseG1GC -XX:+UseStringDeduplication -Xss4m -Xms100m'

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export QT_AUTO_SCREEN_SCALE_FACTOR=1

export PATH=$PATH:~/.config/yarn/global/node_modules/.bin
export NODE_ENV='development'
export N_PREFIX=$HOME/.n
export NPM_PACKAGES="$HOME/.npm-packages"
# load node global lib
export NODE_PATH=$NODE_PATH:/usr/lib/node_modules:/usr/local/lib/node_modules:$NPM_PACKAGES/lib/node_modules

# ruby lib
export PATH=$GOPATH/bin:$PATH
IN=$(gem env gempath)
ps=(`echo $IN | tr ':' ' '`)
for p in ${ps[@]}
do
    p=$p/bin
    export PATH=$p:$PATH
done

export PATH=$PATH:$HOME/dotfiles/scripts
export PATH=$PATH:$HOME/.local/bin
export PATH="${PATH}:${SONAR_SCANNER_HOME}/bin"
export PATH=${PATH}:$HOME/.cargo/bin
export PATH=$N_PREFIX/bin:$PATH
export PATH=$NPM_PACKAGES/bin:$PATH
export PATH="/home/aerian/.deno/bin:$PATH"
export PATH="$HOME/.basher/bin:$PATH"   ##basher5ea843
# C# config
export PATH="$PATH:$HOME/.dotnet/tools"
eval "$(basher init - zsh)"             ##basher5ea843

DEBUGINFOD_URLS="https://debuginfod.archlinux.org https://repo.archlinuxcn.org"

source $ENV_PROJECT/npm.zsh
