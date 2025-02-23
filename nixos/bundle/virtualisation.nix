{ config, lib, pkgs, ... }:
{
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;

  users.users.tima.extraGroups = [ "kvm" "qemu-libvirtd" "libvirtd"  ];
  environment.systemPackages = with pkgs; [ qemu ];
}
