{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    config.boot.kernelPackages.perf
    flamegraph
  ];
}
