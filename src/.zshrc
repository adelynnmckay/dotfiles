# -------------------
# General Settings
# -------------------

# Use UTF-8 encoding
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set history options
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY         # Append history to the file
setopt SHARE_HISTORY          # Share history between terminals
setopt INC_APPEND_HISTORY     # Incremental append to history
setopt HIST_IGNORE_DUPS       # Ignore duplicate entries
setopt HIST_IGNORE_ALL_DUPS   # Ignore older duplicates
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks

# Enable autocorrect for typos
setopt CORRECT

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Enable command completion
autoload -Uz compinit && compinit

# -------------------
# Prompt Settings
# -------------------

# Initialize and set prompt
autoload -Uz promptinit
promptinit

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source Powerlevel10k theme
[[ -e /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme ]] && {
  source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
}

# Source Powerlevel10k configuration
[[ -e ~/.p10k.zsh ]] && source ~/.p10k.zsh

# -------------------
# Directory Navigation
# -------------------

setopt AUTO_CD               # Just type directory name to cd
setopt AUTO_PUSHD            # pushd when changing dirs
setopt PUSHD_IGNORE_DUPS     # No duplicate dirs in stack
DIRSTACKSIZE=10

# -------------------
# Globbing
# -------------------

setopt EXTENDED_GLOB         # Advanced globs like ^*.md
setopt NO_CASE_GLOB          # Case-insensitive globbing

# -------------------
# Path and Environment
# -------------------


# Default editor
export EDITOR='nvim'

# Less colors
export LESS='-R'

# Add Homebrew paths
export PATH="/usr/local/sbin:$PATH"

# Add Pyenv paths
[ -d ~/.pyenv/bin ] && export PATH="$HOME/.pyenv/bin:$PATH"

# Add Rbenv paths
[ -d ~/.rbenv/bin ] && export PATH="$HOME/.rbenv/bin:$PATH"

# Add Node.js local binaries
export PATH=$(pwd)/node_modules/.bin:$PATH

# Other paths
export PYTHON_VERSION=$(ls $HOME/Library/Python)

export PATH="$HOME/.dotnet/tools:$PATH"
export PATH="$HOME/.gem/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="$HOME/Library/Python/${PYTHON_VERSION}/bin:$PATH"
export PATH="/Library/Apple/usr/bin:$PATH"
export PATH="/Library/TeX/texbin:$PATH"
export PATH="/System/Cryptexes/App/usr/bin:$PATH"
export PATH="/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/sbin:$PATH"
export PATH="/usr/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/sbin:$PATH"
export PATH="/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:$PATH"
export PATH="/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:$PATH"
export PATH="/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:$PATH"

# User Scripts
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.bin:$PATH"

# Add current directory to PATH
export PATH=".:$PATH"

# Source global environment variables
[ -f /etc/profile ] && source /etc/profile

# Source local environment variables
[ -f ~/.profile ] && source ~/.profile
[ -f ~/.profile.local ] && source ~/.profile.local
[ -d ~/.profile.d ] && for file in ~/.profile.d/*; do source $file; done
[ -f ~/.env ] && source ~/.env
[ -d ~/.env.d ] && for file in ~/.env.d/*; do source $file; done
[ -d ~/.local/env ] && for file in ~/.local/env/*; do source $file; done

# -------------------
# Key Bindings
# -------------------

# Use vim key bindings
bindkey -v

# Use Ctrl+R for enhanced reverse search
autoload -Uz history-search-end
bindkey '^R' history-search-end

# -------------------
# Aliases
# -------------------

alias ll='ls -lh'
alias la='ls -lha'
alias ..='cd ..'
alias ...='cd ../..'
alias gs='git status'
alias gl='git log'
alias gp='git pull'
alias gc='git commit -m'
alias v='vim'

# -------------------
# Dependency Management
# -------------------

# Install Homebrew (macOS package manager) if not installed
command -v brew >/dev/null 2>&1 || {
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# Install Git if not installed
command -v git >/dev/null 2>&1 || {
  echo "Installing Git..."
  brew install git
}

# Install Pyenv if not installed
command -v pyenv >/dev/null 2>&1 || {
  echo "Installing Pyenv..."
  brew install pyenv
}

# Install Rbenv if not installed
command -v rbenv >/dev/null 2>&1 || {
  echo "Installing Rbenv..."
  brew install rbenv
}

# Install Zsh Autosuggestions if not installed
[[ -e /opt/homebrew/share/zsh-autosuggestions ]] || {
  echo "Installing Zsh Autosuggestions..."
  brew install zsh-autosuggestions
}

# Install Zsh Syntax Highlighting if not installed
[[ -e /opt/homebrew/share/zsh-syntax-highlighting ]] || {
  echo "Installing Zsh Syntax Highlighting..."
  brew install zsh-syntax-highlighting
}

# Install and configure Powerlevel10k if not installed
[[ -e /opt/homebrew/share/powerlevel10k ]] || {
  echo "Installing Powerlevel10k..."
  brew install romkatv/powerlevel10k/powerlevel10k
}

# Install Nerdfonts if not installed (required by Powerlevel10k)
[[ -e ~/Library/Fonts/MesloLGLNerdFont-Regular.ttf ]] || {
  echo "Installing Nerdfonts..."
  brew tap homebrew/cask-fonts
  brew install --cask font-meslo-lg-nerd-font
}

# Install Oh-My-Zsh if not installed
[[ -e ~/.oh-my-zsh ]] || {
  echo "Installing Oh-My-Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# -------------------
# Plugins and Frameworks
# -------------------

# Load Oh-My-Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_PLUGINS=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Enable autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Enable syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# -------------------
# Functions
# -------------------

# Make a directory and move into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Git branch in the prompt
git_branch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null
}

# -------------------
# Source Local Configuration
# -------------------

# If a local .zshrc exists, source it (for machine-specific overrides)
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
