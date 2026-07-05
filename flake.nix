{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    xlibre-overlay.url = "git+https://codeberg.org/takagemacoed/xlibre-overlay?ref=dev-for-26.05";
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
      xlibre-overlay,
    }:
    {

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit river-kwm fenix xlibre-overlay; };
          system = "x86_64-linux";
          modules = [
            ./src/configuration.nix
            ./src/dwm-wm.nix
            ./src/files-manager.nix
            ./src/editor.nix
            ./src/obs.nix
            ./src/rust-tools.nix
            ./src/android-tools.nix
            ./src/fonts-custom.nix
          ];

        };

      };

    };
}
