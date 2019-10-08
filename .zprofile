if [ -r ~/.z.sh ]; then
    . ~/.z.sh
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

fpath=(/usr/local/share/zsh-completions $fpath)

autoload -U compinit
compinit
