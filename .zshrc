
# The following lines were added by compinstall

zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' max-errors 3 numeric
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt autocd beep notify
bindkey -v
# End of lines configured by zsh-newuser-install

bindkey '^R' history-incremental-search-backward
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[v' vi-cmd-mode

alias ll='ls -alF'
alias l='ls -aCF'
alias vi='nvim'
alias code='code-insiders'
alias doc2pdf='libreoffice --writer --convert-to pdf'
alias treel='tree -pugshD'

autoload -Uz vcs_info # enable vcs_info
precmd () { vcs_info } # always load before displaying the prompt
zstyle ':vcs_info:*' formats ' %s(%b)' # git(main)

PROMPT='[%n@%m %1~]$ '

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

if ! [[ "$PATH" =~ "$HOME/.cargo/bin:" ]]
then
    PATH="$HOME/.cargo/bin:$PATH"
fi

export PATH

[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env
