{ config, lib, pkgs, ... }:
{
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    heroic
    gamescope
    mangohud
    gfn-electron
    wljoywake
  ];
}
