
# ~/.zshrc: executed by zsh for interactive shells.

# If not running interactively, don't do anything
[[ -o interactive ]] || return

# ------------------------------
# History Configuration
# ------------------------------
HISTSIZE=1000
SAVEHIST=2000
HISTFILE=~/.zsh_history

# Avoid duplicate entries and ignore commands starting with a space
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS

# Append to the history file, don't overwrite it
setopt APPEND_HISTORY

# ------------------------------
# Window Size Check
# ------------------------------
# zsh automatically checks window size, but to ensure:

# ------------------------------
# Chroot Identification
# ------------------------------
if [[ -z "${debian_chroot}" && -r /etc/debian_chroot ]]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# ------------------------------
# Prompt Configuration
# ------------------------------
autoload -U colors && colors

# Enable color support for ls and add aliases
if command -v dircolors >/dev/null 2>&1; then
    if [[ -r ~/.dircolors ]]; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
    alias ls='ls --color=auto'
    # alias dir='dir --color=auto'
    # alias vdir='vdir --color=auto'
    
    # Uncomment the following if you use grep with color
    # alias grep='grep --color=auto'
    # alias fgrep='fgrep --color=auto'
    # alias egrep='egrep --color=auto'
fi

# Set a fancy prompt (using Oh My Posh)
eval "$(oh-my-posh init zsh)"

# If you prefer a custom prompt without Oh My Posh, you can use the following:
# if [[ -n "$force_color_prompt" ]]; then
#     if [[ $(tput setaf 1) ]]; then
#         color_prompt=yes
#     else
#         color_prompt=
#     fi
# fi

# if [[ "$color_prompt" = yes ]]; then
#     PROMPT='${debian_chroot:+($debian_chroot)}%F{green}%n@%m%f:%F{blue}%~%f\$ '
# else
#     PROMPT='${debian_chroot:+($debian_chroot)}%n@%m:%~\$ '
# fi
# unset color_prompt force_color_prompt

# Set terminal title for xterm-compatible terminals
case "$TERM" in
    xterm*|rxvt*)
        precmd() { print -Pn "\e]0;%n@%m: %~\a" }
        ;;
    *)
        ;;
esac

# ------------------------------
# Aliases
# ------------------------------
alias ls="lsd"
alias cat="bat"

# ------------------------------
# Load External Alias File
# ------------------------------
if [[ -f ~/.zsh_aliases ]]; then
    source ~/.zsh_aliases
fi

# ------------------------------
# Programmable Completion
# ------------------------------
autoload -Uz compinit
compinit

# ------------------------------
# Homebrew Environment
# ------------------------------
if type brew &>/dev/null; then
    # eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# ------------------------------
# Oh My Posh Initialization
# ------------------------------
# Already initialized above. If additional setup is needed, add here.

# ------------------------------
# Environment Variables
# ------------------------------
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export WASMTIME_HOME="$HOME/.wasmtime"
export PATH="$WASMTIME_HOME/bin:$PATH"

# Uncomment if using .NET tools
# export PATH="$HOME/.dotnet/tools:$PATH"

export PATH="$PATH:$HOME/dotnet"

# Uncomment if needed
# export PATH="/home/linuxbrew/.linuxbrew/bin/dotnet"
#
export PATH="$PATH:$HOME/.config/emacs/bin"


export DOTNET_ROOT=/usr/bin/dotnet

export VCPKG_ROOT=/home/linuxbrew/.linuxbrew/bin/
export PATH="$VCPKG_ROOT:$PATH"

export PATH="$PATH:/home/marul/.foundry/bin"
export PATH="$PATH:$HOME/.cargo/bin"

# Load Rust environment
if [[ -f "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
fi

# Initialize zoxide for directory navigation
eval "$(zoxide init --cmd cd zsh)"
alias icat="kitten icat"
export LIBRARY_PATH=$LIBRARY_PATH:$(brew --prefix)/lib:$(brew --prefix)/opt/libiconv/lib
export PATH="/opt/homebrew/opt/libiconv/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/libiconv/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libiconv/include"


export PATH="$PATH:/Users/ataberkcekic/.risc0/bin"
export PATH="/opt/homebrew/opt/dotnet@6/bin:$PATH"
export PATH="/opt/homebrew/opt/dotnet@6/bin:$PATH"
export PATH="/opt/homebrew/opt/dotnet@8/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
