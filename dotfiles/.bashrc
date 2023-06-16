###############
### .bashrc ###
###############

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# Bash history
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=
HISTFILESIZE=
HISTTIMEFORMAT="[%F %T] "
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Options
shopt -s checkwinsize

# Prompt
case "$TERM" in
    xterm-color|*-256color|linux|foot) color_prompt=yes;;
esac

function git_prompt {
    # Don't run in weird filesystems
    local filesystem=$(df -P -T . | tail -n +2 | awk '{print $2}')
    if [ "${filesystem}" != "ext4" ]; then
        return 0
    fi

    local branch=$(git branch 2>/dev/null | grep '^*' | awk '{print $2 " "}')
    if expr length "${branch}" 2>&1 > /dev/null; then
        if expr length "$(git status -s 2>/dev/null)" 2>&1 > /dev/null; then
            echo -ne "\[\033[0;33m\]${branch}\[\033[0m\]"
        else
            echo -ne "\[\033[0;32m\]${branch}\[\033[0m\]"
        fi
    fi
}

function nix_prompt {
    if [[ -n $IN_NIX_SHELL ]]; then
        echo "{nix} "
    fi
}

function custom_prompt {
    local last_status="$?"
    PS1=""
    PS1+="$(nix_prompt)"
    PS1+="$CONDA_PROMPT_MODIFIER"
    if [[ $last_status != 0 ]]; then
        PS1+="\[\033[0;31m\]${last_status}\[\033[00m\] "
    fi
    if [[ $HOSTNAME == kbook ]]; then 
        PS1+='[\[\033[01;34m\]\w\[\033[00m\]] '
    else
        PS1+='[\[\033[01;34m\]\h:\w\[\033[00m\]] '
    fi
    PS1+="$(git_prompt)"
    PS1+='\$ '
}

if [[ $HOSTNAME == kbook ]]; then
    PROMPT_DIRTRIM=3
else
    PROMPT_DIRTRIM=2
fi

if [[ $color_prompt = yes ]]; then
    PROMPT_COMMAND=custom_prompt
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# Aliases
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# Completion
[[ -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# fzf
[[ -f /usr/share/fzf/key-bindings.bash ]] && . /usr/share/fzf/key-bindings.bash
[[ -f /usr/share/fzf/completion.bash ]] && . /usr/share/fzf/completion.bash

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/kaue/.miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/kaue/.miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/kaue/.miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/kaue/.miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE="/usr/bin/micromamba";
export MAMBA_ROOT_PREFIX="/home/kaue/.local/share/micromamba";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    if [ -f "/home/kaue/.local/share/micromamba/etc/profile.d/micromamba.sh" ]; then
        . "/home/kaue/.local/share/micromamba/etc/profile.d/micromamba.sh"
    else
        export  PATH="/home/kaue/.local/share/micromamba/bin:$PATH"  # extra space after export prevents interference from conda init
    fi
fi
unset __mamba_setup
# <<< mamba initialize <<<

command -v direnv > /dev/null 2>&1 && eval "$(direnv hook bash)" || true
