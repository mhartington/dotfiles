# tmux-test

[![Build Status](https://travis-ci.org/tmux-plugins/tmux-test.png?branch=master)](https://travis-ci.org/tmux-plugins/tmux-test)

A small framework for isolated testing of tmux plugins. Isolation is achieved by
running the tests in `Vagrant`. Works on [travis](travis-ci.org) too.

Extracted from [tmux plugin manager](https://github.com/tmux-plugins/tpm) and
[tmux-copycat](https://github.com/tmux-plugins/tmux-copycat).

Dependencies: `Vagrant` (no required when running on travis).

### Setup

Let's say you made tmux plugin with the following file hierarchy:

```text
/tmux-plugin
|-- plugin.tmux
`-- scripts
    `-- plugin_script.sh
```

From your project root directory (tmux-plugin/) execute the following shell
command to fetch `tmux-test` and add it as a submodule:

    $ git submodule add https://github.com/tmux-plugins/tmux-test.git lib/tmux-test

Run the `setup` script:

    $ lib/tmux-test/setup

The project directory will now look like this (additions have comments):

```text
/tmux-plugin
|-- plugin.tmux
|-- run_tests                       # symlink, gitignored
|-- .gitignore                      # 2 lines appended to gitignore
|-- .travis.yml                     # added
|-- lib/tmux-test/                  # git submodule
|-- scripts
|   `-- plugin_script.sh
`-- tests                           # dir to put the tests in
    `-- run_tests_in_isolation.sh   # symlink, gitignored
    `-- helpers
        `-- helpers.sh              # symlinked bash helpers, gitignored
```

`tmux-test` is now set up. You are ok to commit the additions to the repo.

### Writing and running tests

A test is any executable with a name starting with `test_` in `tests/`
directory.

Now that you installed `tmux-test` let's create an example test.

- create a `tests/test_example.sh` file with the following content (it's a
  `bash` script but it can be any executable):

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
        if [ "$session_name" == "0" ]; then
            # fail_helper is also provided by 'tmux-test'
            fail_helper "First session name is not '0' by default"
        fi

        # sets the right script exit code ('tmux-test' helper)
        exit_helper

- make the test file executable with `$ chmod +x tests/test_example.sh`
- run the test by executing `./run_tests` from the project root directory
- the first invocation might take some time because Vagrant's ubuntu virtual
  machine is downloading. You should see `Success, tests pass!` message when it's
  done.

Check out more example test scripts in this project's [tests/ directory](tests/).

### Continuous integration

The setup script (`lib/tmux-test/setup`) added a `.travis.yml` file to the
project root. To setup continuous integration, just add/enable the project on
[travis](travis-ci.org).

### Notes

- The `tests/` directory for tests and `lib/tmux-test/` for cloning `tmux-test`
  into cannot be changed currently
- Don't run `tests/run_tests_in_isolation` script on your local development
  environment. That's an internal test runner meant to be executed in an
  isolated environment like `vagrant` or `travis`.<br/>
  Use `./run_tests` script.
- You can use `KEEP_RUNNING=true ./run_tests` for faster test running cycle.
  If this case `Vagrant` will keep running even after the tests are done.
- You can use `VAGRANT_CWD=lib/tmux-text/ vagrant ssh ubuntu` for ssh login to
  `Vagrant`.

### Running `tmux-test` framework tests

`tmux-test` uses itself to test itself. To run framework tests:

- clone this project `$ git clone git@github.com:tmux-plugins/tmux-test.git`
- `$ cd tmux-test`
- run `$ ./run_framework_tests`

### Other goodies

- [tmux-copycat](https://github.com/tmux-plugins/tmux-copycat) - a plugin for
  regex searches in tmux and fast match selection
- [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) - automatic
  restoring and continuous saving of tmux env

You might want to follow [@brunosutic](https://twitter.com/brunosutic) on
twitter if you want to hear about new tmux plugins or feature updates.

### License

[MIT](LICENSE.md)
