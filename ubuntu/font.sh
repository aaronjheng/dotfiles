#!/bin/bash
#
root_dir=$(cd "$(dirname "$0")"; pwd)


#install fonts
target_fonts_dir=/usr/share/fonts/truetype/myfonts
source_fonts_dir=$root_dir/fonts

sudo mkdir $target_fonts_dir 2>/dev/null
sudo cp -rf -t $target_fonts_dir $source_fonts_dir/*

sudo mv /etc/fonts/conf.avail/51-local.conf /etc/fonts/conf.avail/51-local.conf.old
sudo cp -f $root_dir/local.fonts.conf /etc/fonts/conf.avail/51-local.conf

cd /etc/fonts/conf.avail
sudo mv 69-language-selector-zh-cn.conf 69-language-selector-zh-cn.conf.old 2>/dev/null

cd $target_fonts_dir
sudo chmod 555 *
sudo mkfontscale 1>/dev/null
sudo mkfontdir 1>/dev/null
sudo fc-cache -v 1>/dev/null