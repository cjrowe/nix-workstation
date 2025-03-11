{
  description = "Multi-system configuration with Nix Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim/nixos-23.05";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    private-config = {
      url = "git+ssh://git@github.com/cjrowe/nix-config-private.git";
      flake = true;
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, nixvim, private-config, ... }:
  let
    linuxSystem = "x86_64-linux";
    darwinSystem = "aarch64-darwin";
  in {
    nixosConfigurations.home-desktop = nixpkgs.lib.nixosSystem {
      system = linuxSystem;
      modules = [
        ({ config, pkgs, ... }: { nixpkgs.config.allowUnfree = true; })
        ./nixos-configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.chris = import ./home-manager/home-desktop.nix {
            inherit nixvim private-config;
          };
        }
      ];
    };

    darwinConfigurations.spw-laptop = nix-darwin.lib.darwinSystem {
      system = darwinSystem;
      modules = [
        ({ config, pkgs, ... }: { nixpkgs.config.allowUnfree = true; })
        ./darwin-spw-configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.chris = import ./home-manager/spw-laptop.nix {
            inherit nixvim private-config;
          };
        }
      ];
    };

    darwinConfigurations.family-laptop = nix-darwin.lib.darwinSystem {
      system = darwinSystem;
      modules = [
        ({ config, pkgs, ... }: { nixpkgs.config.allowUnfree = true; })
        ./darwin-family-configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.chris = import ./home-manager/family-laptop.nix {
            inherit nixvim private-config;
          };
        }
      ];
    };
  };
}
