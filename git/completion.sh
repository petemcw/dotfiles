# Uses git's autocompletion for inner commands. Assumes an install of git's
# bash `git-completion` script at $completion below (this is where Homebrew
# tosses it, at least).
COMPLETION=/etc/bash_completion.d/git

if [ -f $COMPLETION ]
then
    source $COMPLETION
fi
