{ config, lib, ... }:
let
  cfg = config.services.ivpnCustom;
  proxyPort = builtins.toString cfg.proxyPort;
  squidProxy = "http://127.0.0.1:${proxyPort}";
  squidConfigText = builtins.replaceStrings
    [ "@IVPN_MARK@" "@PROXY_PORT@" ]
    [ cfg.ivpnMark proxyPort ]
    (builtins.readFile ./squid.conf);
in
lib.mkIf cfg.enable {
  networking.proxy.default = squidProxy;

  services.squid = {
    enable = true;
    proxyPort = cfg.proxyPort;
    configText = squidConfigText;
  };
}
