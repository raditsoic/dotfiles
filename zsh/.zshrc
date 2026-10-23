#------------------------------------------------------------------------------
# Powerlevel10k instant prompt
#------------------------------------------------------------------------------
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#------------------------------------------------------------------------------
# Zinit and plugins
#------------------------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-history-substring-search

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#------------------------------------------------------------------------------
# Completion
#------------------------------------------------------------------------------
fpath=($fpath /usr/share/zsh/vendor-completions)

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' case-sensitive false
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

#------------------------------------------------------------------------------
# Keybindings
#------------------------------------------------------------------------------
stty -ixon                                  # free Ctrl+Q/Ctrl+S from terminal flow control

# History search (arrow keys)
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Line editing
bindkey "^K" clear-screen                   # Ctrl+K clear screen
bindkey '^[k' kill-line                     # Alt+K kill to end of line
bindkey '^J' kill-word                      # Ctrl+J kill word forward
bindkey '^D' backward-kill-word             # Ctrl+D kill word backward
bindkey '^Q' delete-char                    # Ctrl+Q delete char under cursor
bindkey "^L" end-of-line                    # Ctrl+L end of line
bindkey -r '^E'                             # disable Ctrl+E
bindkey '^[[1;5C' forward-word              # Ctrl+Right
bindkey '^[[1;5D' backward-word             # Ctrl+Left
bindkey '^[[H' beginning-of-line            # Home
bindkey '^[[3~' delete-char                 # Delete

# Alt+Enter inserts a newline instead of running the command
insert-newline() { LBUFFER+=$'\n' }
zle -N insert-newline
bindkey '^[^M' insert-newline

# Autosuggestions
bindkey '^ ' autosuggest-accept             # Ctrl+Space accept suggestion
bindkey '^F' forward-char                   # Ctrl+F forward one char

#------------------------------------------------------------------------------
# Report cwd to the terminal (OSC 7) so WezTerm splits open in the same dir
#------------------------------------------------------------------------------
_osc7_cwd() {
  local LC_ALL=C i ch hex out=""
  for ((i = 1; i <= ${#PWD}; i++)); do
    ch=${PWD[i]}
    case $ch in
      [a-zA-Z0-9/._~-]) out+=$ch ;;
      *) printf -v hex '%%%02X' "'$ch"; out+=$hex ;;
    esac
  done
  printf '\e]7;file://%s%s\e\\' "${HOST}" "$out"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _osc7_cwd

#------------------------------------------------------------------------------
# History
#------------------------------------------------------------------------------
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_expire_dups_first
setopt extended_history                     # Save timestamp in history

#------------------------------------------------------------------------------
# Aliases
#------------------------------------------------------------------------------
alias ls='ls --color'
alias ll='ls -lah'                          # Detailed list view
alias la='ls -A'                            # Show hidden files
alias l='ls -CF'                            # Column view
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'              # Colorize grep output

# Docker
alias d='docker'
alias de='docker exec'
alias db='docker build'
alias dr='docker run'
alias dpsh='docker push'
alias dpl='docker pull'
alias dcu='docker compose up'
alias dcd='docker compose down'
alias dcr='docker compose run'
alias dcb='docker compose build'

# Kubernetes
alias kc='kubectl'
alias kd='kind'

# Terraform
alias tf='terraform'

# C++
alias g++='g++ -std=c++23 -pedantic'

# Python
alias py=/usr/bin/python3
alias python=/usr/bin/python3

#------------------------------------------------------------------------------
# Tool integrations
#------------------------------------------------------------------------------
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
  compdef kc=kubectl
fi

source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi


# Bun
[ -s "/home/soic/.bun/_bun" ] && source "/home/soic/.bun/_bun"

# Cursor
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

# Vagrant
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS=1
fpath=(/opt/vagrant/embedded/gems/gems/vagrant-2.4.9/contrib/zsh $fpath)

# Single compinit call; must run after every fpath change above
autoload -Uz compinit && compinit -i

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

#------------------------------------------------------------------------------
# Environment and PATH
#------------------------------------------------------------------------------
VIRTUAL_ENV_DISABLE_PROMPT=0

# Go
export PATH=$PATH:/usr/local/go/bin
export PATH="$PATH:$HOME/go/bin"

# PHP (herd-lite)
export PATH="$HOME/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="$HOME/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"

# Jupyter
export PATH="$PATH:$HOME/.local/bin/jupyter"
export PATH="$PATH:/%HOME/.local/bin/jupyter"

# Rust
export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"
export PATH="$CARGO_HOME/bin:$PATH"
if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi

# Spark
export SPARK_HOME=/opt/spark
export PATH=$SPARK_HOME/bin:$PATH

# Misc
export PATH="$PATH:$(pwd)/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH=$PATH:/snap/bin

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# Zoxide (after PATH setup, ~/.local/bin holds zoxide)
eval "$(zoxide init zsh)"
