{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  rootPartitionUUID = "9e816753-7cfc-486b-968f-20ecde377b61";
in
{
  imports = [ "${inputs.nixpkgs}/nixos/modules/installer/sd-card/sd-image.nix" ];

  boot = {
    kernelParams = [
      "root=UUID=${rootPartitionUUID}"
      "rootfstype=ext4"
    ];
    consoleLogLevel = 7;

    loader = {
      grub.enable = lib.mkForce false;
      systemd-boot.enable = lib.mkForce false;
      generic-extlinux-compatible.enable = lib.mkForce true;
    };
  };

  sdImage = {
    inherit rootPartitionUUID;
    compressImage = false;

    populateFirmwareCommands = "";

    firmwareSize = 1; # MiB
    firmwarePartitionName = "UNUSED";

    firmwarePartitionOffset = 32; # MiB

    populateRootCommands = ''
      ${config.boot.loader.generic-extlinux-compatible.populateCmd} -c ${config.system.build.toplevel} -d ./files/boot
    '';

    postBuildCommands =
      let
        uboot = pkgs.ubootOrangePi5Plus;
      in
      ''
        dd if=${uboot}/idbloader.img of=$img seek=64 conv=fsync,notrunc
        dd if=${uboot}/u-boot.itb of=$img seek=16384 conv=fsync,notrunc
      '';
  };
}
