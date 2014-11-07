#!/bin/bash
#
root_dir=$(cd "$(dirname "$0")"; pwd)
user=`whoami`
#Prepare
sudo sh -c "echo %$user ALL=\(ALL:ALL\) NOPASSWD: ALL >> /etc/sudoers"
sudo passwd root
sudo apt-get update
sudo apt-get -y purge apturl gnome-sudoku gnome-mines gnome-mahjongg gnome-orca simple-scan onboard webbrowser-app totem libreoffic* xterm xdiagnose remmina transmission-gtk brasero software-center rhythmbox gnome-disk-utility dconf-editor gnome-screenshot baobab empathy gnome-contacts

#Add PPAs
sudo apt-add-repository ppa:webupd8team/sublime-text-2 -s -y
sudo apt-add-repository ppa:chris-lea/node.js -s -y
sudo apt-add-repository ppa:tualatrix/ppa -s -y
sudo apt-add-repository ppa:wiznote-team/ppa -s -y
sudo apt-add-repository ppa:numix/ppa -s -y

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

curl https://spideroak.com/dist/spideroak-apt-2013.asc | sudo apt-key add -
sudo sh -c 'echo "deb http://apt.spideroak.com/ubuntu-spideroak-hardy/ release restricted" >> /etc/apt/sources.list.d/spideroak.list'

sudo apt-get update

#Install apps
sudo apt-get -y install google-chrome-stable spideroak sublime-text vim meld subversion git terminator openjdk-7-jdk mysql-client alacarte wiznote cairo-dock ubuntu-tweak gimp shutter gparted filezilla numix-gtk-theme numix-icon-theme


#install fonts
. ./fonts.sh

rsync -av --exclude-from=rsyncexclude  $root_dir/ ~

#cofiguration
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall