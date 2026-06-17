# path to your oh my zsh installation
export ZSH="$ZDOTDIR/.oh-my-zsh"

# set name of the theme to load
ZSH_THEME="robbyrussell"

# some good shit
HYPHEN_INSENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# modern, optimized plugin array using secure native plugins
plugins=(
    gitfast
    archlinux
    systemd
    sudo
    colored-man-pages
    history-substring-search
    safe-paste
    zsh-interactive-cd
    wd
)

# boot the oh my zsh engine
source $ZSH/oh-my-zsh.sh

# user core definitions
export EDITOR=nvim

# modern wayland-native utilities and performance overrides
alias copy="wl-copy"
alias ls="lsd"
alias rm="trash"
alias cf='code "$(fzf)"'
alias fixdc="sudo sh ~/esp/script.sh"
alias cdleci="cd ~/leci-ua/3.2/"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'

# locks screen and blocks sleep for the duration of a specific command
locksafe() {
    if (($# == 0)); then
        # if no command is passed, just lock and stay awake indefinitely
        loginctl lock-session && systemd-inhibit --what=idle:sleep --why="working" sleep infinity
    else
        # if a command is passed, lock the session and wrap the execution safely
        loginctl lock-session
        systemd-inhibit \
            --what=sleep:idle:handle-lid-switch \
            --mode=block \
            --who="locksafe job" \
            --why="running $1" \
            "$@"
    fi
}

# generate an isolated temporary workspace directory
mktempdir() {
    local tmpdir
    tmpdir="$(mktemp -d -t tmpdir.XXXXXX)" || {
        echo "error creating temporary directory" >&2
        return 1
    }
    echo "$tmpdir"
}

# find and evaluate existing runtime temporary folders
listtemps() {
    emulate -L zsh
    setopt null_glob
    local paths=(/tmp/tmpdir.*(/) /tmp/vscode-temp.*(/))

    echo "current temporary system folders:"
    if (($#paths == 0)); then
        echo "none discovered"
        return 0
    fi
    ls -ldh --time-style=long-iso -- $paths 2>/dev/null
}

# wipe out active custom temp assets cleanly
cleartemps() {
    emulate -L zsh
    setopt null_glob
    local paths=(/tmp/tmpdir.*(/) /tmp/vscode-temp.*(/))
    if (($#paths == 0)); then
        echo "nothing to remove"
        return 0
    fi
    rm -rf -- $paths
    echo "cleared targets:"
    print -rl -- $paths
}

# pyenv environment controller setup
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# fzf search tool engine presets
export FZF_DEFAULT_COMMAND="find . -not -path '*/.*' -not -path '*/node_modules/*' -printf '%A@ %p\n' | sort -rn | cut -d' ' -f2-"
export FZF_DEFAULT_OPTS="
--style full
--tiebreak=length
--layout=reverse
--border
--preview 'if [ -d {} ]; then ls -F --color=always {}; else bat --style=numbers --color=always --line-range :500 {}; fi'"

# source official fzf integration scripts safely
source <(fzf --zsh)

# initialize atuin for robust terminal history management
eval "$(atuin init zsh)"
eval "$(direnv hook zsh)"

export ARCH_ZSH_PLUGINS="/usr/share/zsh/plugins"
# source high-performance official system packages safely using variables
if [[ -f "$ARCH_ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$ARCH_ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

if [[ -f "$ARCH_ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "$ARCH_ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# global hook to automatically switch python virtual environments on directory navigation
auto_activate_venv() {
    export VIRTUAL_ENV_DISABLE_PROMPT=1

    if [[ -d ".venv" && -f ".venv/bin/activate" ]]; then
        if [[ "$VIRTUAL_ENV" != "$PWD/.venv" ]]; then
            source .venv/bin/activate
        fi
    else
        if [[ -n "$VIRTUAL_ENV" ]]; then
            deactivate 2>/dev/null
            psvar[1]='' # force state clearance immediately upon exit
        fi
    fi
}
chpwd_functions+=(auto_activate_venv)
auto_activate_venv

# state index execution tracking engine (psvar setup)
virtenv_indicator() {
    if [[ -z "$VIRTUAL_ENV" ]]; then
        psvar[1]=''
    else
        psvar[1]=${VIRTUAL_ENV##*/}
    fi
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd virtenv_indicator

# EXACT robbyrussell source code structure with the gruvbox %1V block prepended securely
PROMPT='%(1V.%F{142}(%1v)%f .)%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'
