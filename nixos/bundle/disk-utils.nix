{ config, lib, pkgs, ... }:
{
  services.udisks2.enable = true;
  environment.systemPackages = with pkgs; [
    udisks
    parted
    ncdu
    cryptsetup
    btrfs-progs
  ];
}
