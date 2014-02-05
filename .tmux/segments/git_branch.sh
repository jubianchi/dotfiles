source "${TMUX_POWERLINE_DIR_LIB}/tmux_adapter.sh"

run_segment() {
	cd $(get_tmux_cwd)

	type git >/dev/null 2>&1
	[ "$?" -ne 0 ] && return	

	if [ $(git rev-parse --is-inside-work-tree) != 'true' ]
	then
		return
	fi

	git_branch=$(__parse_git_branch)
	if [ -n "$git_branch" ]
	then
		echo -n "${git_branch}"
	fi

	git_stats=$(__parse_git_stats)
	if [ -n "$git_stats" ]
	then
		echo -n " ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN} ${git_stats}"
	fi

	return 0
}

__parse_git_branch() {
	branch=$(git symbolic-ref HEAD 2> /dev/null)
	if [[ -z $branch ]] ; then
		branch=":$(git rev-parse --short HEAD 2> /dev/null)"
	fi

	[ "$?" -ne 0 ] && return	

	branch=${branch##*/}
	sha1=$(git log -n1 --pretty="%h")

	echo  -n "${branch} ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN} ${sha1}"
}

__parse_git_stats() {
	tracking_branch=$(git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD))
	set -- $(git rev-list --left-right --count $tracking_branch...HEAD)
	behind=$1
	ahead=$2

	if [[ $ahead -gt 0 ]]
	then
		ret="${ret}↑$ahead"
	fi

	if [[ $behind -gt 0 ]]
	then
		ret="${ret}↓$behind"
	fi

	echo -n "$ret"
}
