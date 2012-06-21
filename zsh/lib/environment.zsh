# Smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# File rename magick
bindkey "^[m" copy-prev-shell-word

# Jobs
setopt LONG_LIST_JOBS

# Pager
export PAGER="less -R"
export LC_CTYPE=$LANG

setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt PROMPT_SUBST

# Don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt COMPLETE_ALIASES

zle -N newtab
