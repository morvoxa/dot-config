default:
  @just --list
wsl:
  home-manager switch --flake .#wsl -b backup
des:
  home-manager switch --flake .#desktop -b backup
os:
  sudo nixos-rebuild switch --flake .
