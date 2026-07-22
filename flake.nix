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
  };

  outputs = inputs@{ nixpkgs, home-manager, catppuccin, ... }:
    let home-modules = { username }: [
      ((import ./nixos/home.nix) { inherit username; })
      catppuccin.homeModules.catppuccin
    ]; in
    let common-modules = { users }: [ 
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

      homeConfigurations.tima = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = home-modules { username = "tima"; };
      };
    };
}
