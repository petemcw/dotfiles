# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
export ZSH_THEME="petemcw"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew cap)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

path=($HOME/.bin /usr/local/bin /usr/local/sbin /usr/local/mysql/bin /usr/local/git/bin $path)
manpath=(/usr/local/man /usr/local/mysql/man /usr/local/git/man $manpath)

# This loads RVM into a shell session
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
rvm ruby-1.9.2-head
