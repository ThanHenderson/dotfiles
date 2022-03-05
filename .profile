# MAC

[ -f /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk ] && SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk

[ -d "`xcrun --show-sdk-path`/usr/include" ] && CPATH="`xcrun --show-sdk-path`/usr/include"

[ -d "/opt/homebrew/bin" ] && PATH="/opt/homebrew/bin":$PATH

[ -d "/opt/homebrew/opt/llvm/bin" ] && PATH=$PATH:"/opt/homebrew/opt/llvm/bin"

# MacPorts
[ -d "/opt/local/bin" ] && PATH="/opt/local/bin:/opt/local/sbin:$PATH"


# Agnostic

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

[ -d "$HOME/go" ] && GOPATH="$HOME/go" && PATH=$PATH:"$GOPATH/bin"

alias vim="nvim"
alias vi="nvim"
