{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (python3.withPackages(ppkgs: with ppkgs; [
      numpy
      scipy
      python-lsp-server
    ]))
  ];
}
