{ config, lib, pkgs, ... }:
{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    fuse
    gtk3
    xorg.libX11
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
    xorg.libXext
    xorg.libXrandr
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXfixes
    xorg.libxcb
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
