{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lf
    pciutils
    jq
    parallel
    lm_sensors
    graphviz
    usbutils
    android-tools
    pdftk
    rlwrap
  ];
}
