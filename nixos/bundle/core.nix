{ config, lib, pkgs, ... }:
{
  imports = [ ./minimal.nix ];

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
  };

  users.users.tima.shell = pkgs.zsh;

  zramSwap = {
    enable = true;
    memoryMax = 8 * 1024 * 1024 * 1024; # 8 GB
    memoryPercent = 100;
  };

  environment.systemPackages = with pkgs; [
    earlyoom
    btop
    python3
    nix-index
  ];

  environment.sessionVariables = {
    PATH = [
      "$HOME/.local/bin"
      "$HOME/bin"
      "$HOME/.local/bin/scripts"
      "$PATH"
      "$HOME/.cargo/bin"
      "$HOME/go/bin"
      "$HOME/.local/share/coursier/bin"
    ];
  };
}
