# A multi-line, Powerline-inspired theme for ZSH
#   - Based on agnoster's Theme

# Settings
LC_ALL=""
LC_CTYPE="en_US.UTF-8"
CURRENT_BG="NONE"
DOUBLEUP_TIME_FORMAT=${DOUBLEUP_TIME_FORMAT:-"%D{%H:%M:%S}"}
DOUBLEUP_VCS_INTERNAL_HASH_LENGTH=${DOUBLEUP_VCS_INTERNAL_HASH_LENGTH:-8}
DOUBLEUP_VCS_HIDE_TAGS=${DOUBLEUP_VCS_HIDE_TAGS:-true}
DOUBLEUP_VCS_SHOW_CHANGESET=${DOUBLEUP_VCS_SHOW_CHANGESET:-false}
DOUBLEUP_VERBOSE_BG_JOBS=${DOUBLEUP_VERBOSE_BG_JOBS:-true}
DOUBLEUP_VERBOSE_STATUS=${DOUBLEUP_VERBOSE_STATUS:-false}

# Special Powerline characters
# NOTE: The icons are defined using Unicode escape sequences so it is
# unambiguously readable, regardless of what font the user is viewing this
# source code in. Do not replace the escape sequence with a single literal
# character.
SEGMENT_SEPARATOR=$'\ue0b0'         # 
ICON_BG_JOBS=$'\u2699'              # ⚙
ICON_ROOT=$'\u26A1'                 # ⚡
ICON_USER='›'                       # $'\u009b'
ICON_OK=$'\u2713'                   # ✓
ICON_FAIL=$'\u2718'                 # ✘
ICON_VCS_UNTRACKED='?'
ICON_VCS_UNSTAGED=$'\u25CF'         # ●
ICON_VCS_STAGED=$'\u271A'           # ✚
ICON_VCS_STASH=$'\u235F'            # ⍟
ICON_VCS_INCOMING_CHANGES=$'\u2193' # ↓
ICON_VCS_OUTGOING_CHANGES=$'\u2191' # ↑
ICON_VCS_BRANCH=$'\uE0A0'           # 
ICON_VCS_DETACHED_BRANCH=$'\u27A6'  # ➦
ICON_VCS_REMOTE_BRANCH=$'\u2192'    # →
ICON_VCS_TAG=''

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ "$CURRENT_BG" != 'NONE' && $1 != "$CURRENT_BG" ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n "$3"
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Caret: change prompt character based on UID
prompt_caret() {
  if [[ $UID -eq 0 ]]; then
    prompt_segment black default "%{%F{yellow}%}$ICON_ROOT"
  else
    prompt_segment black default "%{%F{white}%}$ICON_USER"
  fi
}

# Context: user on hostname (who am I and where am I)
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%{%F{magenta}%}$USER %{%F{white}%}on %{%F{yellow}%}%m"
  fi
}

# Dir: current working directory
prompt_dir() {
  prompt_segment blue black '%~'
}

# Status: was there an error on previous command
prompt_status() {
  if [[ "$RETVAL" -ne 0 ]]; then
    local return_value=""
    if [[ "$DOUBLEUP_VERBOSE_STATUS" == true ]]; then
      return_value="$RETVAL "
    fi
    prompt_segment black default "%{%F{red}%}$return_value$ICON_FAIL"
  fi
}

# Jobs: are there background jobs?
prompt_background_jobs() {
  local jobs_number=${$(jobs -l | wc -l)// /}
  if [[ jobs_number -gt 0 ]]; then
    local jobs_number_print=""
    if [[ "$DOUBLEUP_VERBOSE_BG_JOBS" == "true" ]] && [[ jobs_number -gt 1 ]]; then
      jobs_number_print="$jobs_number "
    fi
    prompt_segment black default "%{%F{cyan}%}$jobs_number_print$ICON_BG_JOBS"
  fi
}

# Time: render system time
prompt_time() {
  local time_format="%D{%H:%M:%S}"
  if [[ -n "$DOUBLEUP_TIME_FORMAT" ]]; then
    time_format="$DOUBLEUP_TIME_FORMAT"
  fi
  prompt_segment black yellow "$time_format"
}

# Git: status information for repository
prompt_vcs() {
  # if no git, do not run
  (( $+commands[git] )) || return

  typeset -gAH vcs_states
  vcs_states=(
    'clean'     'green'
    'modified'  'yellow'
    'untracked' 'green'
  )

  # used by hooks to render dirty colors
  current_state=""
  VCS_WORKDIR_DIRTY=false
  VCS_WORKDIR_HALF_DIRTY=false
  VCS_CHANGESET_PREFIX=''
  if [[ "$DOUBLEUP_VCS_SHOW_CHANGESET" == true ]]; then
    VCS_CHANGESET_PREFIX="%0.$DOUBLEUP_VCS_INTERNAL_HASH_LENGTH""i "
  fi

  autoload -Uz vcs_info
  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes true
  zstyle ':vcs_info:*' formats "$VCS_CHANGESET_PREFIX%b%c%u%m"
  zstyle ':vcs_info:*' actionformats "%{%F{white}%}%a%{%f%} %{%F{black}%}$ICON_VCS_DETACHED_BRANCH %m%c%u"
  zstyle ':vcs_info:*' stagedstr "$ICON_VCS_STAGED"
  zstyle ':vcs_info:*' unstagedstr "$ICON_VCS_UNSTAGED"
  zstyle ':vcs_info:*' patch-format "%$DOUBLEUP_VCS_INTERNAL_HASH_LENGTH>>%p%<< (%n applied)"
  zstyle ':vcs_info:git*+set-message:*' hooks vcs-detect-changes git-untracked git-aheadbehind git-stash git-remotebranch git-tagname

  if [[ "$DOUBLEUP_VCS_SHOW_CHANGESET" == true ]]; then
    zstyle ':vcs_info:*' get-revision true
  fi

  # Actually invoke vcs_info manually to gather all information.
  vcs_info
  local vcs_prompt="${vcs_info_msg_0_}"

  if [[ -n "$vcs_prompt" ]]; then
    if [[ "$VCS_WORKDIR_DIRTY" == true ]]; then
      current_state='modified'
    else
      if [[ "$VCS_WORKDIR_HALF_DIRTY" == true ]]; then
        current_state='untracked'
      else
        current_state='clean'
      fi
    fi
    prompt_segment "${vcs_states[$current_state]}" black "$vcs_prompt"
  fi
}

# Git: checks if changes exist
function +vi-vcs-detect-changes() {
  if [[ -n "${hook_com[staged]}" ]] || [[ -n "${hook_com[unstaged]}" ]]; then
    VCS_WORKDIR_DIRTY=true
  else
    VCS_WORKDIR_DIRTY=false
  fi
}

# Git: determine if untracked files exist
function +vi-git-untracked() {
  if [[ -n $(git ls-files --exclude-standard --others 2>/dev/null | head -n 1) ]]; then
    hook_com[unstaged]+="$ICON_VCS_UNTRACKED"
    VCS_WORKDIR_HALF_DIRTY=true
  else
    VCS_WORKDIR_HALF_DIRTY=false
  fi
}

# Git: how many changes are we ahead/behind
function +vi-git-aheadbehind() {
  local ahead behind remote
  local -a gitstatus

  remote=$(git rev-parse --verify "${hook_com[branch]}"@{upstream} \
    --symbolic-full-name --abbrev-ref 2>/dev/null)

  if [[ -n "$remote" ]]; then
    ahead=$(git rev-list "${hook_com[branch]}"@{upstream}..HEAD 2>/dev/null | wc -l)
    (( $ahead )) && gitstatus+=( "$ICON_VCS_OUTGOING_CHANGES${ahead// /}" )

    behind=$(git rev-list HEAD.."${hook_com[branch]}"@{upstream} 2>/dev/null | wc -l)
    (( $behind )) && gitstatus+=( "$ICON_VCS_INCOMING_CHANGES${behind// /}" )

    hook_com[misc]+="${(j::)gitstatus}"
  fi
}

# Git: show count of stashed changes
# Port from https://github.com/whiteinge/dotfiles/blob/5dfd08d30f7f2749cfc60bc55564c6ea239624d9/.zsh_shouse_prompt#L268
function +vi-git-stash() {
  local -a stashes
  if [[ -s $(git rev-parse --git-dir)/refs/stash ]] ; then
    stashes=$(git stash list 2>/dev/null | wc -l)
    hook_com[misc]+=" $ICON_VCS_STASH${stashes// /}"
  fi
}

# Git: show remote branch if exists
function +vi-git-remotebranch() {
  local remote branch_name

  remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
    --symbolic-full-name --abbrev-ref 2>/dev/null)}

  # set branch display
  hook_com[branch]="$ICON_VCS_BRANCH ${hook_com[branch]} "

  # if remote, add display
  if [[ -n "${remote}" ]]; then
    hook_com[branch]+="$ICON_VCS_REMOTE_BRANCH ${remote// /} "
  fi
}

# Git: add tag names if checked out
function +vi-git-tagname() {
  if [[ "$DOUBLEUP_VCS_HIDE_TAGS" == "false" ]]; then
    # If we are on a tag, append the tagname to the current branch string.
    local tag
    tag=$(git describe --tags --exact-match HEAD 2>/dev/null)

    if [[ -n "${tag}" ]] ; then
      # There is a tag that points to our current commit. Need to determine if we
      # are also on a branch, or are in a DETACHED_HEAD state.
      if [[ -z "$(git symbolic-ref HEAD 2>/dev/null)" ]]; then
        # DETACHED_HEAD state. We want to append the tag name to the commit hash
        # and print it. Unfortunately, `vcs_info` blows away the hash when a tag
        # exists, so we have to manually retrieve it and clobber the branch
        # string.
        local revision
        revision=$(git rev-list -n 1 --abbrev-commit --abbrev="$DOUBLEUP_VCS_INTERNAL_HASH_LENGTH" HEAD)
        hook_com[branch]="$ICON_VCS_DETACHED_BRANCH${revision} ($ICON_VCS_TAG${tag}) "
      else
        # on both a tag and a branch; print both by appending the tag name.
        hook_com[branch]+="($ICON_VCS_TAG${tag}) "
      fi
    fi
  fi
}

## Main prompt
setopt prompt_subst

doubleup_build_first_prompt() {
  RETVAL=$?
  prompt_status
  prompt_background_jobs
  prompt_context
  prompt_dir
  prompt_vcs
  prompt_end
}

doubleup_build_second_prompt() {
  prompt_caret
  prompt_end
}

PROMPT='
%{%f%b%k%}$(doubleup_build_first_prompt)
%{%f%b%k%}$(doubleup_build_second_prompt) '
