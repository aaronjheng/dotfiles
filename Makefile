.PHONY: cleanup
cleanup:
	find . -name '*.DS_Store' -exec rm --force {} +

.PHONY: sync
sync:
	rsync -aq --exclude-from=rsyncexclude . ~
	chmod 700 ~/.gnupg ~/.gnupg/gpg.conf

.PHONY: install
install: root_password sudo_no_password bootstrap_homebrew \
			bootstrap_z bootstrap_loopback_alias bootstrap_vundle sync \

.PHONY: root_password
root_password:
	sudo passwd root

.PHONY: sudo_no_password
sudo_no_password:
	echo "%admin ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/admin 1>/dev/null

.PHONY: bootstrap_homebrew
bootstrap_homebrew:
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew install zsh-completions rsync git wget iproute2mac

.PHONY: bootstrap_z
bootstrap_z:
	curl -fsSL -o ~/.z.sh https://raw.githubusercontent.com/rupa/z/master/z.sh

LOOPBACK_ALIAS_FILE:= loopback.alias.plist
LOOPBACK_ALIAS := /Library/LaunchDaemons/$(LOOPBACK_ALIAS_FILE)
.PHONY: bootstrap_loopback_alias
bootstrap_loopback_alias:
	sudo cp contrib/$(LOOPBACK_ALIAS_FILE) $(LOOPBACK_ALIAS); \
	sudo chmod 0644 $(LOOPBACK_ALIAS); \
	sudo launchctl load $(LOOPBACK_ALIAS);

.PHONY: bootstrap_vundle
bootstrap_vundle:
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
