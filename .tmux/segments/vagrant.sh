run_segment() {
	cd $(get_tmux_cwd)

	[ ! -x $(which vagrant) ] && return

	output=$(__vagrant)

	if [ -n "$output" ]
	then
		echo "$output"
	else
		return 1
	fi

	return 0
}

__vagrant() {
	local now=$(date +%s)
	local poll=$(cat ~/.vagrant.d/poll | head -n1)
	local diff=$(( $now - ${poll:-0} ))

	if [[ $diff -ge 30 ]]
	then						
		status=$(vagrant status)

		if [ $? -eq 0 ]
		then
		[ ! -d .vagrant ] && mkdir .vagrant

			echo -e $status > .vagrant/status
		fi

		echo $now > ~/.vagrant.d/poll
	fi

	local status
	local running=$(__list "running")
	if [ -n "$running" ]
	then
		status="$status#[fg=colour2]$running"
	fi

	local saved=$(__list "saved")
	if [ -n "$saved" ]
	then
		[ -n "$status" ] && status="$status #[fg=colour236]$TMUX_POWERLINE_SEPARATOR_RIGHT_THIN "
		status="$status#[fg=colour9]$saved"
	fi

	if [ -z "$status" ]
	then
		local output=$(cat .vagrant/status)
		[ -n "$output" ] && status="$(cat .vagrant/status | grep -c -P "not created|aborted" | cut -d' ' -f1) VMs"
	fi

	echo -n "$status"
}

__list() {
	local sep

	vms=$(cat .vagrant/status | grep -o "\w\+\s\+$1" | cut -d' ' -f1)

	for vm in $vms
	do
		echo -n $sep$vm
		sep=', '
	done
}