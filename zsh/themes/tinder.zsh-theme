PROMPT='
$(user_name) at $(box_name) in $(directory_name) $(git_prompt_info)$(git_prompt_status)$(check_push)
$(prompt_caret)%{$reset_color%} '

RPROMPT=''

ZSH_THEME_GIT_PROMPT_PREFIX="on "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}"

ZSH_THEME_GIT_PROMPT_ADDED=""
ZSH_THEME_GIT_PROMPT_MODIFIED=""
ZSH_THEME_GIT_PROMPT_DELETED=""
ZSH_THEME_GIT_PROMPT_RENAMED=""
ZSH_THEME_GIT_PROMPT_UNMERGED=""
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[white]%}•"

# Change prompt character based on UID
prompt_caret() {
    if [ $UID -eq 0 ]; then echo "%{$fg[red]%}»"; else echo "%{$fg[white]%}›"; fi
}

# Current user
user_name() {
    echo "%{$fg[magenta]%}%n%{$reset_color%}"
}

charge_remaining() {
    echo `~/.bin/battery Discharging 2>/dev/null`
}

# Capture machine's hostname
box_name() {
    if [ -f ~/.box-name ]; then HOST="$(cat ~/.box-name)"; else HOST="$(hostname -s)"; fi
    echo "%{$fg[yellow]%}$HOST%{$reset_color%}"
}

# Get current directory name
directory_name() {
    echo "%{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}"
}

# Print RVM version
rvm_prompt() {
    if $(which rvm &> /dev/null)
    then
        echo "%{$fg_bold[yellow]%}$(rvm tools identifier)%{$reset_color%} "
    else
        echo ""
    fi
}

# Find commits not merged upstream
check_push() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    if [[ -n $(git cherry -v origin/${ref#refs/heads/} 2> /dev/null) ]]; then
        echo "%{$fg_bold[red]%}⚡%{$reset_color%} "
    else
        echo ""
    fi
}

# Get active branch
git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Print Git branch name
git_branch() {
    echo "$(git symbolic-ref HEAD 2> /dev/null | awk -F/ {'print $NF'})"
}
