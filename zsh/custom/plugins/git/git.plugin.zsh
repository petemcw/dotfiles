# Handy Git Aliases
alias g='git'
compdef g=git
alias gst='git status'
compdef _git gst=git-status
alias gl='git pull'
compdef _git gl=git-pull
alias gf='git fetch'
compdef _git gf=git-fetch
alias gup='git fetch && git rebase'
compdef _git gup=git-fetch
alias gp='git push'
compdef _git gp=git-push
alias gd='git diff --color'
compdef _git gd=git-diff
gdv() { git diff -w "$@" | view - }
compdef _git gdv=git-diff
alias gc='git commit -v'
compdef _git gc=git-commit
alias gca='git commit -v -a'
compdef _git gca=git-commit
alias gco='git checkout'
compdef _git gco=git-checkout
alias gcm='git checkout master'
alias gb='git branch'
compdef _git gb=git-branch
alias gba='git branch -a'
compdef _git gba=git-branch
alias gcount='git shortlog -sn'
compdef gcount=git
alias gcp='git cherry-pick'
compdef _git gcp=git-cherry-pick
alias glg='git log --stat --max-count=5'
compdef _git glg=git-log
alias glgg='git log --graph --max-count=5'
compdef _git glgg=git-log
alias gss='git status -s'
compdef _git gss=git-status
alias ga='git add'
compdef _git ga=git-add
alias gm='git merge'
compdef _git gm=git-merge
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias gsi='git submodule init'
compdef _git gsi=git-submodule
alias gsu='git submodule update'
compdef _git gsu=git-submodule

# Git and SVN mix
alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'
compdef git-svn-dcommit-push=git
alias gsr='git svn rebase'
alias gsd='git svn dcommit'

#
# Will return the current branch name
# Usage example: git pull origin $(current_branch)
#
function current_branch() { git_current_branch }

function current_repository() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo $(git remote -v | cut -d':' -f 2)
}

# these aliases take advantage of the previous function
alias ggpull='git pull origin $(git_current_branch)'
compdef ggpull=git
alias ggpush='git push origin $(git_current_branch)'
compdef ggpush=git
alias ggpnp='git pull origin $(git_current_branch) && git push origin $(git_current_branch)'
compdef ggpnp=git

#
# Help
#
function git-help() {
  echo "Git Custom Aliases Usage"
  echo
  echo "  g       = git"
  echo "  get     = git"
  echo "  gcl     = git clone"
  echo "  ga      = git add"
  echo "  gall    = git add ."
  echo "  gst/gs  = git status"
  echo "  gss     = git status -s"
  echo "  gl      = git pull"
  echo "  ggpull  = git pull origin \"$(git_current_branch)\""
  echo "  gp      = git push"
  echo "  gpo     = git push origin"
  echo "  ggpush  = git push origin \"$(git_current_branch)\""
  echo "  ggpnp   = git pull origin \"$(git_current_branch)\" && git push origin \"$(git_current_branch)\""
  echo "  gd      = git diff"
  echo "  gdv     = git diff -w \"$@\" | vim -R -"
  echo "  gup     = git fetch && git rebase"
  echo "  gc      = git commit -v"
  echo "  gca     = git commit -v -a"
  echo "  gci     = git commit --interactive"
  echo "  grh     = git reset HEAD"
  echo "  grhh    = git reset HEAD --hard"
  echo "  gb      = git branch"
  echo "  gba     = git branch -a"
  echo "  gdel    = git branch -D"
  echo "  gsi     = git submodule init"
  echo "  gsu     = git submodule update"
  echo "  gcount  = git shortlog -sn"
  echo "  gcp     = git cherry-pick"
  echo "  gco     = git checkout"
  echo "  gcm     = git checkout master"
  echo "  gexport = git git archive --format zip --output"
  echo "  gmu     = git fetch origin -v; git fetch upstream -v; git merge upstream/master"
  echo "  gll     = git log --graph --pretty=oneline --abbrev-commit"
  echo
}
