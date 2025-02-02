{ config, lib, pkgs, ... }:

let unstable = import <nixos-unstable> {};
in {
  nixpkgs.overlays = [(final: prev: {
    neovim-unwrapped = (prev.neovim-unwrapped.overrideAttrs (old: {
      src = pkgs.fetchFromGitHub {
        owner = "neovim";
        repo = "neovim";
        rev = "807eb4434c890118e632ec57e396fd151c441714";
        hash = "sha256-jW+jwB/81ShUjI2Kt6kImeu6AEMo6zGEuRaKX8+FtlY=";
      };
      version = "v0.11.0-dev";
      cmakeFlags = old.cmakeFlags ++ [
        "-DCMAKE_BUILD_TYPE=RelWithDebInfo"
      ];
      buildInputs = old.buildInputs ++ [
        unstable.utf8proc
      ];
    }));
  })];
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
  ];
}
