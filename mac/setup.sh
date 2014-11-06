#!/bin/bash

sudo sh -c "echo %wentworth ALL=\(ALL\) NOPASSWD:ALL" -p it901694
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

brew install bash-completion wget 

brew install git
git config --global user.name "wentworth"
git config --global user.email "wentworth@outlook.com"
git config --global merge.tool extMerge
git config --global mergetool.extMerge.cmd 'extMerge "$BASE" "$LOCAL" "$REMOTE" "$MERGED"'
git config --global mergetool.trustExitCode false
git config --global diff.external extDiff
git config --global color.ui true

cat >> /usr/local/bin/extMerge <<< "EOF"
#!/bin/sh
/Applications/p4merge.app/Contents/MacOS/p4merge $*
EOF

cat >> /usr/local/bin/extDiff <<< "EOF"
#!/bin/sh
[ $# -eq 7 ] && /usr/local/bin/extMerge "$2" "$5"
EOF

sudo chmod +x /usr/local/bin/extDiff /usr/local/bin/extMerge

sudo easy_install pip

rsync -av --exclude='.DS_Store' --exclude='setup.sh'  . ~

brew install vim
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
