{ config, lib, pkgs, ... }:
{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ../bundle/desktop.nix
      ../bundle/core.nix
      ../package/neovim.nix
    ];

  system.stateVersion = "24.11";
}

