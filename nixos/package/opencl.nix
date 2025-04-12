{ config, lib, pkgs, ... }:
{
  hardware.graphics.extraPackages = with pkgs; [ pocl ];
  environment.systemPackages = with pkgs; [ clinfo ];
}
