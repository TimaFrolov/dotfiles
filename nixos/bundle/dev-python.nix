{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (python3.withPackages(ppkgs: with ppkgs; [
      numpy
      scipy
      matplotlib
      python-lsp-server
      ipykernel
      pandas
    ]))
  ];
}
