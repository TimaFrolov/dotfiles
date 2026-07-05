{ config, pkgs, ... }:

{
  imports = [
  ];

  home.username = "tima";
  home.homeDirectory = "/home/tima";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = with pkgs.hyprlandPlugins; [ hy3 ];
    extraConfig = "require(tima)";
  };

  home.file.".config/hypr/tima" = {
    source = ../../../.config/hypr/tima;
    recursive = true;
  };
}
