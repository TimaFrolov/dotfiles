{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    cmake
    autoconf
    clang-tools
    clang
  ];
}
