{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      flake-parts,
      nixpkgs,
      home-manager,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
        };

      flake = {
        homeConfigurations = {
          # Target untuk WSL -> jalankan: home-manager switch --flake .#wsl
          "wsl" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = {
              isWsl = true;
            }; # <-- Passing flag WSL di sini
            modules = [ ./User ];
          };

          # Target untuk Native -> jalankan: home-manager switch --flake .#desktop
          "desktop" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = {
              isWsl = false;
            }; # <-- Passing flag Non-WSL di sini
            modules = [ ./User ];
          };
        };
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
          modules = [
            ./System/hardware-configuration.nix
            ./System/configuration.nix
            ./System/hyprland.nix
          ];
        };

      };
    };
}
