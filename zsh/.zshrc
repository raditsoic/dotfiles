typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Zsh Plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-history-substring-search

# Completion Setup
fpath=($fpath /usr/share/zsh/vendor-completions)
autoload -Uz compinit && compinit -i

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Search Keybindings
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Command Keybindings
bindkey "^K" kill-line
bindkey "^E" end-of-line
bindkey '^[[1;5C' forward-word      # Ctrl+Right
bindkey '^[[1;5D' backward-word     # Ctrl+Left
bindkey '^[[H' beginning-of-line    # Home
bindkey '^[[F' end-of-line          # End
bindkey '^[[3~' delete-char         # Delete

# Autosuggestion keybindings
bindkey '^ ' autosuggest-accept     # Ctrl+Space to accept suggestion
bindkey '^F' autosuggest-accept     # Ctrl+F to accept suggestion

# History
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
setopt extended_history             # Save timestamp in history

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' case-sensitive false
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select    # Use menu selection
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias ll='ls -lah'                  # Detailed list view
alias la='ls -A'                    # Show hidden files
alias l='ls -CF'                    # Column view
alias nano='nano'
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'      # Colorize grep output

## Docker Aliases
alias d='docker'
alias de='docker exec'
alias db='docker build'
alias dr='docker run'
alias dpsh='docker push'
alias dpl='docker pull'
alias dcu='docker-compose up'
alias dcb='docker-compose build'
alias dcd='docker-compose down'
alias dcr='docker-compose run'
alias dcu='docker compose up'
alias dcd='docker compose down'
alias dcr='docker compose run'
alias dcb='docker compose build'

# Shell integrations
source ~/.fzf.zsh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias py=/usr/bin/python3
alias python=/usr/bin/python3

# Zoxide
eval "$(zoxide init zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/google-cloud-sdk/completion.zsh.inc'; fi

export PATH=$PATH:/usr/local/go/bin
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$HOME/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="$HOME/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PATH:$HOME/.local/bin/jupyter"

# Golang
export PATH=$PATH:/usr/local/go/bin
export PATH="$PATH:$(go env GOPATH)/bin"

# Rust
export CARGO_HOME="$HOME/.cargo"
export PATH="$CARGO_HOME/bin:$PATH"
export RUSTUP_HOME="$HOME/.rustup"
if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi

# Jupyter
export PATH="$PATH:/%HOME/.local/bin/jupyter"

# Spark
export SPARK_HOME=/opt/spark
export PATH=$SPARK_HOME/bin:$PATH
export PATH="$PATH:$(pwd)/bin"
export PATH="$PATH:$HOME/.local/bin"

# C++ Config
alias g++='g++ -std=c++23 -pedantic'

# Visual
VIRTUAL_ENV_DISABLE_PROMPT=0
export PATH=$PATH:/snap/bin

# Cursor 
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi


