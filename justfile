default:
  @just --list
wsl:
  home-manager switch --flake .#wsl
des:
  home-manager switch --flake .#desktop
os:
  sudo nixos-rebuild switch --flake .
