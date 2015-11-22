#!/bin/bash

sudo sh -c "echo %wentworth ALL=\(ALL\) NOPASSWD: ALL /etc/sudoers" -p it901694
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install bash-completion wget git

sudo easy_install pip

mkdir ~/goproject

brew install vim
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

. sync.sh
