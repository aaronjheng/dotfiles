alias ll='ls -alv'
alias la='ls -A'
alias l='ls -CF'
alias brew='ALL_PROXY=socks5://127.0.0.1:1086 brew'
alias nproc='sysctl -n hw.ncpu'

export ETCDCTL_API=3
export PS1='\u@\h:\W$ '
export HOMEBREW_NO_AUTO_UPDATE=1
export PYTHON_BUILD_CACHE_PATH=~/.cache/pyenv
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
