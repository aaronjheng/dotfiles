#!/bin/bash

sudo sh -c "echo %wentworth ALL=\(ALL\) NOPASSWD:ALL" -p it901694
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

brew install bash-completion wget homebrew/completions/pip-completion

brew install git

sudo easy_install pip

rsync -av --exclude='.DS_Store' --exclude='setup.sh'  . ~

# brew install vim
# git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# vim +PluginInstall +qall
