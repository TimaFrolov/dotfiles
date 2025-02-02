{ config, lib, pkgs, ... }:
{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ../bundle/desktop.nix
      ../bundle/core.nix
      ../bundle/disk-utils.nix
      ../bundle/utils.nix
      ../bundle/dev.nix
      ../bundle/dev-latex.nix
      ../bundle/dev-ocaml.nix
      ../bundle/dev-c.nix
      ../bundle/dev-rust.nix
      ../bundle/dev-embedded.nix
      ../bundle/dev-python.nix
      ../bundle/games.nix
    ];

  system.stateVersion = "24.11";

  services.ivpn.enable = true;
}

