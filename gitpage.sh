function gitpage() {
    local BLOG='/projects/aerian/mygithub/blog'
    if [ -z $(pwd | grep 'blog') ];then
        cd $BLOG
    fi
    if [ -z $1 ];then
        return
    fi
    case $1 in
        'new' )
            cd $BLOG
            hugo new post/$2.md
            cd ${OLDPWD};;
        'open' )
            local p="$BLOG/content/post/$2.md"
            if [ ! -f $p ]; then
                cd $BLOG
                hugo new post/$2.md
                cd ${OLDPWD}
            fi
            echo '使用 1) vim 2) typora'
            read edit
            case "$edit" in
                "1" )
                    echo 'opening vim'
                    /usr/bin/nvim $p;;
                "2" )
                    echo 'opening typora'
                    /usr/bin/typora $p;;
            esac;;
        'server' )
            cd $BLOG
            hugo server
            cd ${OLDPWD};;
        'push' )
            cd $BLOG
            git add . && git commit -m "add one blog" && git push && git push
            cd ${OLDPWD};;
        'rm' )
            rm -i $BLOG/content/post/$2.md;;
    esac
}

function _gitpage() {
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
            suggest=($(compgen -W 'new open push rm server' $op))
    esac
    COMPREPLY=(${suggest[@]})
}

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

complete -F _gitpage gitpage
