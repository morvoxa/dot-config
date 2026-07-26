{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "mor";
  home.homeDirectory = "/home/mor";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    fastfetch
    neovim
    git
    fzf
    nixfmt
    tree
  ];
}
