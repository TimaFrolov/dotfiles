{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    razergenie
  ];

  hardware.openrazer.enable = true;
  hardware.openrazer.users = [ "tima" ];
}
