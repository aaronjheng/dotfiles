export PROMPT='%n@%m:%1~ %% '

autoload -Uz compinit
compinit

if [ -r "$(brew --prefix)/etc/profile.d/z.sh" ]; then
    . $(brew --prefix)/etc/profile.d/z.sh
fi

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path)"
fi
