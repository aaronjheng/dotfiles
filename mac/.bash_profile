source ~/.z.sh

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'