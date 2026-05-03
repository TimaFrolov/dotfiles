{ config, lib, pkgs, ... }:
let
  cfg = config.services.ivpnCustom;
in
{
  imports = [
    ./squid.nix
    ./ivpn-split-routing.nix
  ];

  options.services.ivpnCustom = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    proxyPort = lib.mkOption {
      type = lib.types.port;
      default = 3128;
    };

    ivpnMark = lib.mkOption {
      type = lib.types.str;
      default = "0x42";
    };

    ivpnTable = lib.mkOption {
      type = lib.types.ints.positive;
      default = 4242;
    };

    mainRulePriority = lib.mkOption {
      type = lib.types.ints.positive;
      default = 1;
    };

    ivpnRulePriority = lib.mkOption {
      type = lib.types.ints.positive;
      default = 2;
    };

    ivpnIface = lib.mkOption {
      type = lib.types.str;
      default = "wgivpn";
    };

    ivpnIfaces = lib.mkOption {
      type = with lib.types; listOf str;
      default = [ "wgivpn" "tun0" ];
    };
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [
      (final: prev: {
        ivpn-iptables-wrapper = prev.callPackage ./ivpn-iptables-wrapper.nix { };
      })
    ];

    services.ivpn.enable = true;
    systemd.services.ivpn-service.path = lib.mkBefore [ pkgs.ivpn-iptables-wrapper ];

    environment.etc."ivpn.nft".text = lib.replaceStrings [ "IVPN_MARK" ] [ cfg.ivpnMark ] (builtins.readFile ./ivpn.nft);

    systemd.services.ivpn-nft = {
      description = "Load IVPN nftables rules";
      wantedBy = [ "multi-user.target" ];
      wants = [ "network-online.target" "nftables.service" ];
      after = [ "network-online.target" "nftables.service" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = ''${pkgs.nftables}/bin/nft -f /etc/ivpn.nft'';
        RemainAfterExit = "yes";
      };
    };
  };
}
