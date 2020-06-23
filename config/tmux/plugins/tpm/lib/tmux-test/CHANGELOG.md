# Changelog

### master
- move `setup` task to `.travis.yml` for travis tests
- "merge" travis.yml and travis_for_plugins.yml files (no need to keep em
  separate)
- add more useful helper functions
- remove tmux-test repo as a submodule from self, this causes issues with
  `$ git submodule update --recursive --init` command that some users use for
  managing other plugins
- add new helper `teardown_helper`
- add `run_tests` helper
- change CLI syntax for choosing vagrant machine to run the tests on
- enable running just a single test via `run_tests` cli interface
- add `--keep-running` cli option to continue running vagrant after the tests
  are done executing
- start using tmux 2.0 for tests

### v0.2.0, 2015-02-22
- `setup` script gitignores `tests/helpers.sh`
- move `tests/helpers.sh` to `tests/helpers/helpers.sh`
- `setup` undo removes added lines from gitignore file

### v0.1.0, 2015-02-22
- changes so that 'tmux-test' can be included with tmux plugins
- do not gitignore submodules directory
- add installation and usage instructions
- copy `.travis.yml` to the project root when running `setup` script
- add a brief mention of travis CI to the readme
- add test helpers
- `setup` script symlinks helpers file to `tests/` directory
- `setup` script can undo most of its actions
- add a tmux scripting test
- `tmux-test` uses `tmux-test` to test itself
- update `tmux-test` submodule
- a different `travis.yml` for `tmux-test` and for plugins

### v0.0.1, 2015-02-21
- git init
- add vagrant provisioning scripts for ubuntu and debian
- add a ".travis.yml" file
- generic "run_tests" script
- "run_tests_in_isolation" script
- add "Vagrantfile"
- enable passing VM names as arguments to "run_tests" script
