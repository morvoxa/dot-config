{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    river-kwm.url = "github:rowsred/river_kwm_modules_nixos";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      river-kwm,
      fenix,
    }:
    {

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit river-kwm fenix; };
          system = "x86_64-linux";
          modules = [
            ./src/configuration.nix
            ./src/cosmic-de.nix
            ./src/editor.nix
            ./src/obs.nix
            ./src/rust-tool.nix
          ];

        };

      };

    };
}
