#!/usr/bin/bash

# only install software

sudo apt-get install aptitude
sudo apt-get install synaptic
sudo apt-get install vim vim-gtk neovim emacs
sudo apt-get install python-dev python3-dev
sudo apt-get install netease-cloud-music
sudo apt-get install konsole
sudo apt-get install kdeconnect
sudo apt-get install dolphin
sudo apt-get install gparted
sudo apt-get install ark
sudo apt-get install fcitx-ui-classic
sudo apt-get install fcitx-table-ziranma
sudo apt-get install sogoupinyin
sudo apt-get install foxitreader
sudo apt-get install google-chrome-stable
sudo apt-get install sublime-text-dev
sudo apt install code
sudo apt-get install calibre
sudo apt-get install xfce4
sudo apt-get install tmux
sudo apt-get install xclip
sudo apt-get install acpi
sudo apt-get install zsh
chsh -s /usr/bin/zsh
sudo apt-get install clang
sudo apt-get install tlp
sudo apt-get install build-essential
sudo apt-get install gdb
sudo apt-get install deepin-deb-installer
sudo apt-get install deepin-picker
sudo apt-get install deepin-screen-recorder
sudo apt-get install deepin-screenshot
sudo apt-get install deepin-voice-recorder
sudo apt-get install texlive-latex
sudo apt-get install latex-cjk-chinese
sudo apt-get install hibernate
sudo apt-get install default-jdk
sudo apt-get install graphciz
sudo apt-get install thunderbird
sudo apt-get install thunderbird-l10n-zh-cn
wget http://mirrors.aliyun.com/deepin/pool/main/c/chmsee/chmsee_1.3.0-3_amd64.deb
sudo apt install ./chmsee_1.3.0-3_amd64.deb
sudo apt install dconf-editor
rm -rf chmsee*
git clone https://gitee.com/aerian/Deepin-wine-QQ-TIM-Debian.git
cd Deepin-wine-QQ-TIM-Debian
bash ./install.sh
cd ../
rm -rf Deepin-wine-QQ-TIM-Debian
