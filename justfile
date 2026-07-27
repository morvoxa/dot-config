default:
  @just --list
wsl:
  home-manager switch --flake .#wsl
desktop:
  home-manager switch --flake .#desktop
