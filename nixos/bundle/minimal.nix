{ config, lib, pkgs, ... }:
{
  imports = [ ../local.nix ];
  boot.loader.systemd-boot = {
    enable = true;
    editor = false;
    configurationLimit = 5;
  };

  boot.tmp.useTmpfs = true;

  services.speechd.enable = false;
  systemd.oomd.enable = false;

  networking.networkmanager.enable = true;
  networking.nftables.enable = true;
  services.resolved.enable = true;

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
    tree
  ];

  documentation.dev.enable = true;

  system.copySystemConfiguration = true;
  services.logind.settings.Login.HandlePowerKey = "suspend";
}
