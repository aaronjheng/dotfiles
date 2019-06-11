export PS1='%n@%m:%1~$ '

if [ -r ~/.z.sh ]; then
    . ~/.z.sh
fi

fpath=(/usr/local/share/zsh-completions $fpath)

autoload -U compinit
compinit
