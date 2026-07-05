{ config, lib, pkgs, ... }:
{
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
  programs.steam.extest.enable = true;
  environment.systemPackages = with pkgs; [
    heroic
    gamescope
    mangohud
    wljoywake
    protontricks
    r2modman
    gdlauncher-carbon
  ];
}
