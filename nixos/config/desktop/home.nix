{ config, pkgs, ... }:

{
  imports = [
  ];

  home.username = "tima";
  home.homeDirectory = "/home/tima";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
