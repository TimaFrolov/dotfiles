{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lf
    pciutils
  ];
}
