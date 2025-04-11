# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias ll='ls -alF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias c='clear'
alias gs='git status'
alias gp='git pull'
alias gc='git commit -m'

# Functions
# Quick navigation to parent directories
up() {
    local d=""
    limit=${1:-1}
    for ((i=1; i<=limit; i++)); do
        d="../$d"
    done
    cd "$d" || return
}

# Extract various compressed file types
extract() {
    if [[ -f $1 ]]; then
        case $1 in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz)  tar xzf "$1" ;;
            *.bz2)     bunzip2 "$1" ;;
            *.rar)     unrar x "$1" ;;
            *.gz)      gunzip "$1" ;;
            *.tar)     tar xf "$1" ;;
            *.tbz2)    tar xjf "$1" ;;
            *.tgz)     tar xzf "$1" ;;
            *.zip)     unzip "$1" ;;
            *.Z)       uncompress "$1" ;;
            *.7z)      7z x "$1" ;;
            *)         echo "Unknown file format: $1" ;;
        esac
    else
        echo "'$1' is not a valid file."
    fi
}

# Prompt
# Show username, hostname, current directory, and Git branch if inside a repository
# Function to show the current Git branch and status
parse_git_branch() {
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
        status=$(git status --porcelain 2>/dev/null)
        if [ -z "$status" ]; then
            echo -e "\033[32m[$branch]"  # Clean branch (green)
        else
            echo -e "\033[33m[$branch*]" # Dirty branch (yellow)
        fi
    fi
}

# Function to show an exit code symbol if the last command failed
exit_status_symbol() {
    if [ $? -ne 0 ]; then
        echo -e "\033[31m✗"  # Red cross for failed commands
    fi
}

# Set the PS1 variable for a nice prompt
export PS1="\[$(tput setaf 243)\]\u\[$(tput setaf 245)\]@\[$(tput setaf 249)\]\h \[$(tput setaf 254)\]\w \$(exit_status_symbol) \$(parse_git_branch)\n\[$(tput sgr0)\]$ "

# Enable Bash Completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
elif [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

# History Settings
shopt -s histappend         # Append to history file, don't overwrite it
export PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

# Colored Man Pages
export LESS_TERMCAP_mb=$'\e[1;31m'       # Start blink
export LESS_TERMCAP_md=$'\e[1;32m'       # Start bold
export LESS_TERMCAP_me=$'\e[0m'          # End mode
export LESS_TERMCAP_se=$'\e[0m'          # End standout-mode
export LESS_TERMCAP_so=$'\e[1;44;33m'    # Start standout-mode
export LESS_TERMCAP_ue=$'\e[0m'          # End underline
export LESS_TERMCAP_us=$'\e[1;4;31m'     # Start underline
