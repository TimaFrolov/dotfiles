{
  lib,
  ...
}:
{
  config = {
    users.users.nginx.extraGroups = [ "acme" ];
    services.nginx = {
      enable = true;
      defaultListen = [
        {
          addr = "0.0.0.0";
          ssl = true;
        }
      ];
      virtualHosts = {
        "timafrolov.me" = {
          default = true;
          root = "/var/www/timafrolov.me";
          serverAliases = [ "www.timafrolov.me" ];
          locations."/" = {
            index = "index.html index.png index.pdf";
            tryFiles = "$uri $uri/ =404";
          };
        };
      };
    };
    networking.firewall.allowedTCPPorts = [ 443 ];
  };
  options.services.nginx.virtualHosts = lib.mkOption {
    type =
      with lib.types;
      attrsOf
      <| submodule {
        useACMEHost = "timafrolov.me";
        enableACME = false;
        forceSSL = true;
      };
  };
}
