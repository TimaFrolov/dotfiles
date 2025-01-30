{ config, lib, pkgs, ... }:
{
  imports = [ ../local.nix ];
  boot.loader.systemd-boot = {
    enable = true;
    editor = false;
  };

  services.speechd.enable = false;
  systemd.oomd.enable = false;

  networking.networkmanager.enable = true;

  users.users.tima = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    tmux
    nix-tree
    file
    ncdu
  ];

  system.copySystemConfiguration = true;
}
