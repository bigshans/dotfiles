source <(hugo completion zsh)
function blog() {
    local BLOG='/projects/aerian/mygithub/blog'
    cd $BLOG
    if [ -z $1 ];then
        return
    fi
    case $1 in
        'new' )
            hugo new post/$2.md
            ;;
        'open' )
            local p="$BLOG/content/post/$2.md"
            if [ ! -f $p ]; then
                hugo new post/$2.md
            fi
            local edit=''
            vared -p "使用 1) vim 2) marktext 3) typora 4) emacs :" -c edit
            case "$edit" in
                "1" )
                    echo 'opening with vim'
                    /usr/bin/nvim $p;;
                "2" )
                    echo 'opening with marktext'
                    /usr/bin/marktext $p;;
                "3" )
                    echo 'opening with typora'
                    /usr/bin/typora $p;;
                "4" )
                    echo 'opening with emacs'
                    /usr/bin/emacs $p;;
            esac
            ;;
        'server' )
            hugo server
            ;;
        'deploy' )
            git add . && git commit -m ":package: add or update a blog post" && git push && git push
            ;;
        'push' )
            git push && git push
            ;;
        'rm' )
            rm -i $BLOG/content/post/$2.md
            rm -rf $BLOG/public/*;;
    esac
}

function _blog() {
    local op=${COMP_WORDS[1]} # 获取 gitpage 的操作
    local suggest=() # 补全结果
    local BLOG='/projects/aerian/mygithub/blog'
    # 参数不能超过三个
    if [ "${COMP_CWORD}" -ge "3" ]; then
        return
    fi
    case $op in
        'new' )
            ;;
        'deploy' )
            ;;
        'push' )
            ;;
        'open' ) # 补全与 rm 相同
            # suggest=($(compgen -W "$(ls $BLOG/content/post | cut -d . -f1)" ${COMP_WORDS[2]}));;
            ;&
        'rm' )
            suggest=($(compgen -W "$(ls $BLOG/content/post | cut -d . -f1)" ${COMP_WORDS[COMP_CWORD-1]}));;
        'server' )
            ;;
        * ) # 不完整，以上是补全完整的，完整的且后面无须补全的就不补全
            suggest=($(compgen -W 'new open push deploy rm server' $op))
    esac
    COMPREPLY=(${suggest[@]})
}

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

complete -F _blog blog
