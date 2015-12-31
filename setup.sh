#!/bin/bash

set +e
root_dir=$(cd "$(dirname "$0")"; pwd)

OS=`uname -s`
if [ "$OS" = "Darwin" ]
then
    postfix="mac"
    sublime_text_preferences_dir="~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/"
else
    echo "OS not suported"
    exit 1
fi

sync_files() {
    pushd $root_dir/common
    rsync -av --exclude-from=rsyncexclude  . ~
    popd
    pushd $root_dir/$postfix
    rsync -av --exclude-from=rsyncexclude  . ~
    popd
    sync_sublime_text_preferences
}

sync_sublime_text_preferences() {
    eval rsync -av $root_dir/sublime-text/ $sublime_text_preferences_dir
}

install_mac() {
   ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
   brew install bash-completion git tmux wget go gpm python

   sync_files

   git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
   vim +PluginInstall +qall

   mkdir ~/goproject
}
pushd $root_dir

if [ "$1" = "sync" ]
then
    sync_files
elif [ "$1" = "install" ]
then
    install_$postfix
else
    echo "Invalid action"
    exit 1
fi

popd