{ config, lib, pkgs, ... }:
{
  imports = [ ../package/neovim.nix ];

  virtualisation.podman = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    lazygit
    distrobox
    git-lfs
    vbindiff
    pwntools
    tokei
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
