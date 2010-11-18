# Set zsh path
export ZSH=$HOME/.oh-my-zsh

# Loads oh-my-zsh compatible theme
export ZSH_THEME=""

# Load zsh plugins (found in ~/.oh-my-zsh/plugins/)
# Example: plugins=(git textmate ruby)
plugins=(cap)

# Pull in zsh config
source $ZSH/oh-my-zsh.sh

# Paths
path=($HOME/.bin /usr/local/bin /usr/local/sbin /usr/local/mysql/bin /usr/local/git/bin $path)
manpath=(/usr/local/man /usr/local/mysql/man /usr/local/git/man $manpath)

# Add customizations
