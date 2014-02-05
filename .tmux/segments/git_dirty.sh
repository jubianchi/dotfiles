source "${TMUX_POWERLINE_DIR_LIB}/tmux_adapter.sh"

run_segment() {
	local color symbol

	cd $(get_tmux_cwd)

	if [ $(git rev-parse --is-inside-work-tree) != 'true' ]
	then
		return
	fi		

	if [ $(__parse_git_dirty) = 'true' ]
	then		
		color="#[fg=colour160]"
		symbol="✘"
	else		
		color="#[fg=colour64]"
		symbol="✔"
	fi	

	echo "${color}${symbol}"

	return 0
}

__parse_git_dirty() {	
	local GIT_STATUS=$(command git status -s --ignore-submodules=dirty -uno 2> /dev/null | tail -n1)	

	if [ -n "$GIT_STATUS" ]
	then
		echo 'true'
	else
		echo 'false'
	fi
}
