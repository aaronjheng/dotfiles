alias ll='ls -alv'
alias la='ls -A'
alias l='ls -CF'
alias brew='ALL_PROXY=http://127.0.0.1:8118 brew'
alias nproc='sysctl -n hw.ncpu'

export ETCDCTL_API=3
export HOMEBREW_NO_AUTO_UPDATE=1
export GOPATH="$HOME/.go"

BIN_DIRS=(
	/usr/local/sbin
	/usr/local/opt/python/libexec/bin
	/usr/local/opt/curl/bin
	/usr/local/opt/openssl@1.1/bin
	$HOME/.cargo/bin
	$HOME/.poetry/bin
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
