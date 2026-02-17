export EDITOR=vim
export VISUAL="$EDITOR"
export HISTSIZE=10000
export HISTFILESIZE=20000

prepend_path_if_dir() {
    dir="$1"
    [ -d "$dir" ] || return 0
    case ":$PATH:" in
        *":$dir:"*) ;;
        *) PATH="$dir:$PATH" ;;
    esac
}

prepend_path_if_dir "$HOME/bin"
prepend_path_if_dir "$HOME/scripts"
prepend_path_if_dir "$HOME/.local/bin"
prepend_path_if_dir "$HOME/.pixi/bin"
prepend_path_if_dir "$HOME/.pixi/envs/acme/bin"

case "$(uname -s)" in
    Darwin)
        prepend_path_if_dir "/Library/TeX/texbin"
        ;;
esac

if [ -d "$HOME/.config/helix/runtime" ]; then
    export HELIX_RUNTIME="$HOME/.config/helix/runtime"
fi

export PATH
