#!/bin/bash
set -e

ROOT=$(cd "$(dirname "$0")"; pwd)
OS=`uname -s`

if [ "$OS" = "Darwin" ]
then
    postfix="mac"
elif [ "$OS" = "Linux" ]
then
    postfix="ubuntu"
else
    echo "OS not suported"
    exit 1
fi

pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command popd "$@" > /dev/null
}

sync_dotfiles(){
    pushd $ROOT/common
    rsync -aq --exclude-from=rsyncexclude  . ~
    popd
    pushd $ROOT/$postfix
    rsync -aq --exclude-from=rsyncexclude  . ~
    popd
}

install_mac(){
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install bash-completion git tmux wget go gpm python

    sync_dotfiles

    _install_vundle

    mkdir ~/goproject
}

install_ubuntu(){
    sudo passwd root

    sudo apt-get update
    sudo apt-get -y purge apturl gnome-sudoku gnome-mines gnome-mahjongg gnome-orca simple-scan onboard webbrowser-app totem libreoffic* xterm xdiagnose remmina transmission-gtk brasero software-center rhythmbox gnome-disk-utility dconf-editor gnome-screenshot baobab empathy gnome-contacts
    sudo apt-get autoremove -y
    #Add PPAs
    sudo apt-add-repository ppa:webupd8team/sublime-text-2 -s -y
    sudo apt-add-repository ppa:wiznote-team/ppa -s -y
    sudo apt-add-repository ppa:numix/ppa -s -y

    # wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    # sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
    # sudo apt-get install google-chrome-stable

    sudo apt-get update

    #Install apps
    sudo apt-get -y install sublime-text vim meld git terminator alacarte wiznote cairo-dock gparted numix-gtk-theme numix-icon-theme

    sudo rsync -av ubuntu/sublime-icons/ /usr/share/icons/hicolor/

    sync_dotfiles

    _install_vundle
}

_install_vundle(){
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
}

pushd $ROOT

if [ "$1" = "sync" ]
then
    sync_dotfiles
elif [ "$1" = "install" ]
then
    install_$postfix
else
    echo "Invalid action"
    exit 1
fi

popd