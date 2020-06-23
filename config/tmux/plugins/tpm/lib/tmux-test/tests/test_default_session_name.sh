#/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# bash helpers provided by 'tmux-test'
source $CURRENT_DIR/helpers/helpers.sh

# installs plugin from current repo in Vagrant (or on Travis)
install_tmux_plugin_under_test_helper

# start tmux in background (plugin under test is sourced)
tmux new -d

# get first session name
session_name="$(tmux list-sessions -F "#{session_name}")"

# fail the test if first session name is not "0"
if ! [ "$session_name" == "0" ]; then
	# fail_helper is also provided by 'tmux-test'
	fail_helper "First session name is not '0' by default"
fi

# sets the right script exit code ('tmux-test' helper)
exit_helper
