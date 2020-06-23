# This file is a symlink from 'tmux-test' plugin.
# You probably don't want to edit it.


# Global variable that keeps the value of test status (success/fail).
# Suggested usage is via `fail_helper` and `exit_helper` functions.
TEST_STATUS="success"

# PRIVATE FUNCTIONS

_clone_the_plugin() {
	local plugin_path="${HOME}/.tmux/plugins/tmux-plugin-under-test/"
	rm -rf "$plugin_path"
	git clone --recursive "${CURRENT_DIR}/../" "$plugin_path" >/dev/null 2>&1
}

_add_plugin_to_tmux_conf() {
	set_tmux_conf_helper<<-HERE
	run-shell '~/.tmux/plugins/tmux-plugin-under-test/*.tmux'
	HERE
}

# PUBLIC HELPER FUNCTIONS

teardown_helper() {
	rm -f ~/.tmux.conf
	rm -rf ~/.tmux/
	tmux kill-server >/dev/null 2>&1
}

set_tmux_conf_helper() {
	> ~/.tmux.conf	# empty tmux.conf file
	while read line; do
		echo "$line" >> ~/.tmux.conf
	done
}

fail_helper() {
	local message="$1"
	echo "$message" >&2
	TEST_STATUS="fail"
}

exit_helper() {
	teardown_helper
	if [ "$TEST_STATUS" == "fail" ]; then
		echo "FAIL!"
		echo
		exit 1
	else
		echo "SUCCESS"
		echo
		exit 0
	fi
}

install_tmux_plugin_under_test_helper() {
	_clone_the_plugin
	_add_plugin_to_tmux_conf
}

run_tests() {
	# get all the functions starting with 'test_' and invoke them
	for test in $(compgen -A function | grep "^test_"); do
		"$test"
	done
	exit_helper
}
