{ config, lib, pkgs, ... }:

in {
  environment.systemPackages = with pkgs; [
    tbtools
  ];
}
