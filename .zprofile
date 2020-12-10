export PROMPT='%n@%m:%1~ %% '

if [ -r "$(brew --prefix)/etc/profile.d/z.sh" ]; then
    . $(brew --prefix)/etc/profile.d/z.sh
fi

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

if [ $commands[kubectl] ]; then
    source <(kubectl completion zsh)
fi
