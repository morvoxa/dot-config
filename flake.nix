{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    xlibre-overlay.url = "git+https://codeberg.org/takagemacoed/xlibre-overlay?ref=dev-for-26.05";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
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
      nix-cachyos-kernel,
    }:
    {

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit river-kwm fenix xlibre-overlay; };
          system = "x86_64-linux";
          modules = [
            (
              { pkgs, ... }:
              {
                nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
                nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];
                boot.kernelPackages = nix-cachyos-kernel.legacyPackages.x86_64-linux.linuxPackages-cachyos-latest;
              }
            )
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
