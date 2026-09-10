{ username }:
{
  lib,
  osConfig,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    home/package/opencode.nix
    home/package/tmux.nix
    home/nvim
    home/package/jail.nix
  ]
  ++ lib.optional osConfig.hardware.graphics.enable home/bundle/desktop.nix;

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  programs.man.generateCaches = true;

  programs.nh = {
    enable = true;
    flake = "/home/${username}/dotfiles";
  };

  home.packages = [
    inputs.agenix.packages.${pkgs.system}.default
  ];
}
