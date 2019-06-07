export PS1='\u@\h:\W$ '

source ~/.z.sh

[[ -r "`brew --prefix`/etc/profile.d/bash_completion.sh" ]] \
    && . "`brew --prefix`/etc/profile.d/bash_completion.sh"

if [ -r ~/.bashrc ]; then
    . ~/.bashrc
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi