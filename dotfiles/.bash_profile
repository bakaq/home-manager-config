#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -f ~/.nix-profile/etc/profile.d/hm-session-vars.sh ]]; then
    . ~/.nix-profile/etc/profile.d/hm-session-vars.sh
fi

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export QT_QPA_PLATFORMTHEME=qt5ct
export XMODIFIERS=@im=fcitx

export XDG_SCREENSHOTS_DIR="/home/kaue/pics/screenshots"

export GEM_HOME="$(ruby -e 'puts Gem.user_dir' || echo '')"

export PATH="/home/kaue/.local/bin:$PATH"
export PATH="/home/kaue/.cargo/bin:$PATH"
export PATH="$GEM_HOME/bin:$PATH"
export PATH="/home/kaue/.nix-profile/bin/:$PATH"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
