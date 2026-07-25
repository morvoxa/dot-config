{ pkgs, nixpkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    #cli
    vscode.fhs
    neovim
    stylua
    devenv
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
