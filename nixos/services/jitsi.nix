{
  config,
  ...
}:
{
  nixpkgs.config.permittedInsecurePackages = [ "jitsi-meet-1.0.9365" ];
  services.jitsi-meet = {
    enable = true;
    nginx.enable = true;
    hostName = "talk.timafrolov.me";

    secureDomain.enable = true;

    prosody = {
      enable = true;
      lockdown = true;
    };
  };
  networking.firewall.allowedUDPPorts = [ (config.jitsi-videobridge.ice.udp.port or 10000) ];
}
