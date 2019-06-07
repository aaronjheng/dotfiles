export PS1='\u@\h:\W$ '

[[ -r "`brew --prefix`/etc/profile.d/bash_completion.sh" ]] \
    && . "`brew --prefix`/etc/profile.d/bash_completion.sh"

if [ -r ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ -r ~/.z.sh ]; then
    . ~/.z.sh
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
