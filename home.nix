{ config, pkgs, ... }:

{
  home.username = "kaue";
  home.homeDirectory = "/home/kaue";

  # Check release notes before updating this
  # https://nix-community.github.io/home-manager/release-notes.html
  home.stateVersion = "23.05";

  #home.packages = with pkgs; [];

  home.file = {
    ".bashrc".source = ./dotfiles/.bashrc;
    ".bash_profile".source = ./dotfiles/.bash_profile;
    ".bash_aliases".source = ./dotfiles/.bash_aliases;
    ".bash_completion".source = ./dotfiles/.bash_completion;
  };

  # Available in
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
