{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
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
