alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias brew='ALL_PROXY=socks5://127.0.0.1:1080 brew'

function proxy() {
    ALL_PROXY=socks5://127.0.0.1:1080 exec "$@"
}

export GOPATH=~/go
