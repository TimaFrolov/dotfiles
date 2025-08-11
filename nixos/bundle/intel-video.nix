{ config, lib, pkgs, ... }:
{
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    intel-compute-runtime
    vpl-gpu-rt
  ];
}
