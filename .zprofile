export PROMPT='%n@%m:%1~ %% '

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

if type brew &>/dev/null && [ -r "$(brew --prefix)/etc/profile.d/z.sh" ]; then
    . $(brew --prefix)/etc/profile.d/z.sh
fi

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path)"
fi
