
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

wmcd() {
    cd "$(command workspace-manager "$@")"
}

alias fzf='fzf-tmux -p'
alias ll='ls -alhF --color'
alias ls='ls -aCF --color'
alias l='ls'
alias vi='nvim'
alias v='nvim'
alias vf='nvim -c "Telescope find_files"'
alias code='code-insiders'
alias doc2pdf='libreoffice --writer --convert-to pdf'
alias treel='tree -pugshD'
alias lf='lfcd'
alias wm='wmcd'
alias wp='wm pick'
alias wpv="wm pick && v"
alias wpvf="wm pick && vf"
alias wpvg="wm pick && vg"
alias bt='bluetoothctl'
alias c='cd'
alias '??'='gh copilot suggest -t shell'
alias 'git?'='gh copilot suggest -t git'
alias 'gh?'='gh copilot suggest -t gh'
alias g='git'
alias wshowkeys='command wshowkeys -F jebrains-mono -a bottom'

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=(precmd_vcs_info)
zstyle ':vcs_info:git:*' formats '%F{#fab387} %b%f '

setopt PROMPT_SUBST
PROMPT='[%F{#b4befe}%n%f@%F{#b4befe}%m%f] %B%F{#89b4fa}%2~%f%b ${vcs_info_msg_0_}%F{#94e2d5}$%f '

export PATH

[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

export EDITOR="nvim"

source ~/.zsh/catppuccin/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
