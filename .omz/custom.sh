source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

##
## Color listing
##
eval $(gdircolors $DOTFILES/.dir_colors)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
