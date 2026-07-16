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

    asns = lib.mkOption {
      type = with lib.types; listOf str;
      default = [
        "AS-CLOUDFLARE"
        "AS-TELEGRAM"
        "AS44907"       # Telegram
        "AS211157"      # Telegram
        "AS19527"       # Google Cloud
        "AS-GCORE"
        "AS16276"       # OVH
      ];
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

    systemd.services.ivpn-nft = {
      description = "Query IRR and load IVPN nftables rules";
      wantedBy = [ "multi-user.target" ];
      wants = [ "network-online.target" "nftables.service" ];
      after = [ "network-online.target" "nftables.service" ];
      path = with pkgs; [ bgpq4 nftables iprange bash ];
      environment = {
        ASN_LIST = lib.concatStringsSep "," cfg.asns;
        IVPN_MARK = cfg.ivpnMark;
      };
      serviceConfig = {
        Type = "oneshot";
        ExecStart = [ "${./ivpn-nft.sh}" ];
        RemainAfterExit = "yes";
      };
    };
  };
}
