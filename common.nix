{ pkgs, ... }:
{
  # Check release notes before updating this
  # https://nix-community.github.io/home-manager/release-notes.html
  home.stateVersion = "23.05";
  programs.home-manager.enable = true;

  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    plugins = with pkgs.vimPlugins; [
      packer-nvim
    ];
  };

  programs.exa.enable = true;
  programs.jq.enable = true;

  home.packages = with pkgs; [
    curl
  ];

  home.file = {
    # Bash
    ".bashrc".source = ./dotfiles/.bashrc;
    ".bash_profile".source = ./dotfiles/.bash_profile;
    ".bash_aliases".source = ./dotfiles/.bash_aliases;
    ".bash_completion".source = ./dotfiles/.bash_completion;
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
