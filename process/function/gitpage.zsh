source <(hugo completion zsh)
RED='\033[0;31m'
NC='\033[0m' # No Color
BLOG_KEY='/projects/aerian/mygithub/blog/.KEY'

function decodeAll() {
    local BLOG_PRIVATE='/projects/aerian/mygithub/blog/content/post/private'
    for filename in $(ls $BLOG_PRIVATE); do
        echo $filename "now decode"
        decryptMD $BLOG_PRIVATE"/"$filename $BLOG_KEY
    done
}

function encodeAll() {
    local BLOG_PRIVATE='/projects/aerian/mygithub/blog/content/post/private'
    for filename in $(ls $BLOG_PRIVATE); do
        echo $filename "now encode"
        encryptMD $BLOG_PRIVATE"/"$filename $BLOG_KEY
    done
}

function encodeAllHTML() {
    local BLOG_PRIVATE='/projects/aerian/mygithub/blog/public/post/private'
    for folder in $(ls $BLOG_PRIVATE); do
        echo $BLOG_PRIVATE"/"$folder"/index.html" "now encode"
        encryptHTML $BLOG_PRIVATE/$folder/index.html $BLOG_KEY
    done
}

function blog() {
    local BLOG='/projects/aerian/mygithub/blog'
    cd $BLOG
    if [ -z $1 ];then
        return
    fi
    case $1 in
        'decode' )
            decodeAll
            ;;
        'encode' )
            encodeAll
            ;;
        'new' )
            hugo new post/$2.md
            ;;
        'private' )
            if [ "$2" = '' ];then
                echo "${RED}Error Usage${NC}: 缺少参数"
                return
            fi
            local p="$BLOG/content/post/private/$2"
            blog new private/$2
            sed -i '4a private: true' $p
            blog open private/$2
            ;;
        'open'|'post' )
            if [ "$2" = '' ];then
                echo "${RED}Error Usage${NC}: 缺少参数"
                return
            fi
            local p="$BLOG/content/post/$2.md"
            if [ ! -f $p ]; then
                hugo new post/$2.md
            fi
            local edit=''
            vared -p "使用 1) vim 2) marktext 3) typora 4) emacs :" -c edit
            decryptMD $p
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
            decodeAll
            hugo server
            ;;
        'push' )
            cd $BLOG
            decodeAll
            hugo
            cd public
            encodeAllHTML
            git add . && git commit -m 'update blog' && git push
            cd ..
            encodeAll
            git add . && git commit -m 'update website'
            git push
            ;;
        'test-server' )
            cd $BLOG
            echo "decode"
            decodeAll
            hugo
            echo "encode"
            encodeAllHTML
            cd public
            php -S 0.0.0.0:1313
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
        'open'|'post' ) # 补全与 rm 相同
            # suggest=($(compgen -W "$(ls $BLOG/content/post | cut -d . -f1)" ${COMP_WORDS[2]}));;
            ;&
        'rm' )
            suggest=($(compgen -W "$(ls $BLOG/content/post | cut -d . -f1)" ${COMP_WORDS[COMP_CWORD-1]}));;
        'private' )
            suggest=($(compgen -W "$(ls $BLOG/content/post/private | cut -d . -f1)" ${COMP_WORDS[COMP_CWORD-1]}));;
        'server' )
            ;;
        * ) # 不完整，以上是补全完整的，完整的且后面无须补全的就不补全
            suggest=($(compgen -W 'new open push rm server test-server decode encode private' $op))
    esac
    COMPREPLY=(${suggest[@]})
}

# autoload -U +X compinit && compinit
# autoload -U +X bashcompinit && bashcompinit

complete -F _blog blog
