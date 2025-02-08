{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lf
    pciutils
    jq
    parallel
    lm_sensors
  ];
}
