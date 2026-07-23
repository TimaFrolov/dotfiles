{ username }:
{ config, pkgs, ... }:

{
  imports = [
    package/catppuccin.nix
    home/package/opencode.nix
    home/bundle/desktop.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
