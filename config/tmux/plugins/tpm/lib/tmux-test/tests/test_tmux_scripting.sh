#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $CURRENT_DIR/helpers/helpers.sh

number_of_windows() {
	tmux list-windows |
		wc -l |
		sed "s/ //g"
}

main() {
	# start tmux in the background
	tmux new -d
	tmux new-window

	local number_of_windows="$(number_of_windows)"
	if ! [ "$number_of_windows" -eq 2 ]; then
		fail_helper "Incorrect number of windows. Expected 2, got $number_of_windows"
	fi
	exit_helper
}
main
