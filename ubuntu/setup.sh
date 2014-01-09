#update source list
sudo apt-get update

#Add PPA
sudo apt-add-repository ppa:webupd8team/sublime-text-2 -s -y
sudo apt-add-repository ppa:chris-lea/node.js -s -y
sudo apt-add-repository ppa:tualatrix/ppa -s -y
sudo apt-add-repository ppa:wiznote-team/ppa -s -y
sudo apt-add-repository ppa:numix/ppa -s -y

sudo apt-get update
#Remove stuff
sudo apt-get purge thunderbird totem libreoffic* xterm xdiagnose remmina transmission-gtk brasero software-center rhythmbox gnome-disk-utility dconf-editor gnome-screenshot baobab empathy gnome-contacts

#install stuff
sudo apt-get install openjdk-7-jdk mysql-client mysql-workbench vim alacarte cifs-utils wiznote cairo-dock ubuntu-tweak terminator git subversion  gimp shutter gparted filezilla ubuntu-restricted-extras

#install fonts
wget -O get-fonts.sh.zip http://files.cnblogs.com/DengYangjun/get-fonts.sh.zip
unzip -o get-fonts.sh.zip 1>/dev/null
chmod a+x get-fonts.sh
./get-fonts.sh
rm -f get-fonts.sh.zip get-fonts.sh

#update /etc/fstab
sudo echo //creative-dev.mediav.com/develop/creative_went /home/wentworth/Repo/creative cifs username=root,password=goodmediav,rw,uid=wentworth >> /etc/fstab
sudo echo //creative-dev.mediav.com/develop/compile_went /home/wentworth/Repo/compile cifs username=root,password=goodmediav,rw,uid=wentworth >> /etc/fstab
sudo echo //creative-dev.mediav.com/develop/wentworth /home/wentworth/Repo/other cifs username=root,password=goodmediav,rw,uid=wentworth >> /etc/fstab

sudo echo 192.168.3.118	test-went.mediav.com >> /etc/hosts
sudo echo 192.168.3.118 api-went.mediav.com >> /etc/hosts
sudo echo 192.168.3.118 creative-dev.mediav.com >> /etc/hosts
sudo echo 192.168.3.118 compile-went.mediav.com >> /etc/hosts
sudo echo 192.168.3.118 creative-went.mediav.com >> /etc/hosts
