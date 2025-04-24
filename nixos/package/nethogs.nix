{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nethogs
  ];
  security.wrappers.nethogs = {
    owner = "root";
    group = "wheel";
    permissions = "u+rx,g+x";
    capabilities = "cap_net_admin,cap_net_raw,cap_dac_read_search,cap_sys_ptrace+ep";
    source = "${pkgs.nethogs}/bin/nethogs";
  };
}
