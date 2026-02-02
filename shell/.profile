export EDITOR=vim
export VISUAL=$EDITOR
export HISTSIZE=10000
export HISTFILESIZE=20000
export PATH="$HOME/bin:$PATH"

if [ -d "$HOME/scripts" ]; then
    export PATH="$HOME/scripts:$PATH"
fi
export PATH="/Library/TeX/texbin:$PATH"
export HELIX_RUNTIME="$HOME/.config/helix/runtime"

export PATH="$HOME/.local/bin:$PATH"
