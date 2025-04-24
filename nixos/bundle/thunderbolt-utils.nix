{ config, lib, pkgs, ... }:

let unstable = import <nixos-unstable> {};
in {
  environment.systemPackages = with pkgs; [
    unstable.tbtools
  ];
}
