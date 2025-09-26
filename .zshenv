export TERM='screen-256color'
export EDITOR='nvim'
export XDG_CONFIG_HOME="$HOME/.config"
skip_global_compinit=1

# put sensitive env vars in this file outside source control
if test -f "$HOME/.zshenv-private"; then
    source "$HOME/.zshenv-private"
fi
#. "$HOME/.cargo/env"

source $HOME/.secrets

# This makes poetry not popup a keyring gui thing, which doesnt work over ssh
export PYTHON_KEYRING_BACKEND=keyring.backends.fail.Keyring
