{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    inetutils
    nmap
    traceroute
    arp-scan
    nethogs
    openssl
    dig
  ];
}
