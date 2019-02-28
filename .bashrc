alias ll='ls -alv'
alias la='ls -A'
alias l='ls -CF'
alias brew='ALL_PROXY=socks5://127.0.0.1:1086 brew'
alias nproc='sysctl -n hw.ncpu'

export ETCDCTL_API=3
export PS1='\u@\h:\W$ '
export HOMEBREW_NO_AUTO_UPDATE=1
export PYTHON_BUILD_CACHE_PATH=~/.cache/pyenv

CURL_BIN_DIR=/usr/local/opt/curl-openssl/bin
if [ -d "$CURL_BIN_DIR" ]; then
	export PATH="$CURL_BIN_DIR:$PATH"
fi

OPENSSL_BIN_DIR=/usr/local/opt/openssl@1.1/bin
if [ -d "$OPENSSL_BIN_DIR" ]; then
	export PATH="$OPENSSL_BIN_DIR:$PATH"
fi

CARGO_BIN_DIR="~/.cargo/bin"
if [ -d "$CARGO_BIN_DIR" ]; then
	export PATH="$CARGO_BIN_DIR:$PATH"
fi
