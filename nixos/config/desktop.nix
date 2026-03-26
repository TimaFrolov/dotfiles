{ config, lib, pkgs, ... }:
{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ../bundle/core.nix
      ../bundle/desktop.nix
      ../bundle/intel-video.nix
      ../bundle/disk-utils.nix
      ../bundle/utils.nix
      ../bundle/net-utils.nix
      ../bundle/dev.nix
      ../bundle/dev-latex.nix
      ../bundle/dev-ocaml.nix
      ../bundle/dev-c.nix
      ../bundle/dev-rust.nix
      ../bundle/dev-embedded.nix
      ../bundle/dev-python.nix
      ../bundle/dev-go.nix
      ../package/vscode.nix
      ../bundle/virtualisation.nix
      ../bundle/games.nix
      ../bundle/crypto-currency.nix
      ../package/opencl.nix
      ../package/ivpn/ivpn.nix
      ../bundle/dev-asm.nix
      ../bundle/thunderbolt-utils.nix
      ../bundle/profiling.nix
      ../package/keychron.nix
      ../bundle/net-extra.nix
      ../package/curseforge.nix
      ../package/razer.nix
    ];

  environment.systemPackages = with pkgs; [
    halloy
    wvkbd
    (obs-studio.override{cudaSupport = true;})
    v4l-utils
    xournalpp
    hyprland
    discord
  ];

  boot.kernelModules = [ 
    "v4l2loopback" 
    "nvidia_drm" "nvidia_modeset" "nvidia" "nvidia_uvm"
  ];
  boot.extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];

  system.stateVersion = "25.11";

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libsForQt5.qt5.qtsvg
    libsForQt5.qt5.qtbase
  ];

  hardware.graphics.extraPackages = with pkgs; [ nvidia-vaapi-driver ];
  hardware.nvidia-container-toolkit.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
}
