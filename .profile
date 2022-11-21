# For consistancy betwixt tmux et terminal emulator
if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi

# MAC: xcrun --show-sdk-path
[ -d "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk" ] && SDKROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"

[ -d "$SDKROOT/usr/include" ] && CPATH="$SDKROOT/usr/include"

[ -d "/opt/homebrew/bin" ] && PATH="/opt/homebrew/bin":$PATH

[ -d "/opt/homebrew/opt/llvm" ] && PATH="/opt/homebrew/opt/llvm/bin":$PATH

[ -d "/Applications/Julia-1.8.app/Contents/Resources/julia" ] && PATH="/Applications/Julia-1.8.app/Contents/Resources/julia/bin/":$PATH

# MacPorts
[ -d "/opt/local/bin" ] && PATH="/opt/local/bin:/opt/local/sbin:$PATH"

[ -d "/Users/than/Library/Python/3.9/bin" ] && PATH=$PATH:"/Users/than/Library/Python/3.9/bin"

# Scripts
[ -d "/Users/than/Development/Scripts" ] && PATH="/Users/than/Development/Scripts":$PATH

# Agnostic

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

[ -d "$HOME/go" ] && GOPATH="$HOME/go" && PATH=$PATH:"$GOPATH/bin"
