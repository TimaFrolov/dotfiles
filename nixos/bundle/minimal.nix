{
  lib,
  pkgs,
  ...
}:
{
  boot.loader.systemd-boot = {
    enable = true;
    editor = false;
    configurationLimit = 5;
  };

  boot.tmp.useTmpfs = true;

  services.speechd.enable = lib.mkForce false;
  systemd.oomd.enable = false;

  networking.networkmanager.enable = true;
  networking.nftables.enable = true;
  services.resolved.enable = true;

  nix.settings.trusted-users = [ "tima" ];
  users.users.tima = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    tmux
    nix-tree
    file
    man-pages
    tree
    psmisc
    nvd
  ];

  documentation.dev.enable = true;
  documentation.man.cache.enable = true;

  services.logind.settings.Login.HandlePowerKey = "suspend";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
