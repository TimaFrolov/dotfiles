{ config, pkgs, ... }:
{
  imports = [ 
    ../package/hyprland.nix
    ../package/waybar.nix
  ];
}
