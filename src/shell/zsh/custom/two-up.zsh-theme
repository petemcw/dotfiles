PROMPT='
$(user_name) at $(box_name) in $(directory_name) $(git_prompt_info)$(git_prompt_status)
$(prompt_caret)%{$reset_color%} '

RPROMPT='$(ruby_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="on "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"

ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[red]%}↑%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[red]%}↓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIVERGED="%{$fg[red]%}↕%{$reset_color%}"

# Change prompt character based on UID
prompt_caret() {
  if [ $UID -eq 0 ]; then echo "%{$fg[red]%}»"; else echo "%{$fg[white]%}›"; fi
}

# Current user
user_name() {
  echo "%{$fg[magenta]%}%n%{$reset_color%}"
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

# Get active branch
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Print Git branch name
git_branch() {
  echo "$(git symbolic-ref HEAD 2> /dev/null | awk -F/ {'print $NF'})"
}

# Check for rbenv
if [[ $+commands[rbenv] -eq 1 ]] ; then
  function ruby_prompt_info() {
    if [[ -n $(current_gemset) ]] ; then
      echo "%{$fg_bold[yellow]%}$(current_ruby)@$(current_gemset)%{$reset_color%}"
    else
      echo "%{$fg_bold[yellow]%}$(current_ruby)%{$reset_color%}"
    fi
  }
  function current_ruby() {
    echo "$(rbenv version-name)"
  }
  function current_gemset() {
    echo "$(rbenv gemset active 2&>/dev/null | sed -e ":a" -e '$ s/\n/+/gp;N;b a' | head -n1)"
  }
else
  # Fallback to system
  function ruby_prompt_info() { echo "%{$fg_bold[yellow]%}$(ruby -v | cut -f-2 -d ' ')%{$reset_color%}" }
fi
