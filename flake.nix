{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    xlibre-overlay.url = "git+https://codeberg.org/takagemacoed/xlibre-overlay?ref=dev-for-26.05";
    river-kwm.url = "github:rowsred/river_kwm_modules_nixos";
  };

  outputs =
    {
      self,
      nixpkgs,
      river-kwm,
      xlibre-overlay,
    }:
    {

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit river-kwm xlibre-overlay; };
          system = "x86_64-linux";
          modules = [
            ./src/configuration.nix
            ./src/dwm-wm.nix
            ./src/files-manager.nix
            ./src/editor.nix
            ./src/obs.nix
            ./src/fonts-custom.nix
          ];

        };

      };

    };
}
