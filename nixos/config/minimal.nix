{ config, lib, pkgs, ... }:
{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ../bundle/minimal.nix
    ];

  system.stateVersion = "24.11";
}

