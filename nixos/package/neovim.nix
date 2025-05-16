{ config, lib, pkgs, ... }:

let unstable = import <nixos-unstable> {};
in {
  environment.systemPackages = with pkgs; [
    unstable.neovim
    cmake
    gnumake
    gcc
    fzf
    ripgrep
    unzip
    wget
    fd
    luajit
    luajitPackages.luarocks
    luajitPackages.jsregexp
    gh
    lua-language-server
    tree-sitter
    nodejs
  ];
}
