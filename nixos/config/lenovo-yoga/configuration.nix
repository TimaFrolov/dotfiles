{ config, lib, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../bundle/core.nix
      ../../bundle/desktop.nix
      ../../bundle/intel-video.nix
      ../../bundle/disk-utils.nix
      ../../bundle/utils.nix
      ../../bundle/net-utils.nix
      ../../bundle/dev.nix
      ../../bundle/dev-latex.nix
      ../../bundle/dev-ocaml.nix
      ../../bundle/dev-c.nix
      ../../bundle/dev-rust.nix
      ../../bundle/dev-embedded.nix
      ../../bundle/dev-python.nix
      ../../bundle/dev-go.nix
      ../../package/vscode.nix
      ../../bundle/virtualisation.nix
      ../../bundle/games.nix
      ../../bundle/crypto-currency.nix
      ../../package/opencl.nix
      ../../package/ivpn/ivpn.nix
      ../../bundle/dev-asm.nix
      ../../bundle/thunderbolt-utils.nix
      ../../bundle/profiling.nix
      ../../package/keychron.nix
      ../../bundle/net-extra.nix
      ../../package/curseforge.nix
    ];

  environment.systemPackages = with pkgs; [
    discord
    halloy
    wvkbd
    obs-studio
    v4l-utils
    xournalpp
  ];

  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];

  networking.hostName = "yoga";

  system.stateVersion = "24.11";

  i18n.defaultLocale = "en_US.UTF-8";

  time.timeZone = "Europe/Moscow";

  services.tlp.settings = {
    CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    PLATFORM_PROFILE_ON_AC = "power";
    PLATFORM_PROFILE_ON_BAT = "power";
    DEVICES_TO_ENABLE_ON_STARTUP = "bluetooth wifi";
  };

  boot.initrd.luks.devices."crypted" = {
    bypassWorkqueues = true;
    allowDiscards = true;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    qt5.qtsvg
    qt5.qtbase
  ];

  users.users.fima = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "video" ];
    shell = pkgs.zsh;
  };
}
