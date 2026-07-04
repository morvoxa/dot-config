{ pkgs, fenix, ... }:
{
  environment.systemPackages = with pkgs; [
    (fenix.packages.${system}.stable.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    taplo
  ];
}
