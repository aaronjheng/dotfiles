alias ll='ls -alv'
alias la='ls -A'
alias l='ls -CF'
alias brew='ALL_PROXY=socks5://127.0.0.1:1080 brew'
alias nproc='sysctl -n hw.ncpu'
alias pj="pbpaste | jq ."

export ETCDCTL_API=3
export GOPATH="$HOME/.go"
export GOMODCACHE="$HOME/.go/mod"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_CASK_OPTS="--no-quarantine"
export PYTHON_BUILD_CACHE_PATH="$HOME/Library/Caches/pyenv"

mkdir -p $PYTHON_BUILD_CACHE_PATH

BIN_DIRS=(
	/usr/local/opt/curl/bin
	/usr/local/opt/make/libexec/gnubin
	/usr/local/opt/openssl@1.1/bin
	$HOME/.cargo/bin
	$GOPATH/bin
)

for BIN_DIR in ${BIN_DIRS[@]}; do
	if [ -d "$BIN_DIR" ]; then
		export PATH="$BIN_DIR:$PATH"
	fi
done

if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init -)"
fi

if [ -r ~/.zshrc_local ]; then
	. ~/.zshrc_local
fi
