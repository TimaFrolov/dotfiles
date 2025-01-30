{ config, lib, pkgs, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "maldives";
  };

  programs.sway.enable = true;

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    alacritty
    (brave.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        ln -sf $BINARYWRAPPER $out/bin/brave-browser
      '';
    }))
    telegram-desktop
    google-chrome
    waybar
    wofi
    kanshi
    dunst
  ];

  fonts.packages = let unstable = import <nixos-unstable> {}; in with pkgs; [
    unstable.nerd-fonts.jetbrains-mono
  ];
}
