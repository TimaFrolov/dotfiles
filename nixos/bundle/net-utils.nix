{ config, lib, pkgs, ... }:
{
  imports =
    [
      ../package/nethogs.nix
    ];

  environment.systemPackages = with pkgs; [
    inetutils
    nmap
    traceroute
    arp-scan
    openssl
    dig
    tcpdump
    ethtool
  ];
}
