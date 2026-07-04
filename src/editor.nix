{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vscode.fhs
    neovim
    fzf
    ripgrep
    bat
    fd
    tree-sitter
    just
    nixfmt
    stylua
    prettier
    shfmt
    clang-tools
    clang
    cmake
  ];
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
