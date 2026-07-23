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
  };

  outputs = inputs@{ nixpkgs, home-manager, catppuccin, ... }:
    let
    nixpkgs-modules = [
      { nixpkgs.overlays = [ inputs.waybar.overlays.default ]; }
      ./nixos/package/options.nix
    ];
    home-modules = { username }: [
      ((import ./nixos/home.nix) { inherit username; })
      catppuccin.homeModules.catppuccin
    ];
    common-modules = { users }: nixpkgs-modules ++ [
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users = nixpkgs.lib.genAttrs users (username: {
          imports = home-modules { inherit username; };
        });
      }
      catppuccin.nixosModules.catppuccin
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
