{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/default-linux";
    nixpkgs-patcher.url = "github:gepbird/nixpkgs-patcher";
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

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-patcher,
      systems,
      home-manager,
      catppuccin,
      en_RU,
      jail-nix,
      ...
    }:
    let
      jail = import ./nixos/lib/jail.nix jail-nix;
      eachSystem =
        fn: nixpkgs.lib.genAttrs (import systems) (system: fn system nixpkgs.legacyPackages.${system});
      nixpkgs-modules = [
        { nixpkgs.overlays = [ inputs.waybar.overlays.default ]; }
        ./nixos/package/options.nix
      ];
      home-modules = { username }: [
        ((import ./nixos/home.nix) { inherit username; })
        catppuccin.homeModules.catppuccin
        en_RU.homeModules.default
      ];
      common-modules =
        { users }:
        nixpkgs-modules
        ++ [
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
    in
    {
      nixosConfigurations = {
        "yoga" = nixpkgs-patcher.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = inputs;
          modules = [
            ./nixos/config/lenovo-yoga/configuration.nix
          ]
          ++ common-modules {
            users = [
              "tima"
              "fima"
            ];
          };
        };

        "desktop" = nixpkgs-patcher.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = inputs;
          modules = [ ./nixos/config/desktop/configuration.nix ] ++ common-modules { users = [ "tima" ]; };
        };

        "NB-9472" = nixpkgs-patcher.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = inputs;
          modules = [ ./nixos/config/kvadra/configuration.nix ] ++ common-modules { users = [ "tima" ]; };
        };
      };

      formatter = eachSystem (system: pkgs: pkgs.nixfmt-tree);

      checks = eachSystem (
        system: pkgs: {
          nixf-diagnose =
            pkgs.runCommand "nixf-diagnose-check" { nativeBuildInputs = [ pkgs.nixf-diagnose ]; }
              ''
                set -euo pipefail
                for file in $(find "${./.}" -name '*.nix'); do
                  nixf-diagnose "$file"
                done
                touch "$out"
              '';
          nixfmt = pkgs.runCommand "nixfmt-check" { nativeBuildInputs = [ self.formatter.${system} ]; } ''
            set -euo pipefail
            cp -r "${./.}" work
            chmod -R u+w work
            treefmt --ci --tree-root "$PWD/work"
            touch "$out"
          '';
        }
      );
    };
}
