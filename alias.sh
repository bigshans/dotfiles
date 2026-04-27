# ========================
# 基础快捷命令
# ========================
alias q='exit'
alias cls='clear'
alias mk='mkdir'
alias cp='cp -r'
alias del='rm -i'
alias crm='rm -rf'

# ========================
# Python
# ========================
alias p='python'
alias p2='python2'
alias p3='python3'
alias ipy='ipython'
alias ipy3='ipython3'
alias ppy='pypy3'

# ========================
# 编辑器
# ========================
alias vi='/usr/bin/vim'
alias nv='/usr/bin/nvim'
alias gv='gvim'
alias e='emacs'
alias emd='emacs --daemon'
alias emnw='emacs -nw'
alias doom='~/.config/emacs/bin/doom'

# ========================
# 系统 & 网络
# ========================
alias ifconfig='/sbin/ifconfig'
alias adb-start='sudo adb kill-server && sudo adb start-server'

# ========================
# Git
# ========================
source $PROJECT/git-alias.sh

# ========================
# 包管理
# ========================
alias update='sudo pacman -Syu'
alias upgrade='sudo apt-get update && sudo apt-get upgrade'
alias singi='sudo pacman -U ./*.zst'

# paru
alias pau='paru'
alias par='paru -Ss'
alias pai='paru -S'
alias ppu='proxychains -q paru'
alias ppi='proxychains -q paru -S'

# ========================
# Yarn / Node
# ========================
alias ynd='yarn run dev'
alias yns='yarn run start'
alias deno-run='deno run -A'

# ========================
# 文件 & 工具
# ========================
alias open='xdg-open'
alias sl='exa'
alias fzfp="fzf --preview 'cat {}'"
alias icat='kitty +kitten icat'
alias lg='lazygit'

# ========================
# 代理 / 翻译
# ========================
alias pc='proxychains -q'
alias en='pc trans -t english'
alias ja='pc trans -t ja'
alias cn='pc trans'

# ========================
# trash-cli
# ========================
alias tl='trash-list'
alias trs='trash-restore'
alias tm='trash'

# ========================
# 其他工具
# ========================
alias br='$BROWSER -P'
alias old-pnpm='~/.npm-packages/bin/pnpm'
alias vlang='/usr/bin/v'
alias ai='gpt4all repl'

# to fix kitty ssh
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# ========================
# 特殊命令（建议用 function）
# ========================

# 系统启动时间
startdate() {
  date -d "$(awk -F. '{print $1}' /proc/uptime) second ago" +"%Y-%m-%d %H:%M:%S"
}

# diary
diary() {
  cd ~/.yandex.disk/diary || return
  ./diary_create
  cd - || return
}

# pgadmin
pgadmin() {
  cd ~/pgadmin4 || return
  ./pgadmin
  cd - || return
}

# pkglist
gen_pkglist() {
  comm -23 <(pacman -Qeq | sort) <(pacman -Qmq | sort) > pkglist
}

# post
post() {
  msync gen &&
  vim new_post &&
  msync queue post new_post &&
  proxychains -q msync sync -s &&
  rm -f new_post
}

# waydroid
waydroid_start() {
  sudo killall dnsmasq && waydroid
}

build_min_cjk() {
    make clean
    make oldconfig
    make -j$(( $(nproc) / 2 ))
}

run_cjk_test() {
    local rotate=${1:-0}
    qemu-system-x86_64 \
        -kernel ./arch/x86/boot/bzImage \
        -initrd /projects/aerian/initrd.img \
        -append "console=tty1 fbcon=rotate:${rotate} video=800x800" \
        -vga std \
        -serial stdio
}

ist() {
    sudo $HOME/dotfiles/scripts/inst "$@"
}

istp() {
    ist -p "$@"
}

# AUR 入口：直接多传一个 -a 给脚本
isa() {
    $HOME/dotfiles/scripts/inst -a "$@"
}
isap() {
    isa -p "$a"
}
