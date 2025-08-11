{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ wshowkeys ];
  nixpkgs.overlays = [(final: prev: {
    wshowkeys = (prev.wshowkeys.overrideAttrs(old: {
      src = prev.fetchFromGitHub {
        owner = "TimaFrolov";
        repo = "wshowkeys";
        rev = "cbf7eeb99349388b1ece693e08ae375477e7b03f";
        hash = "sha256-MVkKIasAiZAqonKOuQkSU5eslRKrD4JcyVCw/q9RpZA=";
      };
    }));
  })];
  security.wrappers.wshowkeys = {
    owner = "root";
    group = "wheel";
    permissions = "u+rs,g+x";
    source = "${pkgs.wshowkeys}/bin/wshowkeys";
  };
}
