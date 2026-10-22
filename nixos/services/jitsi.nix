{
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
  services.jitsi-videobridge.openFirewall = true;
}
