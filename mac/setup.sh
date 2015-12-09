#!/bin/bash

sudo sh -c "echo %`whoami` ALL=\(ALL\) NOPASSWD: ALL >>/etc/sudoers"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

. sync.sh

mkdir ~/goproject

sudo easy_install pip

brew install bash-completion git vim tmux wget go gpm

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall