alias ll='ls -alv'
alias la='ls -A'
alias l='ls -CF'
alias brew='ALL_PROXY=socks5://127.0.0.1:1080 brew'
alias nproc='sysctl -n hw.ncpu'
alias pj="pbpaste | jq ."

export ETCDCTL_API=3
export GOPATH="$HOME/.go"
export HOMEBREW_NO_AUTO_UPDATE=1
export PYTHON_BUILD_CACHE_PATH="$HOME/Library/Caches/pyenv"

mkdir -p $PYTHON_BUILD_CACHE_PATH

BIN_DIRS=(
	/usr/local/sbin
	/usr/local/opt/curl/bin
	/usr/local/opt/make/libexec/gnubin
	$HOME/.cargo/bin
	$GOPATH/bin
)

for BIN_DIR in ${BIN_DIRS[@]}
do
	if [ -d "$BIN_DIR" ]; then
		export PATH="$BIN_DIR:$PATH"
	fi
done

if [ -r ~/.zshrc_local ]; then
    . ~/.zshrc_local
fi
