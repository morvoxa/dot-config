{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vscode.fhs
    neovim
    just
    nixfmt
    stylua
    fzf
    ripgrep
    fd
  ];
}
