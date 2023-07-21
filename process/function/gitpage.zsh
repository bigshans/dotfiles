source <(hugo completion zsh)
RED='\033[0;31m'
NC='\033[0m' # No Color

function blog() {
    local BLOG_PATH='/projects/aerian/mygithub/blog'
    cd $BLOG_PATH
    if [ -z $1 ];then
        return
    fi
    case $1 in
        'open' )
            if [ "$2" = '' ];then
                echo "${RED}Error Usage${NC}: 缺少参数"
                return
            fi
            local p="$BLOG_PATH/content/post/$2.md"
            if [[ "$2" =~ ^private/.* ]]; then
                local p="$BLOG_PATH/content/$2.md"
            fi
            if [ ! -f $p ]; then
                BLOG_PATH=$BLOG_PATH hugo-manage new $2
            fi
            echo "now" $p
            local edit=''
            vared -p "使用 1) vim 2) marktext 3) typora 4) emacs :" -c edit
            case "$edit" in
                "1" )
                    echo 'opening with vim'
                    /usr/bin/vim $p;;
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
            BLOG_PATH=$BLOG_PATH hugo-manage server
            ;;
        'push' )
            BLOG_PATH=$BLOG_PATH hugo-manage push
            $BLOG_PATH hugo-manage push
            ;;
        'only-server' )
            BLOG_PATH=$BLOG_PATH hugo-manage only-server
            ;;
        'sync' )
            BLOG_PATH=$BLOG_PATH hugo-manage sync
            ;;
        'rm' )
            local p="$BLOG_PATH/content/post/$2.md"
            if [[ "$2" =~ ^private/.* ]]; then
                local p="$BLOG_PATH/content/$2.md"
            fi
            rm -i $p
            rm -rf $BLOG_PATH/public/*;;
        'public' )
            cd $BLOG_PATH/public
            ;;
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
        'open'|'post' ) # 补全与 rm 相同
            # suggest=($(compgen -W "$(ls $BLOG/content/post | cut -d . -f1)" ${COMP_WORDS[2]}));;
            ;&
        'rm' )
            suggest=($(compgen -W "$(find $BLOG/content -name '*.md' -printf '%p\n' | sed 's|/projects/aerian/mygithub/blog/content/\(.*\).md|\1|' | sed 's|post\/||')" ${COMP_WORDS[COMP_CWORD-1]}))
            ;;
        'server' )
            ;;
        * ) # 不完整，以上是补全完整的，完整的且后面无须补全的就不补全
            suggest=($(compgen -W 'new open push rm server only-server sync public' $op))
    esac
    COMPREPLY=(${suggest[@]})
}

# autoload -U +X compinit && compinit
# autoload -U +X bashcompinit && bashcompinit

complete -F _blog blog
