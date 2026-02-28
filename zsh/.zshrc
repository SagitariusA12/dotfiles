# ~/.zshrc file for zsh interactive shells
# Rodar neofetch apenas em shells interativos
# if [[ $- == *i* ]] && command -v neofetch >/dev/null 2>&1; then
#     neofetch
# fi
# Não iniciar tmux dentro do tmux
if [[ -o login ]] && command -v fastfetch &>/dev/null; then
  fastfetch
fi

### ===| UTILITÁRIOS |=== ####
eval "$(zoxide init zsh)"

### === OPÇÕES ZSH === ###
setopt autocd
setopt interactivecomments
setopt magicequalsubst
setopt nonomatch
setopt notify
setopt numericglobsort
setopt promptsubst

WORDCHARS=${WORDCHARS//\/}
PROMPT_EOL_MARK=""

### === BINDEOS === ###
bindkey -e
bindkey ' ' magic-space
bindkey '^U' backward-kill-line
bindkey '^[[3;5~' kill-word
bindkey '^[[3~' delete-char
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[5~' beginning-of-buffer-or-history
bindkey '^[[6~' end-of-buffer-or-history
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[Z' undo

### === COMPLETION === ###
autoload -Uz compinit
compinit -d ~/.cache/zcompdump

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

### === HISTÓRICO === ###
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=20000

setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify

alias history="history 0"

### === TÍTULO DO TERMINAL === ###
case "$TERM" in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
    TERM_TITLE=$'\e]0;%n@%m: %~\a'
    precmd() { print -Pn -- "$TERM_TITLE" }
    ;;
esac

### === PROMPT: STARSHIP === ###
eval "$(starship init zsh)"

### === CORES PARA LS, GREP, ETC === ###
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  export LS_COLORS="$LS_COLORS:ow=30;44:"

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias diff='diff --color=auto'
  alias ip='ip --color=auto'

  export LESS_TERMCAP_mb=$'\E[1;31m'
  export LESS_TERMCAP_md=$'\E[1;36m'
  export LESS_TERMCAP_me=$'\E[0m'
  export LESS_TERMCAP_so=$'\E[01;33m'
  export LESS_TERMCAP_se=$'\E[0m'
  export LESS_TERMCAP_us=$'\E[1;32m'
  export LESS_TERMCAP_ue=$'\E[0m'

  zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
  zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
fi

### === ALIAS === ###
alias ls="eza --icons --color=auto --group-directories-first"
alias ll="eza -l --icons --color=auto --group-directories-first"
alias la="eza -la --icons --color=auto --group-directories-first"
alias lt="eza --tree --icons --color=auto --level=2"
alias lta="eza --tree --icons --color=auto --all --level=3"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias alacritty='alacritty --config-file ~/.config/alacritty/alacritty.toml'

### === HIGHLIGHTING === ###
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
  ZSH_HIGHLIGHT_STYLES[default]=none
  ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,underline'
  ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=cyan,bold'
  ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green,underline'
  ZSH_HIGHLIGHT_STYLES[global-alias]='fg=green,bold'
  ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,underline'
  ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=blue,bold'
  ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=magenta,underline'
  ZSH_HIGHLIGHT_STYLES[path]='fg=magenta,bold'
  ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue,bold'
  ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=blue,bold'
  ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=magenta,bold'
  ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=blue,bold'
  ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
  ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=yellow'
  ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=magenta'
  ZSH_HIGHLIGHT_STYLES[redirection]='fg=cyan,bold'
  ZSH_HIGHLIGHT_STYLES[comment]='fg=8,bold'
  ZSH_HIGHLIGHT_STYLES[arg0]='fg=cyan'
  ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=red,bold'
  ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=cyan,bold'
  ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=green,bold'
  ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=magenta,bold'
  ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=yellow,bold'
  ZSH_HIGHLIGHT_STYLES[bracket-level-5]='fg=blue,bold'
  ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='standout'
fi

### === AUTOSUGGESTIONS === ###
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=cyan,underline'
fi

### === COMANDO-NOT-FOUND === ###
if [ -f /etc/zsh_command_not_found ]; then
  . /etc/zsh_command_not_found
fi

### === ENVIRONMENT VARS === ###
export NVM_DIR="$HOME/.nvm"
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$PATH:/opt/android-studio/bin"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
. "$HOME/.cargo/env"

export PATH="$HOME/.cargo/bin:$PATH"

copyfile() {
  xclip -selection clipboard -i "$1"
}

export DOCKER_HOST=unix:///var/run/docker.sock
export PATH="$HOME/.local/bin:$PATH"

# pnpm
export PNPM_HOME="/home/sagittarius/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/home/sagittarius/.bun/_bun" ] && source "/home/sagittarius/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
