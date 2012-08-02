# Paste with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# Completion colors
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
