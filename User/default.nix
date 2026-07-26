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
    firefox
    fastfetch
    neovim
    git
    fzf
    nixfmt
    stylua
    tree
    xclip
    alacritty
    vscodium
    devenv
    tmux
  ];
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.bash = {
    enable = true;
    initExtra = ''
      eval "$(direnv hook bash)"
    '';
  };
}
