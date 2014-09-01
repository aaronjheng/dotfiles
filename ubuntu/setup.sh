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

sudo apt-get update

#install chrome
if [ "$(uname -m)" = "x86_64" ]; then
	chrome_pack_name=google-chrome-stable_current_amd64.deb
else
	chrome_pack_name=google-chrome-stable_current_i386.deb
fi
sudo apt-get -y install libxss1
wget https://dl.google.com/linux/direct/$chrome_pack_name
sudo dpkg -i $chrome_pack_name
rm -f $chrome_pack_name

#Set up development enviroment
sudo apt-get -y install sublime-text vim meld subversion git terminator openjdk-7-jdk mysql-client alacarte wiznote cairo-dock ubuntu-tweak gimp shutter gparted filezilla numix-gtk-theme numix-icon-theme

#install fonts
target_fonts_dir=/usr/share/fonts/truetype/myfonts
source_fonts_dir=$root_dir/fonts

sudo mkdir $target_fonts_dir 2>/dev/null
sudo cp -rf -t $target_fonts_dir $source_fonts_dir

sudo mv /etc/fonts/conf.avail/51-local.conf /etc/fonts/conf.avail/51-local.conf.old
sudo cp -f $root_dir/local.fonts.conf /etc/fonts/conf.avail/51-local.conf

cd /etc/fonts/conf.avail
sudo mv 69-language-selector-zh-cn.conf 69-language-selector-zh-cn.conf.old 2>/dev/null

cd $target_fonts_dir
sudo chmod 555 *
sudo mkfontscale 1>/dev/null
sudo mkfontdir 1>/dev/null
sudo fc-cache -v 1>/dev/null

rsync -av --exclude-from=rsyncexclude  $root_dir/ ~