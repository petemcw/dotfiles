# Load functions
autoload -U $ZSH/zsh/functions/*(:t)

function zsh_stats() {
    history | awk '{print $2}' | sort | uniq -c | sort -rn | head
}

function take() {
    mkdir -p $1
    cd $1
}
