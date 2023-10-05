
# The following lines were added by compinstall

zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' max-errors 3 numeric
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt autocd beep notify
bindkey -v
# End of lines configured by zsh-newuser-install

bindkey '^R' history-incremental-search-backward
bindkey '^F' history-incremental-search-forward
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[v' vi-cmd-mode

lfcd() {
    cd "$(command lf -print-last-dir "$@")"
}

alias ll='ls -alhF'
alias l='ls -aCF'
alias vi='nvim'
alias code='code-insiders'
alias doc2pdf='libreoffice --writer --convert-to pdf'
alias treel='tree -pugshD'
alias lf='lfcd'

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=(precmd_vcs_info)
zstyle ':vcs_info:git:*' formats '%F{166} %b%f '

setopt PROMPT_SUBST
PROMPT='[%n@%m] %B%F{031}%2~%f%b ${vcs_info_msg_0_}%F{040}$%f '

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

if ! [[ "$PATH" =~ "$HOME/.cargo/bin:" ]]
then
    PATH="$HOME/.cargo/bin:$PATH"
fi

if ! [[ "$PATH" =~ "$HOME/go/bin:" ]]
then
    PATH="$HOME/go/bin:$PATH"
fi

export PATH

[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

export EDITOR="nvim"
