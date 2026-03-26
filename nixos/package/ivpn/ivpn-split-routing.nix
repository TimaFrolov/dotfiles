{ config, lib, pkgs, ... }:
let
  cfg = config.services.ivpnCustom;

  ivpnSplitRoutingSync = pkgs.writeShellScript "ivpn-split-routing"
    (builtins.readFile ./ivpn-split-routing.sh);
in
lib.mkIf cfg.enable {
  systemd.services.ivpn-split-routing-sync = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" "ivpn-service.service" ];
    wants = [ "network-online.target" "ivpn-service.service" ];
    path = with pkgs; [ iproute2 gnugrep coreutils ];
    serviceConfig = {
      Type = "simple";
      ExecStart = ivpnSplitRoutingSync;
      Environment = [
        "IVPN_MARK=${cfg.ivpnMark}"
        "IVPN_TABLE=${builtins.toString cfg.ivpnTable}"
        "MAIN_RULE_PRIORITY=${builtins.toString cfg.mainRulePriority}"
        "IVPN_RULE_PRIORITY=${builtins.toString cfg.ivpnRulePriority}"
        "IVPN_IFACE=${cfg.ivpnIface}"
        "IVPN_IFACES=${lib.concatStringsSep "," cfg.ivpnIfaces}"
      ];
      Restart = "always";
      RestartSec = "2s";
    };
  };
}
