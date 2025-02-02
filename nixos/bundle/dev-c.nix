{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    cmake
    autoconf
    llvmPackages_19.clang-tools
    llvmPackages_19.clangUseLLVM
  ];
}
