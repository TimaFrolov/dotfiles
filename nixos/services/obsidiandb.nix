{
  inputs,
  config,
  ...
}:
{
  age.secrets.obsidiandb.file = "${inputs.secrets}/obsidiandb.env.age";

  services.couchdb = {
    enable = true;
    port = 5984;
  };

  systemd.services.couchdb.serviceConfig.EnvironmentFile = config.age.secrets.obsidiandb.path;

  services.nginx.virtualHosts."obsidian.timafrolov.me".locations."/".proxyPass =
    "http://localhost:${toString config.services.couchdb.port}";
  services.nginx.clientMaxBodySize = "100m";
}
