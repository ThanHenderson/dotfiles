# MAC: xcrun --show-sdk-path

[ -d "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk" ] && SDKROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"

# because apple
[ -d "$SDKROOT/usr/include" ] && CPATH="$SDKROOT/usr/include"

[ -d "/opt/homebrew/bin" ] && PATH="/opt/homebrew/bin":$PATH

[ -d "/opt/homebrew/opt/llvm" ] && PATH=$PATH:"/opt/homebrew/opt/llvm/bin"

# MacPorts
[ -d "/opt/local/bin" ] && PATH="/opt/local/bin:/opt/local/sbin:$PATH"

[ -d "/Users/than/Library/Python/3.9/bin" ] && PATH=$PATH:"/Users/than/Library/Python/3.9/bin"


# Agnostic

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

[ -d "$HOME/go" ] && GOPATH="$HOME/go" && PATH=$PATH:"$GOPATH/bin"

alias vi="/opt/homebrew/bin/vim"
alias vim="nvim"
