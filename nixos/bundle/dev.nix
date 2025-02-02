{ config, lib, pkgs, ... }:
{
  imports = [ ../package/neovim.nix ];
  environment.systemPackages = with pkgs; [
    lazygit
  ];
}
