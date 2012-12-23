export EDITOR="vim"

##
## Manpages
##
## https://github.com/sharad/rc/blob/master/LESS_TERMCAP
export MANPAGER="less -FRX"
export LESS_TERMCAP_mb=$'\E[01;31m'      # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m'      # begin bold
export LESS_TERMCAP_me=$'\E[0m'          # end mode
export LESS_TERMCAP_se=$'\E[0m'          # end standout-mode
export LESS_TERMCAP_so=$'\E[01;44;33m'   # begin standout-mode
export LESS_TERMCAP_ue=$'\E[0m'          # end underline
export LESS_TERMCAP_us=$'\E[01;32m'      # begin underline
export LESS_TERMCAP_mb=$'\E[01;31m'      # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m' # bold in blue
export LESS_TERMCAP_me=$'\E[0m'          # end mode
export LESS_TERMCAP_se=$'\E[0m'          # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'   # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'          # end underline
export LESS_TERMCAP_us=$'\E[04;33;146m'  # begin underline is now yellow

##
## ZSH Theme Configuration
##
LEFT_PROMPT=(status context dir php sf2 vagrant git); export LEFT_PROMPT
RIGHT_PROMPT=(date battery); export RIGHT_PROMPT
ZSH_THEME="jubianchi"

##
## Oh my ZSH Configuration
##
ZSH=$HOME/.oh-my-zsh
CASE_SENSITIVE="true"
plugins=(battery osx brew sublime symfony2)
source $ZSH/oh-my-zsh.sh

##
## Customs
##
export PATH="$HOME/pear/bin:$PATH"
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

##
## Resty : https://github.com/micha/resty
##
[ $(command -v resty >/dev/null 2>&1) ] && source resty -W

##
## Hub : https://github.com/defunkt/hub
##
[ $(command -v hub >/dev/null 2>&1) ] && eval "$(hub alias -s)"

##
## Aliases
##
alias g=git
alias ll="ls -lThaeFG"
alias tree="tree -lhF"
alias which="command -v $1"
alias zshconfig="$EDITOR ~/.zshrc"

##
## Keys
##
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward
