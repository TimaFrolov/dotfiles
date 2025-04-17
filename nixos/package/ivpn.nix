{ config, lib, pkgs, ... }:
{
  services.ivpn.enable = true;
  environment.systemPackages = with pkgs; [
    v2ray
  ];
  nixpkgs.overlays = [(final: prev: {
    ivpn-service = (prev.ivpn-service.overrideAttrs (old: {
      postPatch = old.postPatch + ''
        substituteInPlace daemon/service/platform/platform_linux_release.go \
          --replace 'v2rayBinaryPath = path.Join(installDir, "v2ray/v2ray")' \
          'v2rayBinaryPath = "${lib.getExe pkgs.v2ray}"'
      '';
    }));
  })];
}
