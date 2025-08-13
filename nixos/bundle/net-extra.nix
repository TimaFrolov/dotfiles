{ config, lib, pkgs, ... }:
{
  networking.networkmanager.plugins = with pkgs; [ networkmanager-openvpn ];
}
