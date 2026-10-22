{
  inputs,
  config,
  ...
}:
{
  age.secrets.rustfs.file = "${inputs.secrets}/rustfs.env.age";

  services.rustfs = {
    enable = true;
    environmentFile = config.age.secrets.rustfs.path;
  };

  services.nginx.virtualHosts =
    let
      extraConfig = ''
        client_max_body_size 0;
        proxy_buffering off;
        proxy_request_buffering off;
      '';
      locationExtraConfig = ''
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Connection "";
        proxy_connect_timeout 5s;
        proxy_read_timeout 300s;
        proxy_send_timeout 300s;
      '';
    in
    {
      "s3.timafrolov.me" = {
        inherit extraConfig;
        locations."/" = {
          proxyPass = "http://localhost:9000";
          extraConfig = locationExtraConfig + ''
            proxy_cache_convert_head off;
            chunked_transfer_encoding off;
          '';
        };
      };
      "s3-console.timafrolov.me" = {
        inherit extraConfig;
        locations."/" = {
          proxyPass = "http://localhost:9001";
          extraConfig = locationExtraConfig;
          proxyWebsockets = true;
        };
      };
    };
}
