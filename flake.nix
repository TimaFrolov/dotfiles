{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
    let home-manager-modules = { users }: [ 
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users = nixpkgs.lib.genAttrs users (user: (import ./nixos/home.nix) { username = user; });
      } 
    ];
    in {
      nixosConfigurations = {
        "yoga" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = 
            [ ./nixos/config/lenovo-yoga/configuration.nix ] 
            ++ home-manager-modules { users = [ "tima" "fima" ]; };
        };

        "desktop" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = 
            [ ./nixos/config/desktop/configuration.nix ] 
            ++ home-manager-modules { users = [ "tima" ]; };
        };

        "NB-9472" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = 
            [ ./nixos/config/kvadra/configuration.nix ] 
            ++ home-manager-modules { users = [ "tima" ]; };
        };
      };

      homeConfigurations.tima = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacy.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [ (import ./nixos/home.nix) { username = "tima"; } ];
      };
    };
}
