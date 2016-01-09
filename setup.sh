#!/bin/bash
set +e

ROOT=$(cd "$(dirname "$0")"; pwd)
OS=`uname -s`

if [ "$OS" = "Darwin" ]
then
    postfix="mac"
    sublime_text_preferences_dir="~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/"
elif [ "$OS" = "Linux" ]
then
    postfix="ubuntu"
    sublime_text_preferences_dir="~/.config/Sublime\ Text\ 2/Packages/User/"
else
    echo "OS not suported"
    exit 1
fi

sync_files(){
    pushd $ROOT/common
    rsync -av --exclude-from=rsyncexclude  . ~
    popd
    pushd $ROOT/$postfix
    rsync -av --exclude-from=rsyncexclude  . ~
    popd
    sync_sublime_text_preferences
}

sync_sublime_text_preferences() {
    eval rsync -av $ROOT/sublime-text/ $sublime_text_preferences_dir
}

install_mac(){
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install bash-completion git tmux wget go gpm python

    sync_files

    _install_vundle

    mkdir ~/goproject
}

install_ubuntu(){
    sudo passwd root
    sudo apt-get update
    sudo apt-get -y purge apturl gnome-sudoku gnome-mines gnome-mahjongg gnome-orca simple-scan onboard webbrowser-app totem libreoffic* xterm xdiagnose remmina transmission-gtk brasero software-center rhythmbox gnome-disk-utility dconf-editor gnome-screenshot baobab empathy gnome-contacts
    #Add PPAs
    sudo apt-add-repository ppa:webupd8team/sublime-text-2 -s -y
    sudo apt-add-repository ppa:tualatrix/ppa -s -y
    sudo apt-add-repository ppa:wiznote-team/ppa -s -y
    sudo apt-add-repository ppa:numix/ppa -s -y

    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

    sudo apt-get update

    #Install apps
    sudo apt-get -y install google-chrome-stable sublime-text vim meld subversion git terminator openjdk-7-jdk mysql-client alacarte wiznote cairo-dock ubuntu-tweak gimp shutter gparted filezilla numix-gtk-theme numix-icon-theme

    sync_files

    _install_vundle

    _install_fonts
}

_install_vundle(){
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
}

_install_fonts(){

    pushd $ROOT/ubuntu

    #install fonts
    target_fonts_dir=/usr/share/fonts/truetype/myfonts

    if [ -d "$target_fonts_dir" ]; then
        sudo rm -rf  $target_fonts_dir
    fi

    sudo mkdir $target_fonts_dir 2>/dev/null
    sudo cp -rf -t $target_fonts_dir fonts/*

    sudo mv /etc/fonts/conf.avail/51-local.conf /etc/fonts/conf.avail/51-local.conf.old
    sudo cp -f local.fonts.conf /etc/fonts/conf.avail/51-local.conf

    pushd /etc/fonts/conf.avail
    sudo mv 69-language-selector-zh-cn.conf 69-language-selector-zh-cn.conf.old 2>/dev/null
    popd

    sudo chmod 555 *
    sudo mkfontscale 1>/dev/null
    sudo mkfontdir 1>/dev/null
    sudo fc-cache -v 1>/dev/null
    popd
}

pushd $ROOT

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