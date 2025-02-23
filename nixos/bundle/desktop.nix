{ config, lib, pkgs, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "maldives";
  };

  programs.sway.enable = true;

  services.printing = {
    enable = true;
    drivers = with pkgs; [ hplip ];
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  nixpkgs.config.allowUnfree = true;
  programs.light.enable = true;
  hardware.bluetooth.enable = true;
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
    xdg-user-dirs
    adwaita-icon-theme
    sway-contrib.grimshot
    pavucontrol
    gnome-calendar
    bluez
    gnome-disk-utility
    wl-clipboard
    feh
    blueman
    zathura
    meld
    libreoffice
  ];

  environment.variables.GTK_THEME = "Adwaita:dark";
  environment.variables.GTK_ICON_THEME = "Adwaita";
  qt.style = "adwaita-dark";
  fonts.packages = let unstable = import <nixos-unstable> {}; in with pkgs; [
    unstable.nerd-fonts.jetbrains-mono
  ];
}
