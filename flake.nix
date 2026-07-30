{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    waybar = {
      url = "github:alexays/waybar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    en_RU = {
      url = "github:timafrolov/en_ru";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    jail-nix.url = "sourcehut:~alexdavid/jail.nix";
  };

  nixConfig = {
    substituters = [
      "https://cache.nixos-cuda.org"
      "https://catppuccin.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
    ];
  };

  outputs = inputs@{ nixpkgs, home-manager, catppuccin, en_RU, jail-nix, ... }:
    let jail = import ./nixos/lib/jail.nix jail-nix;
    nixpkgs-modules = [
      { nixpkgs.overlays = [ inputs.waybar.overlays.default ]; }
      ./nixos/package/options.nix
    ];
    home-modules = { username }: [
      ((import ./nixos/home.nix) { inherit username; })
      catppuccin.homeModules.catppuccin
      en_RU.homeModules.default
    ];
    common-modules = { users }: nixpkgs-modules ++ [
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs jail; };
        home-manager.users = nixpkgs.lib.genAttrs users (username: {
          imports = home-modules { inherit username; };
        });
      }
      catppuccin.nixosModules.catppuccin
      en_RU.nixosModules.default
    ];
    in {
      nixosConfigurations = {
        "yoga" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            [ ./nixos/config/lenovo-yoga/configuration.nix ]
            ++ common-modules { users = [ "tima" "fima" ]; };
        };

        "desktop" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            [ ./nixos/config/desktop/configuration.nix ]
            ++ common-modules { users = [ "tima" ]; };
        };

        "NB-9472" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            [ ./nixos/config/kvadra/configuration.nix ]
            ++ common-modules { users = [ "tima" ]; };
        };
      };
    };
}
