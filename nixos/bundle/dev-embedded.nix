{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    minicom
    picocom
  ];
}
