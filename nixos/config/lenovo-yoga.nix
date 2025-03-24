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
      ../package/vscode.nix
      ../bundle/virtualisation.nix
      ../bundle/games.nix
      ../bundle/crypto-currency.nix
    ];

  system.stateVersion = "24.11";

  services.ivpn.enable = true;
  environment.systemPackages = with pkgs; [
    v2ray
  ];

  services.tlp.settings =
  let energy_perf = "balance_power"; in
  let platform_profile = "balanced"; in
  {
    CPU_ENERGY_PERF_POLICY_ON_AC = energy_perf;
    CPU_ENERGY_PERF_POLICY_ON_BAT = energy_perf;
    PLATFORM_PROFILE_ON_AC = platform_profile;
    PLATFORM_PROFILE_ON_BAT = platform_profile;
    DEVICES_TO_ENABLE_ON_STARTUP = "bluetooth wifi";
  };
}
