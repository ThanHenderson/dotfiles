# Avoid duplicates in PATH
typeset -U PATH path

# MAC: xcrun --show-sdk-path
[ -d "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk" ] && SDKROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"

[ -d "$SDKROOT/usr/include" ] && CPATH="$SDKROOT/usr/include"

[ -d "/opt/homebrew/bin" ] && path=("/opt/homebrew/bin" $path)

# MacPorts
[ -d "/opt/local/bin" ] && PATH="/opt/local/bin:/opt/local/sbin:$PATH"

[ -d "$HOME/Library/Python/3.9/bin" ] && PATH=$PATH:"$HOME/Library/Python/3.9/bin"

# Scripts
[ -d "$HOME/Development/Scripts" ] && PATH="$HOME/Development/Scripts":$PATH

# Agnostic

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

[ -d "$HOME/go" ] && GOPATH="$HOME/go" && PATH=$PATH:"$GOPATH/bin"

[ -d "$HOME/.emacs.d/bin" ] && PATH="$HOME/.emacs.d/bin":$PATH
