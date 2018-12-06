source ~/.z.sh

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi