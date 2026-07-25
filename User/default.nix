{ pkgs, nixpkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    #cli
    vscode.fhs
    rustup
    neovim
    stylua
    devenv
    fzf
    nixfmt
    prettier
    tree-sitter
    gcc
    unzip
    just
    tree
    wl-clipboard-rs
    xclip
    git
    #browser
    firefox
    #terminal
    alacritty
  ];
}
