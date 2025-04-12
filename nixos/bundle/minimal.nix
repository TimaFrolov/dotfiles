{ config, lib, pkgs, ... }:
{
  imports = [ ../local.nix ];
  boot.loader.systemd-boot = {
    enable = true;
    editor = false;
    configurationLimit = 5;
  };

  services.speechd.enable = false;
  systemd.oomd.enable = false;

  networking.networkmanager.enable = true;

  users.users.tima = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    tmux
    nix-tree
    file
    man-pages
  ];

  system.copySystemConfiguration = true;
  services.logind.powerKey = "suspend";
}
