{ config, lib, pkgs, ... }:
{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    fuse
    gtk3
    libX11
    pango
    cups
    libxkbcommon
    glib
    cairo
    nspr
    mesa
    alsa-lib
    nss
    dbus
    expat
    at-spi2-atk
    libXext
    libXrandr
    libXcomposite
    libXdamage
    libXfixes
    libxcb
    libgbm
    libxxf86vm
    libxcursor
    libxrender
    libxtst
    libxi
    freetype
    libGL
  ];
  environment.systemPackages = with pkgs; [
    xrandr
  ];
}
