{
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ../../bundle/core.nix
    # ../../bundle/desktop.nix
    ../../bundle/disk-utils.nix
    ../../bundle/utils.nix
    ../../bundle/net-utils.nix

    ../../services/obsidiandb.nix
    ../../services/certbot.nix
    ../../services/jitsi.nix
    ../../services/nginx.nix
    inputs.agenix.nixosModules.default
  ];

  networking.hostName = "orangepi";

  system.stateVersion = "26.11";

  i18n.defaultLocale = "en_RU.UTF-8";

  time.timeZone = "Etc/UTC";

  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  tima.dev.nvim = true;

  systemd.services.sshd.unitConfig.StartLimitIntervalSec = 0;
}
