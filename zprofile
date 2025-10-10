# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


# bun
export BUN_INSTALL="$HOME/.bun";
export USR_LOCAL_BIN="/usr/local";
export LOCAL_BIN="$HOME/.local";
export HOME_BIN="$HOME/bin";
export LOCAL_NVIM="$HOME/bin/nvim/bin";
export GOPATH="$HOME/go";
export RUST_SRC_PATH="$HOME/.cargo/bin";
export SDKMAN_DIR="$HOME/.sdkman";
export N_PREFIX="$HOME/n";
export DOCKER="/Applications/Docker.app/Contents/Resources/bin"

export ANDROID_SDK_ROOT="$HOMEBREW_PREFIX/share/android-commandlinetools"
export ANDROID_HOME="$ANDROID_SDK_ROOT"

export PATH=$ANDROID_SDK_ROOT/bin:$PATH;
export PATH=$ANDROID_SDK_ROOT/emulator:$PATH;
export PATH=$HOMEBREW_PREFIX/bin:$PATH;
export PATH=$HOMEBREW_PREFIX/share/android-platform-tools:$PATH;

export PATH=$RUST_SRC_PATH:$PATH;
export PATH=$GOPATH/bin:$PATH;
export PATH=$BUN_INSTALL/bin:$PATH;
export PATH=$N_PREFIX/bin:$PATH;
export PATH=$USR_LOCAL_BIN/bin:$PATH;
export PATH=$LOCAL_BIN/bin:$PATH;
export PATH=$LOCAL_NVIM:$PATH;
export PATH=$SDKMAN_DIR/bin:$PATH;
export PATH=$JAVA_HOME/bin:$PATH;
export PATH=$DOCKER:$PATH;

export KEYTIMEOUT=1
export CLICOLOR=1
export EDITOR=nvim
export _Z_DATA="$HOME/z-data"
export ITERM_24BIT=1
export DISABLE_AUTO_TITLE="true"

