{
  inputs,
  config,
  ...
}:
{
  age.secrets.cloudflare.file = "${inputs.secrets}/cloudflare.env.age";
  security.acme = {
    acceptTerms = true;
    certs."timafrolov.me" = {
      extraDomainNames = [ "*.timafrolov.me" ];
      dnsProvider = "cloudflare";
      dnsResolver = "1.1.1.1:53";
      environmentFile = config.age.secrets.cloudflare.path;
    };
  };
}
