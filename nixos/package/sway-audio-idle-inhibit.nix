{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ sway-audio-idle-inhibit ];
  nixpkgs.overlays = [(final: prev: {
    sway-audio-idle-inhibit = (prev.sway-audio-idle-inhibit.overrideAttrs(old: {
      src = prev.fetchFromGitHub {
        owner = "ErikReider";
        repo = "SwayAudioIdleInhibit";
        rev = "c40b7b5eeaf6ff216ba050cb959f11f5b26fbf84";
        hash = "sha256-tI6ah2SJeXePTqpmQv6oJGRwyjCw43t4CHEKwHGb/PM=";
      };
    }));
  })];
}
