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
    ];

  system.stateVersion = "24.11";

  services.ivpn.enable = true;
  environment.systemPackages = with pkgs; [
    v2ray
  ];

  services.tlp.settings = {
    CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    PLATFORM_PROFILE_ON_AC = "balanced";
    PLATFORM_PROFILE_ON_BAT = "power";
    DEVICES_TO_ENABLE_ON_STARTUP = "bluetooth wifi";
  };
}
