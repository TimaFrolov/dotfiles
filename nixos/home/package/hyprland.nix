{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = with pkgs.hyprlandPlugins; [ hy3 ];
    extraConfig = ''require("tima")'';
  };

  home.file.".config/hypr/tima" = {
    source = ../../../.config/hypr/tima;
    recursive = true;
  };
}
