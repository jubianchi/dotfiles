# vim:ft=zsh ts=2 sw=2 sts=2

[ -z "$SEGMENT_SEPARATOR" ] && SEGMENT_SEPARATOR='⮀'
[ -z "$RSEGMENT_SEPARATOR" ] && RSEGMENT_SEPARATOR='⮂'
[ -z "$GIT_DIRTY_SYMBOL" ] && GIT_DIRTY_SYMBOL='±'
[ -z "$STATUS_SUCCESS_SYMBOL" ] && STATUS_SUCCESS_SYMBOL='✔'
[ -z "$STATUS_ERROR_SYMBOL" ] && STATUS_ERROR_SYMBOL='✘'
[ -z "$STATUS_ROOT_SYMBOL" ] && STATUS_ROOT_SYMBOL='⚡'
[ -z "$STATUS_BACKGROUND_SYMBOL" ] && STATUS_BACKGROUND_SYMBOL='⚙'
[ -z "$BATTERY_CHARGING_SYMBOL" ] && BATTERY_CHARGING_SYMBOL='⚡'
[ -z "$VAGRANT_SYMBOL" ] && VAGRANT_SYMBOL='ⱱ'
[ -z "$VERSION_PATT" ] && VERSION_PATT='%s'
[ -z "$GIT_DEFAULT_REMOTE" ] && GIT_DEFAULT_REMOTE='origin'
[ -z "$GIT_DEFAULT_BRANCH" ] && GIT_DEFAULT_BRANCH='master'
[ -z "$DATE_FORMAT" ] && DATE_FORMAT="%w %D{%b %Y} %D{%H:%M:%S}"
[ -z "$DEFAULT_USERNAME" ] && DEFAULT_USERNAME=$(whoami)

[ -z "$LEFT_PROMPT" ] && LEFT_PROMPT=(status context dir)
[ -z "$RIGHT_PROMPT" ] && RIGHT_PROMPT=(date)
[ -z "$DISABLE_RIGHT_PROMPT" ] && DISABLE_RIGHT_PROMPT='false'

CURRENT_BG='NONE'
CURRENT_RBG='NONE'

prompt_segment() {
  local bg fg sep

  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  sep=${4:-$SEGMENT_SEPARATOR}

  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$sep%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi

  CURRENT_BG=$1

  [[ -n $3 ]] && echo -n $3
}

prompt_rsegment() {
  local bg fg sep

  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  sep=${4:-$RSEGMENT_SEPARATOR}

  if [[ $CURRENT_RBG == 'NONE' ]]
  then
    echo -n "%{%F{$1}%}$sep%{$fg$bg%} "
  else
    echo -n "$RSEGMENT_SEPARATOR"
  fi

  CURRENT_BG=$1

  [[ -n $3 ]] && echo -n "$3 "
}

prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

prompt_context() {
  local bg=green
  local user=$DEFAULT_USERNAME

  [[ $RETVAL -ne 0 ]] && bg=red

  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    $1 $bg 254 "$user"
  fi
}

## Standard prompt informations
prompt_dir() {
  $1 33 254 '%~'
}

prompt_status() {
  local bg=green
  local symbols

  [[ $RETVAL -ne 0 ]] && bg=red

  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="$STATUS_ERROR_SYMBOL"
  [[ $RETVAL -eq 0 ]] && symbols+="$STATUS_SUCCESS_SYMBOL"
  [[ $UID -eq 0 ]] && symbols+="$STATUS_ROOT_SYMBOL"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="$STATUS_BACKGROUND_SYMBOL"

  [[ -n "$symbols" ]] && $1 $bg 254 "$symbols ⮁"
}
##

## Git prompt informations
prompt_git() {
  local ref dirty hash symbol remote rbranch ahead behind

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1)
  then
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
    if [[ -n $dirty ]]; then
      $1 yellow black
    else
      $1 green black
    fi

    hash=`git log -n1 --pretty="%h"`

    branch="${ref/refs\/heads\//}"

    remote=$(git config branch.$branch.remote)
    [ -z $remote ] && remote=$GIT_DEFAULT_REMOTE

    rbranch=$(git config branch.$branch.merge)
    rbranch="${rbranch/refs\/heads\//}"
    [ -z $rbranch ] && rbranch=$GIT_DEFAULT_BRANCH

    if [ $(git branch -r | grep -E "^\s*$remote/$branch$") ]
    then
      ahead=$(git log --pretty=oneline $remote/$rbranch..$branch | wc -l | tr -d ' ')
      behind=$(git log --pretty=oneline $branch..$remote/$rbranch | wc -l | tr -d ' ')

      position=""
      if [ $ahead -gt 0 -o $behind -gt 0 ]
      then
        position="("
        [ $ahead -gt 0 ] && position="$position↑$ahead"
        [ $behind -gt 0 ] && position="$position↓$behind"
        position="$position)"
      fi
    fi

    symbol='⭠'
    [[ -n $dirty ]] && symbol=$GIT_DIRTY_SYMBOL

    echo -n "$symbol $branch$position@$hash"
  fi
}
##

prompt_php() {
  local version

  if [ -n "$(command -v php)" ]
  then
    version=`php -ddisplay_errors=stderr -v 2> /dev/null | head -n1 | grep -Poie '\d(?:\.\d+)+'`

    $1 33 254 "php $(printf $VERSION_PATT $version)"
  fi
}

prompt_java() {
  local version

  if [ -n "$(command -v java)" ]
  then
    version=$(java -version 2>&1 | head -n1 | grep -Poie '(?:\d+(?:\.|_)?)+')

    $1 254 160 "java $(printf $VERSION_PATT $version)"
  fi
}

prompt_nodejs() {
  local version

  if [ -n "$(command -v node)" ]
  then
    version=`node -v 2> /dev/null | head -n1 | grep -Poie '(?:\d+\.?)+'`

    $1 64 254 "nodejs $(printf $VERSION_PATT $version)"
  fi
}

prompt_ruby() {
  local version

  if [ -n "$(command -v ruby)" ]
  then
    version=`ruby -v 2> /dev/null | head -n1 | grep -Poie '(ruby [^\s]+)'`

    $1 160 254 "$version"
  fi
}

prompt_vagrant() {
  local bg vagrant dir

  dir=.
  while [ -d $dir -a ! -f $dir/Vagrantfile ]
  do
    dir=$dir/..
  done

  vagrant=""
  [ -f $dir/Vagrantfile ] && vagrant="$VAGRANT_SYMBOL"

  bg=red
  if [ -d $dir/.vagrant ]
  then
    result=$(cd $dir; vagrant status | grep -o running)
    if [ ! -z "$result" ]
    then
      bg=green

      [ $(echo $result | wc -l) -gt 1 ] && vagrant="$vagrant *"
    else
      bg=yellow
    fi
  fi

  [ ! -z "$vagrant" ] && $1 black $bg $vagrant
}

prompt_sf2() {
  local sf

  if [ -e app/console ]
  then
    $1 cyan 254 "SF2"
  fi
}

prompt_battery() {
  local total remain pct bg charging

  if [[ $(uname) == "Darwin" ]] ; then
    total=$(ioreg -l | grep Capacity | grep -P '"MaxCapacity" = \d+' | grep -P '[0-9]+' -o)
    remain=$(ioreg -l | grep Capacity | grep -P '"CurrentCapacity" = \d+' | grep -P '[0-9]+' -o)

    pct=$(php -r"echo round(${remain}/${total}*100);")

    if [ $(ioreg -rc AppleSmartBattery | grep -c '^.*"ExternalConnected"\ =\ No') -eq 0 ]
    then
      charging=" $BATTERY_CHARGING_SYMBOL"
    fi

    bg='green'
    [[ $pct -lt 40 ]] && bg='yellow'
    [[ $pct -lt 20 ]] && bg='red'
    pct="$(printf '%.0f%%%%' $pct)$charging"
  else
    bg='red'
    pct="n/a"
  fi

  $1 $bg black $pct
}

prompt_date() {
  $1 243 254 $DATE_FORMAT
}

prompt_screen() {
  local list detached attached dead

  list=$(screen -ls)

  attached=0
  [ $(echo $list | wc -l) -gt 2 ] && attached=$(echo $list | tail -n +2 | head -n -2 | grep Attached | wc -l)

  detached=0
  [ $(echo $list | wc -l) -gt 2 ] && detached=$(echo $list | tail -n +2 | head -n -2 | grep Detached | wc -l)

  dead=0
  [ $(echo $list | wc -l) -gt 2 ] && dead=$(echo $list | tail -n +2 | head -n -2 | grep Dead | wc -l)

  if [ $dead -gt 0 ]
  then
    prompt_rsegment red black "Screen A$attached/D$detached/W$dead"
  else
    prompt_rsegment yellow black "Screen A$attached/D$detached"
  fi
}

prompt_load() {
  local load cpus

  load=$(sysctl -n vm.loadavg | cut -d' ' -f3 | sed s/,/./ | sed 's/.\{1\}$//')
  cpus=$(sysctl hw.ncpu | cut -d' ' -f2)

  if [ "$(echo "$load>(0.70*$cpus)" | bc)" -eq "1" ]
  then
    $1 red white $load
  else
    $1 green white $load
  fi
}

build_prompt() {
  RETVAL=$?

  foreach plugin ($LEFT_PROMPT) prompt_$plugin 'prompt_segment'; end;

  prompt_end
}

build_cmd_prompt() {
  CURRENT_BG='NONE'
  prompt_segment black default "$ %{%k%F{black}%}$SEGMENT_SEPARATOR"
}

build_rprompt() {
  foreach plugin ($RIGHT_PROMPT) prompt_$plugin 'prompt_rsegment'; end;
}

PROMPT='%{%f%b%k%}$(build_prompt)
$(build_cmd_prompt)%{%f%k%b%} '

if [ $DISABLE_RIGHT_PROMPT = 'false' ]
then
  RPROMPT='%{%f%b%k%}$(build_rprompt)'
else
  RPROMPT=''
fi
