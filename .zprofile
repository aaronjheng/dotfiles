export PROMPT='%n@%m:%1~ %% '

if [ -r ~/.z.sh ]; then
    . ~/.z.sh
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

autoload -U compinit
compinit
