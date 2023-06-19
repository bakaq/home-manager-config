{ pkgs, ... }:
{
  # Check release notes before updating this
  # https://nix-community.github.io/home-manager/release-notes.html
  home.stateVersion = "23.05";
  programs.home-manager.enable = true;

  home.file = {
    # Bash
    ".bashrc".source = ./bash/.bashrc;
    ".bash_profile".source = ./bash/.bash_profile;
    ".bash_aliases".source = ./bash/.bash_aliases;
    ".bash_completion".source = ./bash/.bash_completion;
    # Nvim
    ".config/nvim/init.lua".source = ./nvim/init.lua;
    ".config/nvim/lua".source = ./nvim/lua;
    ".config/nvim/ftplugin".source = ./nvim/ftplugin;
  };

  # Available in
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
