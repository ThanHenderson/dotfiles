# Avoid duplicates in PATH
typeset -U PATH path

if [[ "$(uname)" = "Darwin" ]]; then
	# xcrun --show-sdk-path
	[ -d "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk" ] && SDKROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"

	[ -d "$SDKROOT/usr/include" ] && CPATH="$SDKROOT/usr/include"

	[ -d "/opt/homebrew/bin" ] && path=("/opt/homebrew/bin" $path)
elif [[ "$(expr substr $(uname -s) 1 5)" = "Linux" ]]; then

fi

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

[ -d "$HOME/go" ] && GOPATH="$HOME/go" && path=("$GOPATH/bin" $path)

[ -d "$HOME/.emacs.d/bin" ] && path=("$HOME/.emacs.d/bin" $path)

[ -f ~/.profile ] && source ~/.profile
export PATH="$HOME/.pixi/bin:$PATH"
export PATH="$HOME/.pixi/envs/acme/bin:$PATH"
