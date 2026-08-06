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
        home-manager.extraSpecialArgs = { inherit jail; };
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
