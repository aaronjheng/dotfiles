alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

export GOROOT=/usr/local/opt/go/libexec
export GOPATH=~/goproject

socks5_proxy=socks5://127.0.0.1:1080

alias brew='ALL_PROXY=${socks5_proxy} brew'
alias pip='ALL_PROXY=${socks5_proxy} pip'
alias pip2='ALL_PROXY=${socks5_proxy} pip2'
alias pip3='ALL_PROXY=${socks5_proxy} pip3'
alias gem='ALL_PROXY=${socks5_proxy} gem'
alias go='ALL_PROXY=${socks5_proxy} go'
alias cabal='ALL_PROXY=${socks5_proxy} cabal'
