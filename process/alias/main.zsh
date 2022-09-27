eval $(thefuck --alias)

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
alias -s ts="ts-node"
alias -s js="node"
alias diary="cd ~/.yandex.disk/diary && ./diary_create && cd -"
alias upgrade="sudo apt-get update ; sudo apt-get upgrade"
alias rm="rm -i"
alias pc="proxychains -q"
alias emnw="emacs -nw"
alias doom="~/.emacs.d/bin/doom"
# alias n="nvim"
# alias v="/usr/bin/vim"
# alias vim="nvim"
# alias vimdiff="nvim -d"
# git alias
alias gcz="git cz"
alias gph='git push'
alias gpl='git pull'
# yarn
alias ynd='yarn run dev'
alias yns='yarn run start'
alias open='xdg-open'
alias cm="$HOME/dotfiles/cm.sh"

# alias for git
alias g=git
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbda='git branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d'
alias gbl='git blame -b -w'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'
alias gc='git commit -v'
alias 'gc!'='git commit -v --amend'
alias gca='git commit -v -a'
alias 'gca!'='git commit -v -a --amend'
alias gcam='git commit -a -m'
alias 'gcan!'='git commit -v -a --no-edit --amend'
alias 'gcans!'='git commit -v -a -s --no-edit --amend'
alias gcb='git checkout -b'
alias gcd='git checkout develop'
alias gcf='git config --list'
alias gcl='git clone --recursive'
alias gclean='git clean -fd'
alias gcm='git checkout master'
alias gcmsg='git commit -m'
alias 'gcn!'='git commit -v --no-edit --amend'
alias gco='git checkout'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcs='git commit -S'
alias gd='git diff'
alias gdca='git diff --cached'
alias gdct='git describe --tags `git rev-list --tags --max-count=1`'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdw='git diff --word-diff'
alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gfo='git fetch origin'
alias gg='git gui citool'
alias gga='git gui citool --amend'
alias ggpull='git pull origin $(git_current_branch)'
alias ggpur=ggu
alias ggpush='git push origin $(git_current_branch)'
alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias ghh='git help'
alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'
alias gk='\gitk --all --branches'
alias gke='\gitk --all $(git log -g --pretty=%h)'
alias gl='git pull'
alias glg='git log --stat'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glgp='git log --stat -p'
alias glo='git log --oneline --decorate'
alias globurl='noglob urlglobber '
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glol='git log --graph --pretty='\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
alias glola='git log --graph --pretty='\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit --all'
alias glp=_git_log_prettily
alias glum='git pull upstream master'
alias gm='git merge'
alias gmom='git merge origin/master'
alias gmt='git mergetool --no-prompt'
alias gmtvim='git mergetool --no-prompt --tool=vimdiff'
alias gmum='git merge upstream/master'
alias gp='git push'
alias gpd='git push --dry-run'
alias gpoat='git push origin --all && git push origin --tags'
alias gpristine='git reset --hard && git clean -dfx'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gpu='git push upstream'
alias gpv='git push -v'
alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'
alias grbm='git rebase master'
alias grbs='git rebase --skip'
alias grep='grep  --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grset='git remote set-url'
alias grt='cd $(git rev-parse --show-toplevel || echo ".")'
alias gru='git reset --'
alias grup='git remote update'
alias grv='git remote -v'
alias gsb='git status -sb'
alias gsd='git svn dcommit'
alias gsi='git submodule init'
alias gsps='git show --pretty=short --show-signature'
alias gsr='git svn rebase'
alias gss='git status -s'
alias gst='git status'
alias gsta='git stash save'
alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'
alias gsu='git submodule update'
alias gts='git tag -s'
alias gtv='git tag | sort -V'
alias gunignore='git update-index --no-assume-unchanged'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
alias gup='git pull --rebase'
alias gupv='git pull --rebase -v'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip--"'
alias gcz='git cz'

alias history='fc -l 1'
alias lah='ls -lah'
alias ppy='pypy3'
alias adb-start='sudo adb kill-server && sudo adb start-server'

# alias trash-cli
alias tl='trash-list'
alias ts='trash-restore'
alias tm='trash'

# alias application
alias br='$BROWSER -P'
alias en='trans -t english'
alias ja='trans -t ja'
alias cn='trans'
alias mk='mkdir'
alias sl='exa'
alias ts='ts-node'
alias cp='cp -r'
alias crm='rm -rf'

# paru alias
alias pa='paru'
alias par='paru -Ss'
alias pai='paru -S'
alias pau='paru -Rsu'
alias pac='paru -Sc'
alias ppi='proxychains -q paru -S'

alias pack-marktext='mv linux-unpacked marktext-x64 && tar cvf marktext-x64.tar.gz marktext-x64'

alias vlang='/usr/bin/v'
alias post="msync gen && vim new_post && msync queue post new_post && msync sync -s && rm -f new_post"

alias icat="kitty +kitten icat"
alias code996='/bin/bash -c "$(curl -fsSL https://fastly.jsdelivr.net/gh/hellodigua/code996/bin/code996.sh)"'
alias lg="lazygit"
alias old-pnpm="~/.npm-packages/bin/pnpm" 
# alias wttr="curl wttr.in"

# to fix kitty ssh
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="kitty +kitten ssh"