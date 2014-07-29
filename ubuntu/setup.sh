user=`whoami`
#Prepare
sudo sh -c "echo %$user ALL=\(ALL:ALL\) NOPASSWD: ALL >> /etc/sudoers"
sudo apt-get update
sudo apt-get -y purge gnome-sudoku gnome-mines gnome-mahjongg gnome-orca simple-scan onboard webbrowser-app totem libreoffic* xterm xdiagnose remmina transmission-gtk brasero software-center rhythmbox gnome-disk-utility dconf-editor gnome-screenshot baobab empathy gnome-contacts

#Add PPAs
sudo apt-add-repository ppa:webupd8team/sublime-text-2 -s -y
sudo apt-add-repository ppa:chris-lea/node.js -s -y
sudo apt-add-repository ppa:tualatrix/ppa -s -y
sudo apt-add-repository ppa:wiznote-team/ppa -s -y
sudo apt-add-repository ppa:numix/ppa -s -y

sudo apt-get update

#update /ets/hosts
sudo sh -c 'echo 192.168.3.118 test-went.mediav.com >> /etc/hosts'
sudo sh -c 'echo 192.168.3.118 api-went.mediav.com >> /etc/hosts'
sudo sh -c 'echo 192.168.3.118 creative-went.mediav.com >> /etc/hosts'
#Remote mount configuration
sudo apt-get -y install cifs-utils
sudo sh -c 'echo //creative-went.mediav.com/develop/$user /home/$user/Repo/dev cifs username=root,password=goodmediav,rw,uid=$user >> /etc/fstab'

#install chrome
chrome_pack_name=google-chrome-stable_current_amd64.deb
sudo apt-get -y install libxss1
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i $chrome_pack_name
rm -f $chrome_pack_name

#Set up development enviroment
sudo apt-get -y install sublime-text vim meld subversion git terminator openjdk-7-jdk mysql-client mysql-workbench alacarte wiznote cairo-dock ubuntu-tweak gimp shutter gparted filezilla numix-gtk-theme numix-icon-theme

#install fonts
target_fonts_dir=/usr/share/fonts/truetype/myfonts
root_dir=$(cd "$(dirname "$0")"; pwd)
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

rsync -av --exclude-from=rsyncexclude  . ~
