####################
### Bash aliases ###
####################

### Files ###

alias bashrc="$EDITOR ~/.bashrc"					# Edit .bashrc
alias bashs="source ~/.bashrc"						# Source .bashrc
alias basha="$EDITOR ~/.bash_aliases"				# Edit .bash_aliases
alias nvimrc="$EDITOR ~/.config/nvim/init.lua"		# Edit init.lua

### Directories ###

alias uni="pushd ~/docs/uni/current/ > /dev/null"	# Go to current uni folder
alias geral="pushd ~/docs/uni/current/geral/ > /dev/null"
alias quantica_avancada="pushd ~/docs/uni/current/quantica_avancada/ > /dev/null"
alias particulas="pushd ~/docs/uni/current/particulas/ > /dev/null"

alias scratch="pushd ~/docs/scratch/ > /dev/null"	# Go to scratch folder
alias projects="pushd ~/docs/projects/ > /dev/null" # Go to projects folder
alias learning="pushd ~/docs/learning/ > /dev/null" # Go to learning folder
alias ic="pushd ~/docs/ic/ > /dev/null"
alias docs="pushd ~/docs/ > /dev/null"
alias dls="pushd ~/dls/ > /dev/null"

### Commands ###

# Shortcuts
alias vimwiki="nvim -c ':VimwikiIndex'"
alias lessc="less -R"

alias weather="curl 'wttr.in/'"

#alias rm="echo 'Use trash-put loser' | cowsay #"

function zat {
	zathura "$1" &> /dev/null &
}

function jsonv {
	jq . "$1" -C | less -R
}
complete -F _longopt jsonv

mkcd () {
	mkdir -p "$1"
	pushd "$1" > /dev/null
}

# Change default behaviour
alias diff="diff --color"
alias fehs="feh --scale-down --auto-zoom"
alias lsblk="lsblk -o +LABEL"
alias ls='exa --group-directories-first --icons'

# Functions
toggle_conservation_mode () {
	conserv='/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode'
	conserved="$(cat "$conserv")"
	case $conserved in
		0)
			echo 1 | sudo tee "$conserv"
			echo "Conservation mode turned on"
			;;
		1)
			echo 0 | sudo tee "$conserv"
			echo "Conservation mode turned off"
			;;
		*)
			echo "Unknown conservation state"
			;;
	esac
}

complete -F _longopt trash
complete -F _longopt trash-put
