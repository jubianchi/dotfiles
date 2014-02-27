run_segment() {
	if shell_is_osx; then
		battery_status=$(__battery_osx_high)	
	fi

	[ -z "$battery_status" ] && return

	output="${battery_status}%"			

	if [ -n "$output" ]; then
		echo "$output"
	fi
}

__battery_osx_high() {
	ioreg -c AppleSmartBattery -w0 | \
		grep -o '"[^"]*" = [^ ]*' | \
		sed -e 's/= //g' -e 's/"//g' | \
		sort | \
		while read key value; do
			case $key in
				"MaxCapacity")
					export maxcap=$value
					;;
				"CurrentCapacity")
					export curcap=$value
					;;
				"ExternalConnected")
					export extconnect=$value
					;;
        		"FullyCharged")
          			export fully_charged=$value
          			;;
			esac
			
			if [[ -n $maxcap && -n $curcap && -n $extconnect ]]; then							
				charge=$(( 100 * $curcap / $maxcap ))

				[[ $charge -lt 70 ]] && return

				if [[ "$extconnect" == "Yes" ]]; then
					echo -n "⚡ "
				fi

				echo "$charge"			
				
				break
			fi
		done
	}
