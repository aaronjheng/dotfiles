#Prepare
sudo sh -c "echo %wentworth ALL=\(ALL:ALL\) NOPASSWD: ALL" -p it901694
sudo apt-get update
sudo apt-get -y purge webbrowser-app thunderbird totem libreoffic* xterm xdiagnose remmina transmission-gtk brasero software-center rhythmbox gnome-disk-utility dconf-editor gnome-screenshot baobab empathy gnome-contacts

#Add PPAs
sudo apt-add-repository ppa:webupd8team/sublime-text-2 -s -y
sudo apt-add-repository ppa:chris-lea/node.js -s -y
sudo apt-add-repository ppa:tualatrix/ppa -s -y
sudo apt-add-repository ppa:wiznote-team/ppa -s -y
sudo apt-add-repository ppa:numix/ppa -s -y
sudo add-apt-repository ppa:caldas-lopes/ppa -s -y

sudo apt-get update

#update /ets/hosts
sudo sh -c 'echo 192.168.3.118 test-went.mediav.com >> /etc/hosts'
sudo sh -c 'echo 192.168.3.118 api-went.mediav.com >> /etc/hosts'
sudo sh -c 'echo 192.168.3.118 creative-went.mediav.com >> /etc/hosts'
#Remote mount configuration
sudo apt-get -y install cifs-utils
sudo sh -c 'echo //creative-went.mediav.com/develop/wentworth /home/wentworth/Repo/dev cifs username=root,password=goodmediav,rw,uid=wentworth >> /etc/fstab'

#install chrome
chrome_pack_name=google-chrome-stable_current_amd64.deb
sudo apt-get -y install libxss1
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i $chrome_pack_name
cat ../chrome/Custom.css > ~/.config/google-chrome/Default/User\ StyleSheets/Custom.css
rm -f $chrome_pack_name

#Set up development enviroment
sudo apt-get -y install sublime-text vim meld subversion
sudo apt-get -y install git
git config --global user.name "wentworth"
git config --global user.email "wentworth@outlook.com"
git config --global core.editor vim
git config --global merge.tool vimdiff

sudo apt-get -y install terminator
cp ../terminator ~/.config/terminator

#install stuff
sudo apt-get -y install openjdk-7-jdk mysql-client mysql-workbench alacartewiznote cairo-dock ubuntu-tweak gimp shutter gparted filezilla numix-gtk-theme numix-icon-theme ezame ubuntu-restricted-extras

#install fonts
wget -O get-fonts.sh.zip http://files.cnblogs.com/DengYangjun/get-fonts.sh.zip
unzip -o get-fonts.sh.zip 1>/dev/null
chmod a+x get-fonts.sh
./get-fonts.sh
rm -f get-fonts.sh.zip get-fonts.sh
