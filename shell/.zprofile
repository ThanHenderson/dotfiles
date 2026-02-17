# Avoid duplicates in PATH
typeset -U PATH path

case "$(uname -s)" in
	Darwin)
		# xcrun --show-sdk-path
		if [ -d "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk" ]; then
			export SDKROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"
		fi

		[ -d "$SDKROOT/usr/include" ] && export CPATH="$SDKROOT/usr/include"
		[ -d "/opt/homebrew/bin" ] && path=("/opt/homebrew/bin" $path)
		;;
esac

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

[ -d "$HOME/go" ] && export GOPATH="$HOME/go" && path=("$GOPATH/bin" $path)

[ -d "$HOME/.emacs.d/bin" ] && path=("$HOME/.emacs.d/bin" $path)

[ -f ~/.profile ] && source ~/.profile
