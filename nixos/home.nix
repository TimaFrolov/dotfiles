{ username }:
{
  inputs,
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  imports = [
    home/package/tmux.nix
    package/catppuccin.nix
    inputs.catppuccin.homeModules.catppuccin
  ]
  ++ lib.optional (osConfig.hardware.graphics.enable or false) home/bundle/desktop.nix
  ++ lib.optionals (osConfig.tima.dev.nvim or false) [
    home/nvim
    home/package/opencode.nix
    home/package/jail.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  programs.man.generateCaches = true;

  programs.nh = {
    enable = true;
    flake = "/home/${username}/dotfiles";
  };

  home.packages = with pkgs; [
    lazygit
    agenix
  ];
}
