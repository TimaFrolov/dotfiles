{ config, lib, pkgs, ... }:
{
  services.udev.extraRules = ''
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", MODE:="0660", GROUP="input", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="3434", MODE:="0660", GROUP="input", TAG+="uaccess"

    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0660", GROUP="input", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0660", GROUP="input", TAG+="uaccess"
  '';
  users.users.tima.extraGroups = [ "input" ];
}
