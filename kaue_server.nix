{ config, pkgs, ... }:
{
  imports = [ ./common.nix ];
  home.username = "kaue";
  home.homeDirectory = "/home/kaue";
}
