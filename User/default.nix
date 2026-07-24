{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    #cli
    neovim
    stylua
    fzf
    nixfmt
    tree-sitter
    gcc
    unzip
    just
    tree
    wl-clipboard-rs
    git
    #browser
    firefox
    #terminal
    alacritty
  ];
}
