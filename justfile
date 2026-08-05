default:
  @just --list
home:
  home-manager switch --flake . -b backup
