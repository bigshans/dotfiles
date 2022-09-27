takedir () {
    mkdir -p $@ && cd ${@:$#}
}

takegit () {
    git clone "$1"
    cd "$(basename ${1%%.git})"
}

takeurl () {
    local data thedir
    data="$(mktemp)" 
    curl -L "$1" > "$data"
    tar xf "$data"
    thedir="$(tar tf "$data" | head -n 1)" 
    rm "$data"
    cd "$thedir"
}

take () {
    if [[ $1 =~ ^(https?|ftp).*\.tar\.(gz|bz2|xz)$ ]]
    then
        takeurl "$1"
    elif [[ $1 =~ ^([A-Za-z0-9]\+@|https?|git|ssh|ftps?|rsync).*\.git/?$ ]]
    then
        takegit "$1"
    else
        takedir "$@"
    fi
}
